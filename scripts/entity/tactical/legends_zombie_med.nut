this.legends_zombie_med <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},

	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieMedium;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		// this.m.Skills.add(this.new("scripts/skills/traits/legend_rotten_flesh_trait"));
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
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
		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/falx"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
		}


		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.leather_lamellar],
			[1, ::Legends.Armor.Standard.leather_scale_armor],
			[1, ::Legends.Armor.Standard.worn_mail_shirt],
			[1, ::Legends.Armor.Standard.patched_mail_shirt],
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.basic_mail_shirt]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[25, ::Legends.Helmet.None],
			[11, ::Legends.Helmet.Standard.kettle_hat],
			[11, ::Legends.Helmet.Standard.aketon_cap],
			[11, ::Legends.Helmet.Standard.full_aketon_cap],
			[11, ::Legends.Helmet.Standard.padded_kettle_hat],
			[11, ::Legends.Helmet.Standard.dented_nasal_helmet],
			[11, ::Legends.Helmet.Standard.mail_coif],
			[11, ::Legends.Helmet.Standard.full_leather_cap]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}


});
