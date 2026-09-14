this.legends_zombie_low <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieLight;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.FastAdaption);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		// this.m.Skills.add(this.new("scripts/skills/traits/legend_rotten_flesh_trait"));
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.BaseProperties.Hitpoints *= 1.5;
			this.m.Hitpoints *= 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		}
		this.m.Skills.update();

	}

	function assignRandomEquipment()
	{

		local r = this.Math.rand(1, 7);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));
		}

		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[4, ::Legends.Armor.Standard.leather_tunic],
			[4, ::Legends.Armor.Standard.linen_tunic],
			[3, ::Legends.Armor.Standard.sackcloth],
			[3, ::Legends.Armor.Standard.padded_surcoat],
			[2, ::Legends.Armor.Standard.leather_wraps],
			[2, ::Legends.Armor.Standard.monk_robe],
			[2, ::Legends.Armor.Standard.apron],
			[2, ::Legends.Armor.Standard.butcher_apron],
			[1, ::Legends.Armor.Standard.cultist_leather_robe]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[67, ::Legends.Helmet.None],
			[7, ::Legends.Helmet.Standard.hood],
			[7, ::Legends.Helmet.Standard.straw_hat],
			[7, ::Legends.Helmet.Standard.aketon_cap],
			[7, ::Legends.Helmet.Standard.full_aketon_cap],
			[7, ::Legends.Helmet.Standard.open_leather_cap],
			[7, ::Legends.Helmet.Standard.full_leather_cap],
			[4, ::Legends.Helmet.Standard.headscarf],
			[4, ::Legends.Helmet.Standard.cultist_hood],
			[4, ::Legends.Helmet.Standard.witchhunter_hat],
			[1, ::Legends.Helmet.Standard.cultist_leather_hood]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});
