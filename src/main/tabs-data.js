const fs = require('fs');
const path = require('path');

const EMPTY = {
  tabs_0: {}, tabs_main: {}, tabs: {}, tabs_1: {}, tabs_2: {},
  tabs_3: {}, tabs_4: {}, tabs_5: {}, tabs_6: {},
  tabs_update: {}, tabs_uninstall: {}, tabs_mini: {},
  tabs_qqnwr: {}
};

function loadTabsData(rootDir) {
  const jsonPath = path.join(rootDir, 'tweaks', 'tabs.json');
  if (!fs.existsSync(jsonPath)) {
    return { ok: false, error: 'tweaks/tabs.json не найден', ...EMPTY };
  }
  try {
    const data = JSON.parse(fs.readFileSync(jsonPath, 'utf8'));
    return { ok: true, ...EMPTY, ...data };
  } catch (e) {
    console.error('tabs.json parse error:', e);
    return { ok: false, error: 'tabs.json: ' + e.message, ...EMPTY };
  }
}

module.exports = { loadTabsData };