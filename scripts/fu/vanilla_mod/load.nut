local function includeFile( _file )
{
	::FU.includeFile("scripts/fu/vanilla_mod/", _file + ".nut");
}
includeFile("setup_vanilla_mod");
includeFile("vanilla_keybinds");


