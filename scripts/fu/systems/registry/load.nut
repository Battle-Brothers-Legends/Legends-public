local function includeFile( _file )
{
	::FU.includeFile("scripts/fu/systems/registry/", _file);
}
includeFile("registry_system");
includeFile("registry_mod_addon");

local system = ::FU.Class.RegistrySystem();
::FU.System.Registry <- system;

::includeFiles(::IO.enumerateFiles("scripts/fu/systems/registry/mod_sources"))

::FU.System.Registry.addNewModSource(::FU.Class.ModSourceGitHub);
::FU.System.Registry.addNewModSource(::FU.Class.ModSourceNexusMods);

::FU.getMod <- function( _modID )
{
	return ::FU.System.Registry.getMod(_modID);
}

::FU.hasMod <- function( _modID )
{
	return ::FU.System.Registry.hasMod(_modID);
}
