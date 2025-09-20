local function includeFile(_file)
{
	::FU.includeFile("scripts/fu/systems/tooltips/", _file);
}

includeFile("tooltips_system");
::FU.System.Tooltips <- ::FU.Class.TooltipsSystem();
includeFile("tooltips_mod_addon");
includeFile("abstract_tooltip");
::FU.includeFiles(::IO.enumerateFiles("scripts/fu/systems/tooltips/tooltips"));
