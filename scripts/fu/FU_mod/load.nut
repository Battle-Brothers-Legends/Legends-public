local function includeFile( _file )
{
	::FU.includeFile("scripts/fu/FU_mod/", _file + ".nut");
}
includeFile("setup_FU_mod");
includeFile("FU_registry");
includeFile("FU_mod_debug");
includeFile("FU_mod_modsettings");
includeFile("FU_tooltips");
includeFile("FU_keybinds");
