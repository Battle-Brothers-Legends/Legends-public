::mods_registerCSS("fu/css/misc.css");
::mods_registerCSS("fu/css/settings_screen.css");
::mods_registerCSS("fu/css/popup.css");

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
::mods_registerJS("fu/upload_company.js");
::mods_registerJS("fu/ui_screen.js");
::mods_registerJS("fu/popup.js");

// IO.enumerateFiles is a script API; register UI assets explicitly so their
// extensions and dependency order do not depend on archive enumeration.
foreach (file in [
	"array_setting", "boolean_setting", "button_setting", "color_picker_setting",
	"divider_setting", "enum_setting", "keybind_setting", "range_setting",
	"spacer_setting", "string_setting", "title_setting", "settings_screen"
])
{
	::mods_registerJS("fu/mod_settings/" + file + ".js");
}

// All screen constructors must be registered before connecting the backend.
::mods_registerJS("fu/connect_screens.js");


::FU.includeFile("scripts/fu/ui/", "ui.nut");

::FU.UI.JSConnection = ::new("scripts/mods/FU/FU_connection");
::FU.UI.registerConnection(::FU.UI.JSConnection);

// Popup will be created in bootstrap phase
if ("Popup" in ::FU)
{
    ::FU.UI.registerConnection(::FU.Popup);
}
