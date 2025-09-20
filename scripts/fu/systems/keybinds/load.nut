function includeFile( _file )
{
	::FU.includeFile("scripts/fu/systems/keybinds/", _file + ".nut");
}

includeFile("key_static");
includeFile("abstract_keybind");
includeFile("keybind_sq");
includeFile("keybind_sq_passive");
includeFile("keybind_js");
includeFile("keybinds_system");
::FU.System.Keybinds <- ::FU.Class.KeybindsSystem();
::FU.UI.addOnConnectCallback(::FU.System.Keybinds.frameUpdate.bindenv(::FU.System.Keybinds));
local clearEvents = ::Time.clearEvents;
::Time.clearEvents = function()
{
	clearEvents();
	::FU.System.Keybinds.frameUpdate()
}
includeFile("keybinds_mod_addon");

