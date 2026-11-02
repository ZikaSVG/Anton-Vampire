const fs = require('fs');
const path = require('path');
const os = require('os');

class Logger {
  constructor(baseDir, config = null) {
    const dir = path.join(baseDir, 'logs');
    fs.mkdirSync(dir, { recursive: true });

    this.config = config;
    this.dir = dir;

    // Флаг из конфига — по умолчанию ВЫКЛЮЧЕНО
    this.enabled = !!(config && config.get('General.logs_enabled', false));

    let user = 'unknown';
    try { user = os.userInfo().username || 'unknown'; } catch { /* ignore */ }

    const ts = new Date().toISOString().replace(/[:T]/g, '-').slice(0, 19);
    this.logFile = path.join(dir, `${user}_log_${ts}.log`);
    this.errFile = path.join(dir, `${user}_errors_${ts}.log`);

    this._buf = [];
    this._flushTimer = null;
    this._flushing = false;
    this._closed = false;
  }

  /** Мгновенно включает/выключает запись логов. */
  setEnabled(v) {
    this.enabled = !!v;
  }

  _enqueue(file, line) {
    if (this._closed) return;
    if (!this.enabled) return;              // ← ГЛАВНОЕ: не пишем, если выключено
    this._buf.push({ file, line });
    if (this._buf.length >= 100) {
      this._flush();
    } else if (!this._flushTimer) {
      this._flushTimer = setTimeout(() => this._flush(), 200);
    }
  }

  _flush() {
    if (this._flushTimer) {
      clearTimeout(this._flushTimer);
      this._flushTimer = null;
    }
    if (this._flushing || !this._buf.length) return;
    this._flushing = true;

    const batch = this._buf;
    this._buf = [];

    const byFile = new Map();
    for (const { file, line } of batch) {
      if (!byFile.has(file)) byFile.set(file, []);
      byFile.get(file).push(line);
    }

    let pending = byFile.size;
    const done = () => {
      pending--;
      if (pending <= 0) {
        this._flushing = false;
        if (this._buf.length) this._flush();
      }
    };

    for (const [file, lines] of byFile) {
      fs.appendFile(file, lines.join(''), 'utf8', () => done());
    }
  }

  _write(file, level, msg) {
    const line = `[${new Date().toISOString()}] [${level}] ${msg}\n`;
    this._enqueue(file, line);
    // В консоль пишем только если логи включены
    if (!this.enabled) return;
    if (level === 'ERROR') console.error(line.trim());
    else console.log(line.trim());
  }

  info(m)  { this._write(this.logFile, 'INFO', String(m)); }
  warn(m)  { this._write(this.logFile, 'WARN', String(m)); }
  error(m) { this._write(this.errFile, 'ERROR', String(m)); }

  logProgramStart() { this.info('Программа запущена'); }

  logProgramExit() {
    this.info('Программа завершена');
    this._closed = true;
    if (this._flushTimer) {
      clearTimeout(this._flushTimer);
      this._flushTimer = null;
    }
    if (this._buf.length) {
      const byFile = new Map();
      for (const { file, line } of this._buf) {
        if (!byFile.has(file)) byFile.set(file, []);
        byFile.get(file).push(line);
      }
      for (const [file, lines] of byFile) {
        try { fs.appendFileSync(file, lines.join(''), 'utf8'); } catch { /* ignore */ }
      }
      this._buf = [];
    }
  }

  logTweak(name, p) { this.info(`Запущен твик: ${name} (${p})`); }
}

module.exports = { Logger };