const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('api', {
  config: {
    get:    (k, d) => ipcRenderer.invoke('config:get', k, d),
    set:    (k, v) => ipcRenderer.invoke('config:set', k, v),
    getAll: ()     => ipcRenderer.invoke('config:getAll'),
    reset:  ()     => ipcRenderer.invoke('config:reset')
  },

  logger: {
    info:  (m) => ipcRenderer.invoke('logger:info', m),
    warn:  (m) => ipcRenderer.invoke('logger:warn', m),
    error: (m) => ipcRenderer.invoke('logger:error', m),
    setEnabled: (v) => ipcRenderer.invoke('logger:setEnabled', v)
  },

  apps: {
    list:   ()                 => ipcRenderer.invoke('apps:list'),
    remove: (packageFullName)  => ipcRenderer.invoke('apps:remove', packageFullName),
    detect: ()                 => ipcRenderer.invoke('apps:detect')
  },

  buildTabs: {
    run: (options) => ipcRenderer.invoke('buildTabs:run', options),
    onChunk: (cb) => {
      const listener = (_e, payload) => cb(payload);
      ipcRenderer.on('buildTabs:chunk', listener);
      return () => ipcRenderer.off('buildTabs:chunk', listener);
    }
  },

  buildTools: {
    list: () => ipcRenderer.invoke('buildTools:list'),
    run: (scriptName, options = {}) => ipcRenderer.invoke('buildTools:run', scriptName, options),
    onChunk: (cb) => {
      const listener = (_e, payload) => cb(payload);
      ipcRenderer.on('buildTabs:chunk', listener);
      return () => ipcRenderer.off('buildTabs:chunk', listener);
    }
  },

  tabs: {
    data:     ()      => ipcRenderer.invoke('tabs:data'),
    readJson: (rel)   => ipcRenderer.invoke('tabs:readJson', rel),
    scanDir:  (rel)   => ipcRenderer.invoke('tabs:scanDir', rel)
  },

  cursors: {
    list:         (force)          => ipcRenderer.invoke('cursors:list', force),
    download:     (name)           => ipcRenderer.invoke('cursors:download', name),
    install:      (name, roleHints)=> ipcRenderer.invoke('cursors:install', name, roleHints),
    activate:     (name, roleHints)=> ipcRenderer.invoke('cursors:activate', name, roleHints),
    uninstall:    (name)           => ipcRenderer.invoke('cursors:uninstall', name),
    uninstallAll: (names, defaults)=> ipcRenderer.invoke('cursors:uninstallAll', names, defaults),
    openFolder:   ()               => ipcRenderer.invoke('cursors:openFolder')
  },

  tweaks: {
    run:          (p, o)  => ipcRenderer.invoke('tweaks:run', p, o),
    runCommand:   (c, o)  => ipcRenderer.invoke('tweaks:runCommand', c, o),
    runMany:      (ps, o) => ipcRenderer.invoke('tweaks:runMany', ps, o),
    probe:        (p)     => ipcRenderer.invoke('tweaks:probe', p),
    listDir:      (p)     => ipcRenderer.invoke('tweaks:listDir', p),
    listDirs:     (ps)    => ipcRenderer.invoke('tweaks:listDirs', ps),
    listDirRecursive: (p) => ipcRenderer.invoke('tweaks:listDirRecursive', p),
    describe:     (p)     => ipcRenderer.invoke('tweaks:describe', p),
    describeMany: (ps)    => ipcRenderer.invoke('tweaks:describeMany', ps),

    runStream: (relPath, handlers = {}) => {
      const { onData = () => {}, onEnd = () => {} } = handlers;
      const id = `stream_${Date.now()}_${Math.random().toString(36).slice(2, 8)}`;

      let cleaned = false;
      const cleanup = () => {
        if (cleaned) return;
        cleaned = true;
        ipcRenderer.off('tweaks:stream-data', dataListener);
        ipcRenderer.off('tweaks:stream-end', endListener);
      };

      const dataListener = (_e, payload) => { if (payload.id !== id) return; onData(payload.chunk); };
      const endListener = (_e, payload) => {
        if (payload.id !== id) return;
        cleanup();
        onEnd(payload);
      };

      ipcRenderer.on('tweaks:stream-data', dataListener);
      ipcRenderer.on('tweaks:stream-end', endListener);

      return ipcRenderer.invoke('tweaks:runStream', relPath, id).catch((err) => {
        cleanup();
        throw err;
      });
    },

    runCommandStream: (cmd, handlers = {}) => {
      const { onData = () => {}, onEnd = () => {} } = handlers;
      const id = `cmd_${Date.now()}_${Math.random().toString(36).slice(2, 8)}`;

      let cleaned = false;
      const cleanup = () => {
        if (cleaned) return;
        cleaned = true;
        ipcRenderer.off('tweaks:stream-data', dataListener);
        ipcRenderer.off('tweaks:stream-end', endListener);
      };

      const dataListener = (_e, payload) => { if (payload.id !== id) return; onData(payload.chunk); };
      const endListener = (_e, payload) => {
        if (payload.id !== id) return;
        cleanup();
        onEnd(payload);
      };

      ipcRenderer.on('tweaks:stream-data', dataListener);
      ipcRenderer.on('tweaks:stream-end', endListener);

      return ipcRenderer.invoke('tweaks:runCommandStream', cmd, id).catch((err) => {
        cleanup();
        throw err;
      });
    }
  },

  security: {
    audit: (kind) => ipcRenderer.invoke('security:audit', kind),
    onAuditChunk: (cb) => {
      const listener = (_e, payload) => cb(payload);
      ipcRenderer.on('security:audit-chunk', listener);
      return () => ipcRenderer.off('security:audit-chunk', listener);
    },
    firewallStatus: () => ipcRenderer.invoke('security:firewallStatus'),
    setFirewallStatus: (enabled) => ipcRenderer.invoke('security:setFirewallStatus', enabled)
  },

  firewall: {
    list:    ()                  => ipcRenderer.invoke('firewall:list'),
    add:     (exePath, action)   => ipcRenderer.invoke('firewall:add', exePath, action),
    set:     (exePath, action)   => ipcRenderer.invoke('firewall:set', exePath, action),
    remove:  (exePath)           => ipcRenderer.invoke('firewall:remove', exePath),
    pickExe: ()                  => ipcRenderer.invoke('firewall:pickExe')
  },

  comfort: {
    getState: ()              => ipcRenderer.invoke('comfort:getState'),
    setItem:  (item, enabled) => ipcRenderer.invoke('comfort:setItem', item, enabled)
  },

  netmon: {
    snapshot: () => ipcRenderer.invoke('netmon:snapshot'),
    ports: () => ipcRenderer.invoke('netmon:ports'),
    resolveHost: (ip, mode) => ipcRenderer.invoke('netmon:resolveHost', ip, mode)
  },

  startup: {
    list:     (force) => ipcRenderer.invoke('startup:list', force),
    describe: (id)    => ipcRenderer.invoke('startup:describe', id),
    enable:   (id)    => ipcRenderer.invoke('startup:enable', id),
    disable:  (id)    => ipcRenderer.invoke('startup:disable', id),
    delete:   (id)    => ipcRenderer.invoke('startup:delete', id)
  },

  shell: {
    openExternal: (u) => ipcRenderer.invoke('shell:openExternal', u),
    openPath:     (p) => ipcRenderer.invoke('shell:openPath', p),
    deleteFile: (p) => ipcRenderer.invoke('shell:deleteFile', p),
    saveHtmlReport: (html, name) => ipcRenderer.invoke('shell:saveHtmlReport', html, name)
  },

  dialog: {
    pickFile:   (o) => ipcRenderer.invoke('dialog:pickFile', o),
    pickFiles:  (o) => ipcRenderer.invoke('dialog:pickFiles', o),
    pickFolder: (o) => ipcRenderer.invoke('dialog:pickFolder', o)
  },

  window: {
    minimize:         () => ipcRenderer.invoke('window:minimize'),
    maximize:         () => ipcRenderer.invoke('window:maximize'),
    isMaximized:      () => ipcRenderer.invoke('window:isMaximized'),
    toggleFullscreen: () => ipcRenderer.invoke('window:toggleFullscreen'),
    close:            () => ipcRenderer.invoke('window:close'),
    setBackgroundMaterial: (m) => ipcRenderer.invoke('window:setBackgroundMaterial', m),
    onMaximizedChange: (cb) => {
      const listener = (_e, isMax) => cb(isMax);
      ipcRenderer.on('window:maximized-changed', listener);
      return () => ipcRenderer.off('window:maximized-changed', listener);
    }
  },

  app: {
    version:       () => ipcRenderer.invoke('app:version'),
    userDataPath:  () => ipcRenderer.invoke('app:userDataPath'),
    rootDir:       () => ipcRenderer.invoke('app:rootDir'),
    portableDir:   () => ipcRenderer.invoke('app:portableDir'),
    username:      () => ipcRenderer.invoke('app:username'),
    icon:          () => ipcRenderer.invoke('app:icon'),
    isAdmin:       () => ipcRenderer.invoke('app:isAdmin')
  },

  background: {
    save:    (p) => ipcRenderer.invoke('background:save', p),
    clear:   ()  => ipcRenderer.invoke('background:clear'),
    get:     ()  => ipcRenderer.invoke('background:get'),
    default: ()  => ipcRenderer.invoke('background:default')
  },

  wallpapers: {
    list:        ()            => ipcRenderer.invoke('wallpapers:list'),
    addFromFile: (p)           => ipcRenderer.invoke('wallpapers:addFromFile', p),
    addFromUrl:  (u, nameHint) => ipcRenderer.invoke('wallpapers:addFromUrl', u, nameHint),
    remove:      (p)           => ipcRenderer.invoke('wallpapers:remove', p),
    openFolder:  ()            => ipcRenderer.invoke('wallpapers:openFolder')
  },

  hardware: {
    stats: () => ipcRenderer.invoke('hardware:stats')
  }
});