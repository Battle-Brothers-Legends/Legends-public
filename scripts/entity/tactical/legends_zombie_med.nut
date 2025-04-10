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
			[1, "padded_leather"],
			[1, "leather_lamellar"],
			[1, "leather_scale_armor"],
			[1, "worn_mail_shirt"],
			[1, "patched_mail_shirt"],
			[1, "ragged_surcoat"],
			[1, "basic_mail_shirt"]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[25, ""],
			[11, "kettle_hat"],
			[11, "aketon_cap"],
			[11, "full_aketon_cap"],
			[11, "padded_kettle_hat"],
			[11, "dented_nasal_helmet"],
			[11, "mail_coif"],
			[11, "full_leather_cap"]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}

	}


});
