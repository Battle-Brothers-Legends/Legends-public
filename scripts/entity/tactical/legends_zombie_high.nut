this.legends_zombie_high <- this.inherit("scripts/entity/tactical/legend_zombie", {
	m = {},
	function onInit()
	{
		this.m.SpawnType = this.Const.Tactical.Actor.LegendZombieHeavy;
		this.legend_zombie.onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
		::Legends.Perks.grant(this, ::Legends.Perk.ReachAdvantage);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Actives.grant(this, ::Legends.Active.ZombieBite);
		// this.m.Skills.add(this.new("scripts/skills/traits/legend_rotten_flesh_trait"));
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.Fearsome);
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
		r = this.Math.rand(0, 8);

		if (r <= 1)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/greataxe"));
				}
				else if (r == 3)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/two_handed_flail"));
				}
			}
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/longsword"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/weapons/greataxe"));
				}
			}
		}
		else
		{
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/winged_mace"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/fighting_axe"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/military_cleaver"));
			}
			else if (this.Math.rand(1, 2) == 1)
			{
				this.m.Items.equip(this.new("scripts/items/shields/worn_heater_shield"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/shields/worn_kite_shield"));
			}
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.decayed_coat_of_plates],
			[1, ::Legends.Armor.Standard.decayed_coat_of_scales],
			[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Standard.decayed_closed_flat_top_with_mail],
			[1, ::Legends.Helmet.Standard.decayed_closed_flat_top_with_sack],
			[3, ::Legends.Helmet.Standard.decayed_full_helm],
			[3, ::Legends.Helmet.Standard.decayed_great_helm]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}
});
