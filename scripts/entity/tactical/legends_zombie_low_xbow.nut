this.legends_zombie_low_xbow <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieLightXbow;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		::Legends.Traits.grant(this, ::Legends.Trait.LegendRottenFlesh);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Hitpoints *= 1.5;
			this.m.Hitpoints *= 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		}
		this.m.Skills.update();
	}

	function assignRandomEquipment()
	{
		local r;
		this.m.Items.equip(this.new("scripts/items/weapons/light_crossbow"));
		this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[2, ::Legends.Armor.Standard.linen_tunic],
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.apron],
			[1, ::Legends.Armor.Standard.butcher_apron],
			[1, ::Legends.Armor.Standard.monk_robe]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[67, ::Legends.Helmet.None],
			[7, ::Legends.Helmet.Standard.hood],
			[7, ::Legends.Helmet.Standard.aketon_cap],
			[7, ::Legends.Helmet.Standard.full_aketon_cap],
			[7, ::Legends.Helmet.Standard.open_leather_cap],
			[7, ::Legends.Helmet.Standard.full_leather_cap]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}

});
