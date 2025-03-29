::mods_hookExactClass("entity/tactical/enemies/fault_finder", function(o) {
	o.assignRandomEquipment = function ()
	{
		local weapons =	[
			"scripts/items/weapons/knife",
			"scripts/items/weapons/dagger",
			"scripts/items/weapons/butchers_cleaver"
		];
		this.m.Items.equip(this.new(weapons[::Math.rand(0, weapons.len() - 1)]));
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[1, "fault_finder_robes"]
		]));

		local helmets = [
			"scripts/items/helmets/golems/fault_finder_book_head",
			"scripts/items/helmets/golems/fault_finder_facewrap",
			"scripts/items/helmets/golems/fault_finder_facewrap",
			"scripts/items/helmets/golems/fault_finder_eye_mask",
			"scripts/items/helmets/golems/fault_finder_eye_mask",
			"scripts/items/helmets/golems/fault_finder_eye_mask",
		];
		this.m.Items.equip(this.new(helmets[::Math.rand(0, helmets.len() - 1)]));
	}
});
