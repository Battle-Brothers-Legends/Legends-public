//----------------------------------------------------------------------------------------------
::ModJimmysTooltips.Mod.Keybinds.addDivider("Keybinds");
::ModJimmysTooltips.Mod.Keybinds.addTitle("KeybindsTitle", "Important - Do Not Change");
//----------------------------------------------------------------------------------------------

::ModJimmysTooltips.Mod.Keybinds.addSQKeybind("updateTooltip", "tab", ::MSU.Key.State.Tactical, function() {
	::Tactical.Entities.getFlags().set("ModJimmysTooltips_ShowLootChance", !::Tactical.Entities.getFlags().get("ModJimmysTooltips_ShowLootChance"));
	::Tooltip.reload();
}, "Toggle to see loot chance", null, "Press this keybind to display the chance to loot item from enemy.");