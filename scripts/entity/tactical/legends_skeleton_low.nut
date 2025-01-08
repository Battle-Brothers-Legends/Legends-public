this.legends_skeleton_low <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonLight;
		this.legend_skeleton.onInit();
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
		if(::Legends.isLegendaryDifficulty())
		{
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}

		// if (this.Math.rand(1, 100) <= 66)
		// {
		// 	this.m.Items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		// }

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "ancient/ancient_ripped_cloth"],
			[1, ""]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[34, ""],
			[66, "ancient/ancient_household_helmet"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
