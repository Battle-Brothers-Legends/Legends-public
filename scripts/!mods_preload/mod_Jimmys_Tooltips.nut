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

::ModJimmysTooltips.ModHook.queue(">mod_legends", function() {
	::ModJimmysTooltips.ModHook.hook("scripts/ui/screens/tooltip/tooltip_events", function (q) {
		function patchTooltip (_tooltip) {
			if (_tooltip == null)
				return _tooltip;
			foreach (entry in _tooltip) {
				if (entry == null)
					continue;
				if ("text" in entry)
					entry.text = ::Legends.tooltip(entry.text, "param" in entry ? entry.param : []);
			}
			return _tooltip;
		}

		q.onQueryTileTooltipData =
			@(__original) @() patchTooltip(__original());
		q.onQueryEntityTooltipData =
			@(__original) @(_entityId, _isTileEntity) patchTooltip(__original(_entityId, _isTileEntity));
		q.onQueryRosterEntityTooltipData =
			@(__original) @(_entityId) patchTooltip(__original(_entityId));
		q.onQuerySkillTooltipData =
			@(__original) @(_entityId, _skillId) patchTooltip(__original(_entityId, _skillId));
		q.onQueryStatusEffectTooltipData =
			@(__original) @(_entityId, _statusEffectId) patchTooltip(__original(_entityId, _statusEffectId));
		q.onQuerySettlementStatusEffectTooltipData =
			@(__original) @(_statusEffectId) patchTooltip(__original(_statusEffectId));
		q.onQueryUIItemTooltipData =
			@(__original) @(_entityId, _itemId, _itemOwner) patchTooltip(__original(_entityId, _itemId, _itemOwner));
		q.onQueryUIPerkTooltipData =
			@(__original) @(_entityId, _perkId) patchTooltip(__original(_entityId, _perkId));
		q.onQueryUIElementTooltipData =
			@(__original) @(_entityId, _elementId, _elementOwner) patchTooltip(__original(_entityId, _elementId, _elementOwner));
		q.onQueryFollowerTooltipData =
			@(__original) @(_followerID) patchTooltip(__original(_followerID));
		q.onQueryUIProfessionTooltipData =
			@(__original) @(_entityId, _professionId) patchTooltip(__original(_entityId, _professionId));
	});
}, ::Hooks.QueueBucket.VeryLate);

