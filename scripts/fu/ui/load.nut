::mods_registerCSS("fu/css/misc.css");
::mods_registerCSS("fu/css/settings_screen.css");

::mods_registerJS("fu/utilities.js");

// Load keybinds system before connection files that depend on it
::mods_registerJS("fu/keybinds/key_static.js");
::mods_registerJS("fu/keybinds/keybind.js");
::mods_registerJS("fu/keybinds/keybinds_system.js");
::mods_registerJS("fu/keybinds/document_events.js");

::mods_registerJS("fu/ui_hooks/main_menu_module.js");
::mods_registerJS("fu/ui_hooks/main_menu_screen.js");
::mods_registerJS("fu/ui_hooks/tooltip_module.js");

::mods_registerJS("fu/backend_connection.js");
::mods_registerJS("fu/fu_connection.js");
::mods_registerJS("fu/ui_screen.js");

local _modSettingsFiles = ::IO.enumerateFiles("ui/mods/fu/mod_settings/");
::logInfo("FU: Found " + (_modSettingsFiles != null ? _modSettingsFiles.len() : 0) + " mod settings UI files");
if (_modSettingsFiles != null)
foreach (file in _modSettingsFiles)
{
	local splitFile = split(file, "/");
	local shortArray = splitFile.slice(2, splitFile.len());
	local shortenedString = shortArray.reduce(@(a, b) a + "/" + b);
	::logInfo("FU: Registering JS file: " + shortenedString + ".js");
	::mods_registerJS(shortenedString + ".js");
}


::FU.includeFile("scripts/fu/ui/", "ui.nut");

::FU.UI.JSConnection = ::new("scripts/mods/FU/FU_connection");
::FU.UI.registerConnection(::FU.UI.JSConnection);

// Popup will be created in bootstrap phase
if ("Popup" in ::FU)
{
    ::FU.UI.registerConnection(::FU.Popup);
}
