::mods_hookExactClass("entity/tactical/enemies/zombie_treasure_hunter", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.update();
	}

	o.assignRandomEquipment = function ()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		local aList = [
			[1, "oriental/stitched_nomad_armor"],
			[1, "oriental/leather_nomad_robe"],
			[1, "oriental/nomad_robe"],
			[1, "oriental/thick_nomad_robe"]
		];
		local armor = this.Const.World.Common.pickArmor(aList);
		this.m.Items.equip(armor);
		local helmet = [
			[1, "oriental/nomad_head_wrap"]
		];
		this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
	}
});
