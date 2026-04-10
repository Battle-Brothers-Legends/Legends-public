::Legends <- {
	ID = "mod_legends",
	Version = "19.3.7",
	Name = "Legends Mod",
	BuildName = "Left & Right",
	IsStartingNewCampaign = false
};

::mods_registerMod(::Legends.ID, ::Legends.Version, ::Legends.Name);
::mods_queue(::Legends.ID, [
	"mod_legends_assets(>=19.3.7)",
	"mod_msu(>=1.7.0)",
	"vanilla(>=1.5.1-5)",
	"vanilla(<1.5.2)",
	"dlc_lindwurm",
	"dlc_unhold",
	"dlc_wildmen",
	"dlc_desert",
	"dlc_paladins",
	"mod_events_delayed_fix_legends",
	"!mod_tooltip_extension(<=1.01)"
].reduce(@(p, n) ::format("%s, %s", p, n)), function () {
	::Legends.Mod <- ::MSU.Class.Mod(::Legends.ID, ::Legends.Version, ::Legends.Name);
	::Legends.Mod.Registry.addModSource(::MSU.System.Registry.ModSourceDomain.GitHub, "https://github.com/Battle-Brothers-Legends/Legends-public");
	::Legends.Mod.Registry.setUpdateSource(::MSU.System.Registry.ModSourceDomain.GitHub);
	// loading mod files
	::include("mod_legends/load.nut");
});

// some mods can be easily 'fixed' by loadind after legends, that what it is for
::mods_registerMod(::Legends.ID + "_load_order_fix", ::Legends.Version, ::Legends.Name + " - Load order fix");
::mods_queue(::Legends.ID + "_load_order_fix", [
	">mod_legends", // mods listed here will be forced to load after legends
	"<mod_prepare_carefully",
].reduce(@(p, n) ::format("%s, %s", p, n)), function () {});

// compat mod
::include("mod_legends/compat_defs.nut");
::mods_registerMod(::Legends.ID + "_compat_check", ::Legends.Version, ::Legends.Name + " - Compat");
::mods_queue(::Legends.ID + "_compat_check", ">mod_legends", function () {
	::include("mod_legends/compat.nut");
});
