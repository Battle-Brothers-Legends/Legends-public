::include("scripts/fu/shims/msu_shim_early.nut");
::include("scripts/fu/squirrel_hooks/mod_hooks.nut");

::Legends <- {
	ID = "mod_legends",
	Version = "19.2.0",
	Name = "Legends Mod",
	BuildName = "Tales & Professions",
	IsStartingNewCampaign = false
};

// Register FU mod with mod_hooks so registry system can find it
::mods_registerMod(::FU.ID, ::FU.Version, ::FU.Name);

// Register Legends with vanilla mod_hooks (avoid depending on MSU at this point)
::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);

::mods_queue(::Legends.ID, "mod_legends_assets(>=19.2.0), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins, mod_events_delayed_fix_legends, !mod_tooltip_extension(<=1.01)", function()
{
	    ::include("scripts/fu/load.nut");

	::Legends.Mod <- ::FU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);

	// ::Legends.Mod <- this.new("scripts/mods/legends_mod")
	::Legends.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Brothers-Legends/Legends-public");
    ::Legends.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

    // loading mod files
    ::include("mod_legends/load.nut");
});

::include("mod_legends/compat_defs.nut");
::mods_registerMod(::Legends.ID + "_compat_check", ::Legends.Version, ::Legends.Name + " - Compat");
::mods_queue(::Legends.ID + "_compat_check", ">mod_legends", function() {
	::include("mod_legends/compat.nut");
});
