// FU IO utilities for file system operations
::FU.IO <- {};

// Enumerate files in a directory path
::FU.IO.enumerateFiles <- function( _path )
{
    // Handle specific directories that are needed by FU
    if (_path == "scripts/fu/systems/mod_settings/elements/")
    {
        return [
            "scripts/fu/systems/mod_settings/elements/array_setting.nut",
            "scripts/fu/systems/mod_settings/elements/boolean_setting.nut",
            "scripts/fu/systems/mod_settings/elements/button_setting.nut",
            "scripts/fu/systems/mod_settings/elements/color_picker_setting.nut",
            "scripts/fu/systems/mod_settings/elements/enum_setting.nut",
            "scripts/fu/systems/mod_settings/elements/keybind_setting.nut",
            "scripts/fu/systems/mod_settings/elements/range_setting.nut",
            "scripts/fu/systems/mod_settings/elements/settings_divider.nut",
            "scripts/fu/systems/mod_settings/elements/settings_spacer.nut",
            "scripts/fu/systems/mod_settings/elements/settings_title.nut",
            "scripts/fu/systems/mod_settings/elements/string_setting.nut"
        ];
    }
    if (_path == "ui/mods/fu/mod_settings/")
    {
        return [
            "ui/mods/fu/mod_settings/array_setting.js",
            "ui/mods/fu/mod_settings/boolean_setting.js",
            "ui/mods/fu/mod_settings/button_setting.js",
            "ui/mods/fu/mod_settings/color_picker_setting.js",
            "ui/mods/fu/mod_settings/divider_setting.js",
            "ui/mods/fu/mod_settings/enum_setting.js",
            "ui/mods/fu/mod_settings/keybind_setting.js",
            "ui/mods/fu/mod_settings/range_setting.js",
            "ui/mods/fu/mod_settings/settings_screen.js",
            "ui/mods/fu/mod_settings/spacer_setting.js",
            "ui/mods/fu/mod_settings/string_setting.js",
            "ui/mods/fu/mod_settings/title_setting.js"
        ];
    }
    // For unknown paths, return empty array to prevent crashes
    return [];
}

// Provide global fallback
if (!("IO" in getroottable()))
{
    ::IO <- {
        enumerateFiles = function( _path ) { return ::FU.IO.enumerateFiles(_path); }
    };
}