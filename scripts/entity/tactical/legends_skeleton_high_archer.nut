this.legends_skeleton_high_archer <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonHeavyArcher;
		this.legend_skeleton.onInit();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_bow"));
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/war_bow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		// if (this.Math.rand(1, 100) <= 66)
		// {
		// 	this.m.Items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		// }

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "ancient/ancient_scale_harness"],
			[1, "ancient/ancient_breastplate"],
			[1, "ancient/ancient_mail"],
			[1, "ancient/ancient_double_layer_mail"]
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
