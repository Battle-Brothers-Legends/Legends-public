this.legends_skeleton_med_archer <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonMediumArcher;
		this.legend_skeleton.onInit();
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CripplingStrikes);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.SpecBow);
		this.m.Skills.add(this.new("scripts/skills/traits/legend_fleshless_trait"));
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/hunting_bow"));
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
