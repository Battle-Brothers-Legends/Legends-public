this.legends_skeleton_low_archer <- this.inherit("scripts/entity/tactical/legend_skeleton", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendSkeletonLightArcher;
		this.legend_skeleton.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		this.m.Items.equip(this.new("scripts/items/weapons/short_bow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		// if (this.Math.rand(1, 100) <= 66)
		// {
		// 	this.m.Items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		// }

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[1, ::Legends.Armor.None]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[34, ::Legends.Helmet.None],
			[66, ::Legends.Helmet.Ancient.ancient_household_helmet]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
