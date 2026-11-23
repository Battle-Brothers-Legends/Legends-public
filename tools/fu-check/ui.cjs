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

// Legends UI uses FU directly; this context intentionally has no MSU global.
const nodes = [];
const calls = [];
function element(html = '') {
    const node = {
        html, events: {},
        css() { return this; }, append() { return this; },
        iCheck(value) { this.checked = value; return this; },
        click(fn) { this.clickHandler = fn; return this; },
        bindTooltip(data) { this.tooltip = data; return this; },
        on(events, fn) { this.events[events] = fn; return this; },
    };
    nodes.push(node);
    return node;
}
const native = vm.createContext({
    FU: {}, Screens: {}, $: element,
    registerScreen(name, screen) { this.Screens[name] = screen; },
    SQ: { call(...args) { calls.push(args); } },
    TooltipModule: function() {},
    console,
});
// registerScreen is called as a global function by the UI scripts.
native.registerScreen = (name, screen) => { native.Screens[name] = screen; };
native.TooltipModule.prototype.notifyBackendQueryTooltipData = function() { calls.push(['vanilla']); };
for (const path of [
    'ui/mods/fu/backend_connection.js', 'ui/mods/fu/ui_screen.js',
    'ui/mods/fu/mod_settings/settings_screen.js',
    'ui/mods/fu/keybinds/key_static.js', 'ui/mods/fu/keybinds/keybind.js',
    'ui/mods/fu/keybinds/keybinds_system.js',
    'ui/mods/fu/ui_hooks/tooltip_module.js',
    'ui/screens/world/world_obituary_screen.js',
]) vm.runInContext(fs.readFileSync(path, 'utf8'), native, { filename: path });
const settings = native.Screens.ModSettingsScreen;
settings.mSQHandle = 'settings';
settings.mModSettings.mod_legends = { settings: { SwapPerks: { value: true } } };
settings.mModSettings.mod_FU = { settings: { keybindsLog: { value: false } } };
native.FU.Keybinds.addKeybindFromSQ('mod_legends', 'toggle_perks', 'p');
assert.equal(native.FU.Keybinds.isKeybindPressed('mod_legends', 'toggle_perks', { keyCode: 80 }), true);
assert.equal(native.FU.Keybinds.isKeybindPressed('mod_legends', 'toggle_perks', { keyCode: 79 }), false);
const obituary = new native.WorldObituaryScreen();
obituary.mDialogContainer = element();
let toggled;
obituary.createToggleCheckbox('SwapPerks', 'Show Perks', value => { toggled = value; });
const checkbox = nodes.find(node => node.html.startsWith('<input'));
assert.equal(checkbox.checked, 'check');
checkbox.events['ifChecked ifUnchecked']({ type: 'ifUnchecked' });
assert.equal(toggled, false);
assert.equal(native.FU.getSettingValue('mod_legends', 'SwapPerks'), false);
assert.equal(calls.at(-1)[1], 'updateSettingFromJS');
assert.equal(calls.at(-1)[2].mod, 'mod_legends');
assert.equal(calls.at(-1)[2].value, false);
const tooltipModule = new native.TooltipModule();
tooltipModule.mSQHandle = 'tooltip';
const tooltipRequest = { contentType: 'FU-generic', modId: 'mod_legends', elementId: 'CombatResult.Sort' };
tooltipModule.notifyBackendQueryTooltipData(tooltipRequest, () => {});
assert.equal(calls.at(-1)[1], 'onQueryFUTooltipData');
assert.equal(calls.at(-1)[2], tooltipRequest);
tooltipModule.notifyBackendQueryTooltipData({ contentType: 'ui-element' }, () => {});
assert.deepEqual(calls.at(-1), ['vanilla']);
assert.equal(typeof native.MSU, 'undefined');
vm.runInContext(fs.readFileSync('ui/mods/legends/popup.js', 'utf8'), native);
assert.equal(native.Screens.LegendsDependencyPopup.mID, 'LegendsDependencyPopup');
console.log('PASS: Legends settings, tooltip routing and dependency popup work without MSU JavaScript');
