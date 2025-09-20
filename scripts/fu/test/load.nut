local function includeFile( _file )
{
	::FU.includeFile("scripts/fu/test/", _file + ".nut");
}
if ("Mod" in ::FU && "Debug" in ::FU.Mod && ::FU.Mod.Debug.isEnabled("modsettings"))
{
	includeFile("mod_settings_system_test.nut");
}
