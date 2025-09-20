::mods_registerCSS("fu/css/misc.css");
::mods_registerCSS("fu/css/settings_screen.css");

::mods_registerJS("fu/utilities.js");

::mods_registerJS("fu/ui_hooks/main_menu_module.js");
::mods_registerJS("fu/ui_hooks/main_menu_screen.js");
::mods_registerJS("fu/ui_hooks/tooltip_module.js");

::mods_registerJS("fu/backend_connection.js");
::mods_registerJS("fu/fu_connection.js");
::mods_registerJS("fu/ui_screen.js");

local _modSettingsFiles = ::IO.enumerateFiles("ui/mods/fu/mod_settings/");
if (_modSettingsFiles != null)
foreach (file in _modSettingsFiles)
{
	local splitFile = split(file, "/");
	local shortArray = splitFile.slice(2, splitFile.len());
	local shortenedString = shortArray.reduce(@(a, b) a + "/" + b);
	::mods_registerJS(shortenedString + ".js");
}

::mods_registerJS("fu/keybinds/key_static.js");
::mods_registerJS("fu/keybinds/keybind.js");
::mods_registerJS("fu/keybinds/keybinds_system.js");
::mods_registerJS("fu/keybinds/document_events.js");


::FU.includeFile("scripts/fu/ui/", "ui.nut");

::FU.UI.JSConnection = ::new("scripts/mods/FU/FU_connection");
::FU.UI.registerConnection(::FU.UI.JSConnection);
