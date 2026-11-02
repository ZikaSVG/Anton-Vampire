const { spawn } = require('child_process');
const path = require('path');
const fs = require('fs');
const os = require('os');
const { TextDecoder } = require('util');

const decoder = new TextDecoder('utf-8', { fatal: false });
const decoderCp866 = new TextDecoder('ibm866', { fatal: false });

const EXIT_DRAIN_MS = 1000;
const TEMP_PREFIX = '_extreme_patch_';

class TweakRunner {
  constructor({ rootDir, config, logger }) {
    this.rootDir = path.resolve(rootDir);
    this.utilsDir = path.join(this.rootDir, 'Utils');
    this.config = config;
    this.logger = logger;
  }

  _mode() {
    return this.config.get('General.tweak_execution_mode', 'default');
  }

  _timeoutMs() {
    const v = Number(this.config.get('General.tweak_timeout_ms', 300000));
    return Number.isFinite(v) && v > 0 ? v : 300000;
  }

  resolveSafe(relPath) {
    const abs = path.resolve(this.rootDir, relPath);
    const rel = path.relative(this.rootDir, abs);
    if (rel.startsWith('..') || path.isAbsolute(rel)) {
      throw new Error(`Недопустимый путь (выход за пределы rootDir): ${relPath}`);
    }
    return abs;
  }

  _resolveSafe(relPath) { return this.resolveSafe(relPath); }
  _util(name) { return path.join(this.utilsDir, name); }
  _hasUtil(name) { return fs.existsSync(this._util(name)); }

  probe(relPath) {
    try {
      const abs = this.resolveSafe(relPath);
      const exists = fs.existsSync(abs);
      let hasStart = false;

      if (exists && /\.(bat|cmd)$/i.test(abs)) {
        try {
          const raw = fs.readFileSync(abs);
          const text = this._decodeBat(raw);
          hasStart = /^[ \t]*start(\s|$)/im.test(text);
        } catch { /* ignore */ }
      }

      return { exists, abs, rootDir: this.rootDir, hasStart };
    } catch (e) {
      return { exists: false, abs: null, error: e.message, rootDir: this.rootDir, hasStart: false };
    }
  }

  _decodeBat(raw) {
    if (raw.length >= 2 && raw[0] === 0xFF && raw[1] === 0xFE) {
      return raw.slice(2).toString('utf16le');
    }
    if (raw.length >= 2 && raw[0] === 0xFE && raw[1] === 0xFF) {
      const swapped = Buffer.alloc(raw.length - 2);
      for (let i = 2; i < raw.length; i += 2) {
        swapped[i - 2] = raw[i + 1];
        swapped[i - 1] = raw[i];
      }
      return swapped.toString('utf16le');
    }
    let utf8 = raw.toString('utf8');
    if (utf8.charCodeAt(0) === 0xFEFF) utf8 = utf8.slice(1);
    if (!utf8.includes('\uFFFD')) return utf8;
    return decoderCp866.decode(raw);
  }

  async run(relPath, options = {}) {
    const abs = this.resolveSafe(relPath);
    const exists = fs.existsSync(abs);

    this.logger.info(
      `[run] rel="${relPath}" abs="${abs}" exists=${exists} ` +
      `visible=${!!options.visible} wait=${!!options.wait} mode=${options.mode || this._mode()}`
    );

    if (!exists) {
      const msg = `Файл не найден: ${abs}`;
      this.logger.error(msg);
      throw new Error(msg);
    }

    this.logger.logTweak(path.basename(abs), abs);

    if (options.visible) return this._launchVisible(abs);

    const ext = path.extname(abs).toLowerCase();
    const mode = options.mode || this._mode();
    const detached = !options.wait;
    const cwd = path.dirname(abs);

    switch (ext) {
      case '.bat':
      case '.cmd': return this._runCmd(abs, mode, detached, cwd);
      case '.ps1': return this._runPs1(abs, mode, detached, cwd);
      case '.reg': return this._runReg(abs, mode, cwd);
      case '.pow': return this._runPow(abs, cwd);
      case '.exe': return this._runExe(abs, mode, detached, cwd);
      default:     return this._runCmd(abs, mode, detached, cwd);
    }
  }

  _buildStreamCommand(abs, mode) {
    const ext = path.extname(abs).toLowerCase();
    const cwd = path.dirname(abs);

    if (ext === '.bat' || ext === '.cmd') {
      const tempFile = this._makePatchedBat(abs);
      return this._withModeForBat(tempFile, mode, cwd);
    }

    if (ext === '.ps1') {
      const psArgs = ['-ExecutionPolicy', 'Bypass', '-NoProfile', '-File', abs];
      return this._withModeForPs1(psArgs, mode, cwd);
    }

    if (ext === '.reg') {
      if (mode === 'powerrun' && this._hasUtil('PowerRun.exe')) {
        return { cmd: this._util('PowerRun.exe'), args: [abs], tempFile: null, cwd };
      }
      return { cmd: 'reg.exe', args: ['import', abs], tempFile: null, cwd };
    }

    if (ext === '.pow') {
      return { cmd: 'powercfg.exe', args: ['/import', abs], tempFile: null, cwd };
    }

    if (ext === '.exe') {
      return { cmd: abs, args: [], tempFile: null, cwd };
    }

    const tempFile = this._makePatchedBat(abs);
    return this._withModeForBat(tempFile, mode, cwd);
  }

  _withModeForBat(tempFile, mode, cwd) {
    return { cmd: 'cmd.exe', args: ['/c', tempFile], tempFile, cwd };
  }

  _withModeForPs1(psArgs, mode, cwd) {
    return { cmd: 'powershell.exe', args: psArgs, tempFile: null, cwd };
  }

  runStream(relPath, onChunk = () => {}, onEnd = () => {}) {
    return new Promise((resolve) => {
      let abs;
      try {
        abs = this.resolveSafe(relPath);
      } catch (e) {
        const msg = `Недопустимый путь: ${relPath}`;
        onChunk(`[ERROR] ${msg}\n`);
        onEnd({ code: -1 });
        return resolve({ code: -1, error: msg });
      }

      if (!fs.existsSync(abs)) {
        const msg = `Файл не найден: ${abs}`;
        onChunk(`[ERROR] ${msg}\n`);
        onEnd({ code: -1 });
        return resolve({ code: -1, error: msg });
      }

      const mode = this._mode();
      const timeoutMs = this._timeoutMs();
      this.logger.info(`[runStream] rel="${relPath}" abs="${abs}" mode=${mode} timeout=${timeoutMs}ms`);

      let cmd, args, tempFile, cwd;
      try {
        const built = this._buildStreamCommand(abs, mode);
        cmd = built.cmd;
        args = built.args;
        tempFile = built.tempFile;
        cwd = built.cwd;

        onChunk(`[stream] ${path.basename(cmd)} ${args.join(' ')}\n\n`);
      } catch (e) {
        onChunk(`[ERROR] Не удалось подготовить команду: ${e.message}\n`);
        onEnd({ code: -1 });
        return resolve({ code: -1, error: e.message });
      }

      let child;
      try {
        child = spawn(cmd, args, {
          windowsHide: true,
          cwd,
          env: { ...process.env, PYTHONIOENCODING: 'utf-8' }
        });
      } catch (e) {
        onChunk(`[ERROR] spawn failed: ${e.message}\n`);
        this._scheduleTempCleanup(tempFile);
        onEnd({ code: -1, error: e.message });
        return resolve({ code: -1, error: e.message });
      }

      let finished = false;
      let exitCode = null;
      let killTimer = null;
      let drainTimer = null;

      const finalize = (code, viaTimeout = false) => {
        if (finished) return;
        finished = true;
        if (killTimer) clearTimeout(killTimer);
        if (drainTimer) clearTimeout(drainTimer);

        this._scheduleTempCleanup(tempFile);

        if (viaTimeout) {
          onChunk(`\n[!] Таймаут ${timeoutMs / 1000}с — процесс убит принудительно\n`);
        }
        onChunk(`\n[process exited with code ${code}]\n`);
        onEnd({ code: viaTimeout ? -2 : code });
        resolve({ code: viaTimeout ? -2 : code });
      };

      killTimer = setTimeout(() => {
        if (finished) return;
        this.logger.warn(`[runStream] timeout ${timeoutMs}ms, killing pid=${child.pid}`);
        try { child.kill('SIGKILL'); } catch { /* ignore */ }
        setTimeout(() => finalize(-2, true), 200);
      }, timeoutMs);

      const pushChunk = (buf) => {
        let text = decoder.decode(buf);
        if (text.includes('\uFFFD')) text = decoderCp866.decode(buf);
        onChunk(text);
      };

      child.stdout?.on('data', pushChunk);
      child.stderr?.on('data', pushChunk);

      child.on('error', (err) => {
        onChunk(`[ERROR] ${err.message}\n`);
        finalize(-1);
      });

      child.on('exit', (code) => {
        exitCode = (code == null) ? -1 : code;
        drainTimer = setTimeout(() => finalize(exitCode), EXIT_DRAIN_MS);
      });

      child.on('close', (code) => {
        if (finished) return;
        const c = (code == null) ? (exitCode == null ? -1 : exitCode) : code;
        finalize(c);
      });
    });
  }

  runCommandStream(cmd, onChunk = () => {}, onEnd = () => {}) {
    return new Promise((resolve) => {
      const timeoutMs = this._timeoutMs();
      this.logger.info(`[runCommandStream] cmd="${cmd}" timeout=${timeoutMs}ms`);
      onChunk(`[cmd] > ${cmd}\n\n`);

      const child = spawn('cmd.exe', ['/c', cmd], {
        windowsHide: true,
        env: { ...process.env, PYTHONIOENCODING: 'utf-8' }
      });

      let finished = false;
      let exitCode = null;
      let killTimer = null;
      let drainTimer = null;

      const finalize = (code, viaTimeout = false) => {
        if (finished) return;
        finished = true;
        if (killTimer) clearTimeout(killTimer);
        if (drainTimer) clearTimeout(drainTimer);

        if (viaTimeout) {
          onChunk(`\n[!] Таймаут ${timeoutMs / 1000}с — процесс убит принудительно\n`);
        }
        onChunk(`\n[process exited with code ${code}]\n`);
        onEnd({ code: viaTimeout ? -2 : code });
        resolve({ code: viaTimeout ? -2 : code });
      };

      killTimer = setTimeout(() => {
        if (finished) return;
        this.logger.warn(`[runCommandStream] timeout, killing pid=${child.pid}`);
        try { child.kill('SIGKILL'); } catch { /* ignore */ }
        setTimeout(() => finalize(-2, true), 200);
      }, timeoutMs);

      const pushChunk = (buf) => {
        let text = decoder.decode(buf);
        if (text.includes('\uFFFD')) text = decoderCp866.decode(buf);
        onChunk(text);
      };

      child.stdout?.on('data', pushChunk);
      child.stderr?.on('data', pushChunk);

      child.on('error', (err) => {
        onChunk(`[ERROR] ${err.message}\n`);
        finalize(-1);
      });

      child.on('exit', (code) => {
        exitCode = (code == null) ? -1 : code;
        drainTimer = setTimeout(() => finalize(exitCode), EXIT_DRAIN_MS);
      });

      child.on('close', (code) => {
        if (finished) return;
        const c = (code == null) ? (exitCode == null ? -1 : exitCode) : code;
        finalize(c);
      });
    });
  }

  _scheduleTempCleanup(tempFile) {
    if (!tempFile) return;

    const tryUnlink = () => {
      try {
        if (fs.existsSync(tempFile)) {
          fs.unlinkSync(tempFile);
        }
        return true;
      } catch {
        return false;
      }
    };

    if (tryUnlink()) {
      this.logger.info(`[tempCleanup] удалён сразу: ${tempFile}`);
      return;
    }

    let attempts = 0;
    const maxAttempts = 100;
    const interval = setInterval(() => {
      attempts++;
      if (tryUnlink()) {
        this.logger.info(`[tempCleanup] удалён с попытки ${attempts}: ${tempFile}`);
        clearInterval(interval);
        return;
      }
      if (attempts >= maxAttempts) {
        this.logger.warn(`[tempCleanup] не удалось удалить "${tempFile}" за ${attempts} попыток`);
        clearInterval(interval);
      }
    }, 100);
    interval.unref?.();
  }

  _stripInteractiveCommands(src) {
    let removed = 0;

    src = src.split(/\r?\n/).map((line) => {
      const trimmed = line.replace(/^[ \t]+/, '');

      if (/^pause(\s*[12]?>\s*nul)?\s*$/i.test(trimmed)) {
        removed++;
        return 'rem [pause removed]';
      }

      if (/^timeout\s+(\/t\s+\d+|\/nobreak)(\s+\/nobreak|\s+\/t\s+\d+)*(\s*[12]?>\s*nul)?\s*$/i.test(trimmed)) {
        removed++;
        return 'rem [timeout removed]';
      }

      if (/^choice(\s+\/[a-z0-9]+(\s+\S+)?)+\s*$/i.test(trimmed)) {
        removed++;
        return 'rem [choice removed]';
      }

      return line;
    }).join('\r\n');

    if (removed > 0) {
      this.logger.info(`[_stripInteractiveCommands] вырезано интерактивных команд: ${removed}`);
    }
    return src;
  }

  _makePatchedBat(abs) {
    const origDir  = path.dirname(abs);
    const origFile = abs;
    const origName = path.basename(abs, path.extname(abs));

    const raw = fs.readFileSync(abs);
    let src = this._decodeBat(raw);

    /* Убираем BOM и «невидимые» префиксы в начале */
    src = src.replace(/^\uFEFF+/, '');
    src = src.replace(/\uFEFF/g, '');

    src = src.replace(/^[ \t]*@?echo[ \t]+off[ \t]*\r?$/gim, '');
    src = src.replace(/^[ \t]*chcp[ \t]+\d+[ \t]*>?nul[ \t]*\r?$/gim, '');
    src = src.replace(/^[ \t]*chcp[ \t]+\d+[ \t]*\r?$/gim, '');

    src = this._stripInteractiveCommands(src);

    const escDir  = origDir.replace(/%/g, '%%').replace(/&/g, '^&');
    const escFile = origFile.replace(/%/g, '%%').replace(/&/g, '^&');
    const escName = origName.replace(/%/g, '%%').replace(/&/g, '^&');

    src = src.replace(/%~dp0/gi, escDir + '\\');
    src = src.replace(/%~f0/gi,  escFile);
    src = src.replace(/%~n0/gi,  escName);

    let patchedCount = 0;
    src = src.replace(
      /^([ \t]*)start(\s+)(.*)$/gim,
      (match, indent, space, rest) => {
        patchedCount++;
        const trimmed = rest.trim();
        if (!trimmed) return match;

        const hasB = /^\/b(\s|$)/i.test(trimmed);
        const firstMatch = trimmed.match(/^("(?:[^"]*)"|\S+)/);
        if (!firstMatch) return match;
        const firstToken = firstMatch[1];
        const afterFirst = trimmed.slice(firstToken.length);

        let isTitle = false;
        if (firstToken.startsWith('"')) {
          const inner = firstToken.slice(1, -1);
          const looksLikePath = /[\\\/]/.test(inner) || /^[a-zA-Z]:/.test(inner);
          const hasMoreArgs = afterFirst.trim().length > 0;
          if (looksLikePath && !hasMoreArgs) isTitle = false;
          else if (hasMoreArgs) isTitle = true;
          else isTitle = true;
        }

        let newRest;
        if (hasB) newRest = trimmed;
        else if (isTitle) newRest = `/b ${trimmed}`;
        else newRest = `/b "" ${trimmed}`;

        return `${indent}start${space}${newRest}`;
      }
    );
    if (patchedCount > 0) {
      this.logger.info(`[_makePatchedBat] пропатчено start-строк: ${patchedCount}`);
    }

    const header =
      '@echo off\r\n' +
      'chcp 65001 >nul\r\n' +
      `cd /d "${origDir}"\r\n`;

    const footer = '\r\nexit /b 0\r\n';

    src = header + src + footer;

    /* ВАЖНО: патченный .bat кладём РЯДОМ с оригиналом (в origDir),
       а не в %TEMP%. Причина: .bat часто вызывает соседние файлы
       (module.ps1, helper.bat, config.ini) по относительному пути
       или через %~dp0. В %TEMP% их нет — .bat падает с «файл не
       найден». Рядом с оригиналом все соседи на месте, cwd и %~dp0
       указывают на реальную папку.

       Имя `_extreme_patch_<name>_<unique>.bat`:
         - cleanOrphanTempBats() в main.js подчищает такие при старте;
         - isTweakFile() не считает его твиком (TWEAK_RE + isTempPatchName);
         - _scheduleTempCleanup() удаляет после завершения.

       Fallback на %TEMP% — если папка read-only (маловероятно). */
    const base = path.basename(abs).replace(/\.[^.]+$/, '');
    const unique = `${Date.now()}_${Math.random().toString(36).slice(2, 8)}`;
    const fileName = `${TEMP_PREFIX}${base}_${unique}.bat`;

    let tempFile = path.join(origDir, fileName);

    /* UTF-8 БЕЗ BOM — cmd.exe не понимает BOM. */
    const body = Buffer.from(src, 'utf8');

    try {
      fs.writeFileSync(tempFile, body);
      this.logger.info(`[_makePatchedBat] "${abs}" → "${tempFile}" (utf-8 no BOM, рядом с оригиналом)`);
    } catch (e) {
      this.logger.warn(`[_makePatchedBat] не удалось записать рядом с оригиналом (${e.message}), fallback в %TEMP%`);
      tempFile = path.join(os.tmpdir(), fileName);
      fs.writeFileSync(tempFile, body);
      this.logger.info(`[_makePatchedBat] "${abs}" → "${tempFile}" (utf-8 no BOM, %TEMP% fallback)`);
    }

    return tempFile;
  }

  async runCommand(cmd, options = {}) {
    this.logger.info(`[runCommand] cmd="${cmd}"`);
    const detached = !options.wait;
    const args = ['/c', cmd];
    return detached
      ? this._launchDetached('cmd.exe', args)
      : this._spawn('cmd.exe', args);
  }

  _launchVisible(abs) {
    const cwd = path.dirname(abs);
    const ext = path.extname(abs).toLowerCase();

    let cmd, args;

    if (ext === '.ps1') {
      cmd = 'cmd.exe';
      args = ['/k', 'powershell', '-ExecutionPolicy', 'Bypass', '-NoProfile', '-File', abs];
    } else if (ext === '.exe') {
      cmd = abs;
      args = [];
    } else {
      cmd = 'cmd.exe';
      args = ['/k', abs];
    }

    this.logger.info(`[launchVisible] spawn ${cmd} ${JSON.stringify(args)} cwd="${cwd}"`);

    let child;
    try {
      child = spawn(cmd, args, {
        detached: true,
        stdio: 'ignore',
        windowsHide: false,
        cwd
      });
    } catch (e) {
      this.logger.error(`[launchVisible] spawn failed: ${e.message}`);
      throw e;
    }

    child.on('error', (e) => {
      this.logger.error(`[launchVisible] child error: ${e.message}`);
    });

    child.unref();
    return { code: 0, out: '', err: '', detached: true, visible: true };
  }

  _spawn(cmd, args, opts = {}) {
    return new Promise((resolve, reject) => {
      let child;
      try {
        child = spawn(cmd, args, { windowsHide: true, ...opts });
      } catch (e) {
        return reject(e);
      }
      let out = '', err = '';
      child.stdout?.on('data', d => { out += d.toString(); });
      child.stderr?.on('data', d => { err += d.toString(); });
      child.on('error', reject);
      child.on('close', code => resolve({ code, out, err }));
    });
  }

  _launchDetached(cmd, args, cwd) {
    const child = spawn(cmd, args, {
      detached: true,
      stdio: 'ignore',
      windowsHide: true,
      cwd
    });
    child.unref();
    return { code: 0, out: '', err: '', detached: true };
  }

  _fallbackCmd(abs, detached, cwd) {
    return detached
      ? this._launchDetached('cmd.exe', ['/c', abs], cwd)
      : this._spawn('cmd.exe', ['/c', abs], { cwd });
  }

  async _runCmd(abs, mode, detached, cwd) {
    switch (mode) {
      case 'no_launcher':
      case 'cmd':
        return detached
          ? this._launchDetached('cmd.exe', ['/c', abs], cwd)
          : this._spawn('cmd.exe', ['/c', abs], { cwd });

      case 'powerrun':
        if (!this._hasUtil('PowerRun.exe')) return this._fallbackCmd(abs, detached, cwd);
        return detached
          ? this._launchDetached(this._util('PowerRun.exe'), [abs], cwd)
          : this._spawn(this._util('PowerRun.exe'), [abs], { cwd });

      case 'launcher':
        if (!this._hasUtil('launcher.exe')) return this._fallbackCmd(abs, detached, cwd);
        return detached
          ? this._launchDetached(this._util('launcher.exe'), [abs], cwd)
          : this._spawn(this._util('launcher.exe'), [abs], { cwd });

      case 'nsudolg':
        if (!this._hasUtil('NSudoLG.exe')) return this._fallbackCmd(abs, detached, cwd);
        return detached
          ? this._launchDetached(this._util('NSudoLG.exe'), ['-U:T', '-P:E', '-ShowWindowMode:Hide', '-Wait', 'cmd.exe', '/c', abs], cwd)
          : this._spawn(this._util('NSudoLG.exe'), ['-U:T', '-P:E', '-ShowWindowMode:Hide', '-Wait', 'cmd.exe', '/c', abs], { cwd });

      default: {
        if (detached) {
          this._launchDetached('cmd.exe', ['/c', abs], cwd);
          if (this._hasUtil('launcher.exe')) {
            this._launchDetached(this._util('launcher.exe'), [abs], cwd);
          }
          return { code: 0, out: '', err: '', detached: true };
        }
        return this._spawn('cmd.exe', ['/c', abs], { cwd });
      }
    }
  }

  async _runPs1(abs, mode, detached, cwd) {
    const args = ['-ExecutionPolicy', 'Bypass', '-NoProfile', '-File', abs];
    return detached
      ? this._launchDetached('powershell.exe', args, cwd)
      : this._spawn('powershell.exe', args, { cwd });
  }

  async _runReg(abs, mode, cwd) {
    if (mode === 'powerrun' && this._hasUtil('PowerRun.exe')) {
      return this._spawn(this._util('PowerRun.exe'), [abs], { cwd });
    }
    return this._spawn('reg.exe', ['import', abs], { cwd });
  }

  async _runPow(abs, cwd) {
    return this._spawn('powercfg.exe', ['/import', abs], { cwd });
  }

  async _runExe(abs, mode, detached, cwd) {
    return detached
      ? this._launchDetached(abs, [], cwd)
      : this._spawn(abs, [], { cwd });
  }
}

module.exports = { TweakRunner };