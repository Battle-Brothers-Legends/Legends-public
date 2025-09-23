local function includeLoad( _folder )
{
	::FU.includeLoad("scripts/fu/", _folder);
}

// utils and classes are loaded before mods_queue in scripts/config/!FU.nut

// Ensure core classes are available before loading systems that depend on them
::FU.includeFiles(::IO.enumerateFiles("scripts/fu/classes"));

includeLoad("ui");
includeLoad("systems");
includeLoad("hooks");
includeLoad("FU_mod");
includeLoad("vanilla_mod");
includeLoad("test");

// Provide compatibility shims (e.g., MSU) after core systems are loaded
::FU.includeFile("scripts/fu/", "shims/msu_shim.nut");

// Execute any queued end-of-load functions
if ("EndQueue" in ::FU && "execute" in ::FU.EndQueue) ::FU.EndQueue.execute();
