::ModJimmysTooltips <- {
	ID = "mod_Jimmys_Tooltips_legends",
	Name = "ModJimmysTooltips",
	Version = "1.0.5"
}
::ModJimmysTooltips.ModHook <- ::Hooks.register(::ModJimmysTooltips.ID, ::ModJimmysTooltips.Version, ::ModJimmysTooltips.Name);
::ModJimmysTooltips.ModHook.require("mod_legends >= 18.2.5", "mod_msu >= 1.2.7", "mod_modern_hooks >= 0.4.10");
::ModJimmysTooltips.ModHook.queue(">mod_legends", ">mod_msu",function()
{
	::ModJimmysTooltips.Mod <- ::MSU.Class.Mod(::ModJimmysTooltips.ID, ::ModJimmysTooltips.Version, ::ModJimmysTooltips.Name);
	local page = ::ModJimmysTooltips.Mod.ModSettings.addPage("page_one", "Jimmy's Tactical Tooltip");
	page.addTitle("title", "You can edit what you see on the Tactical Tooltip");
	page.addDivider("divider");
	page.addBooleanSetting("DefaultTooltip", false);
	page.addBooleanSetting("ProgressBarValues", true);
	page.addBooleanSetting("Items", true);
	page.addBooleanSetting("ItemDurability", true);
	page.addBooleanSetting("Skills", true);
	page.addBooleanSetting("Stats", true);

	foreach (file in ::IO.enumerateFiles("mod_legends/mod_Jimmys_Tooltips/config"))
	{
		::include(file);
	}

	foreach (file in ::IO.enumerateFiles("mod_legends/mod_Jimmys_Tooltips/query"))
	{
		::include(file);
	}

	// load keybinds
	::include("mod_legends/mod_Jimmys_Tooltips/keybinds.nut");

	foreach (file in ::IO.enumerateFiles("mod_legends/mod_Jimmys_Tooltips/hooks"))
		::include(file);
});


