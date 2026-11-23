const assert = require('node:assert/strict');
const fs = require('node:fs');
const vm = require('node:vm');

const assets = fs.readFileSync('build/fu-check/ui-assets.txt', 'utf8').trim().split('\n');
assert.equal(new Set(assets).size, assets.length, 'duplicate UI asset registration');
for (const entry of assets) {
    const [, path] = entry.split(' ');
    assert(fs.existsSync('ui/mods/' + path), 'Missing registered asset: ' + path);
}
assert(assets.includes('js fu/popup.js'));
assert(assets.includes('css fu/css/popup.css'));
const popupCSS = fs.readFileSync('ui/mods/fu/css/popup.css', 'utf8');
assert(popupCSS.includes('.FU-popup {'));
assert(popupCSS.includes('.FU-mod-info-container'));
assert(!popupCSS.includes('.msu-'));
assert.equal(assets.at(-1), 'js fu/connect_screens.js');
assert(assets.indexOf('js fu/ui_screen.js') < assets.indexOf('js fu/mod_settings/settings_screen.js'));

let registered;
const context = vm.createContext({
    registerScreen: (name, screen) => { registered = { name, screen }; },
    $: html => html,
});
vm.runInContext(fs.readFileSync('ui/mods/fu/popup.js', 'utf8'), context);
assert.equal(registered.name, 'FUPopup');
const popup = registered.screen;
let title, content, forceQuit = 0, shows = 0;
popup.mTitle = { text: value => { title = value; } };
popup.mFooterContainer = { find: () => ({ trigger: event => {
    assert.equal(event, 'force-quit'); forceQuit++;
} }) };
popup.mListScrollContainer = { append: value => { content = value; } };
popup.isVisible = () => false;
popup.show = () => { shows++; };

const payload = JSON.parse(fs.readFileSync('build/fu-check/popup-payload.json', 'utf8'));
popup.showRawText(payload);
assert.equal(title, 'Fatal Mod Error');
assert.equal(forceQuit, 1);
assert(content.includes('Fatal test'));
assert(!content.includes('undefined'));
assert.equal(shows, 1);
console.log(`PASS: ${assets.length} UI registrations and Squirrel → JS popup payload`);
