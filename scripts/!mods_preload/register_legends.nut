::Legends <- {
	ID = "mod_legends",
	Version = "19.0.0",
	Name = "Legends Mod",
	BuildName = "Aspiration and Reality",
	IsStartingNewCampaign = false
};

if (!("MSU" in this.getroottable()) || ::MSU.SemVer.compare(::MSU.SemVer.getTable(::MSU.Version), ::MSU.SemVer.getTable("1.3.0")) >= 0 && !("Hooks" in this.getroottable()))
{
	::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);
}
else
{
	::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);
}

::mods_queue(::Legends.ID, "mod_msu, mod_legends_assets(>=19.0.0), vanilla(>=1.5.0-15), dlc_lindwurm, dlc_unhold, dlc_wildmen, dlc_desert, dlc_paladins, mod_events_delayed_fix, !mod_tooltip_extension(<=1.01)", function()
{
	::Legends.Mod <- ::MSU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);

	// ::Legends.Mod <- this.new("scripts/mods/legends_mod")
	::Legends.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Brothers-Legends/Legends-public");
    ::Legends.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);

    // loading mod files
    ::include("mod_legends/load.nut");
});
