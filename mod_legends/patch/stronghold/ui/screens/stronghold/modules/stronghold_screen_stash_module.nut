::mods_hookExactClass("ui/screens/stronghold/modules/stronghold_screen_stash_module", function (o) {
	// answers null when nothing was repaired (no blacksmith, nothing to repair, not enough crowns)
	local onRepairItem = o.onRepairItem;
	o.onRepairItem = function (_itemIndex) {
		local result = onRepairItem(_itemIndex);
		return result == null ? { Item = null } : result;
	}
});
