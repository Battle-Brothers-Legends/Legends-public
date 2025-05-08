::mods_hookExactClass("entity/tactical/humans/bounty_hunter", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Effects.remove(this, ::Legends.Effect.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
			::Legends.Perks.grant(this, ::Legends.Perk.Pathfinder);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBigGameHunter);
			::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendPushTheAdvantage);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendMasteryNets);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/billhook",
				"weapons/pike",
				"weapons/warbrand",
				"weapons/hand_axe",
				"weapons/boar_spear",
				"weapons/legend_battle_glaive",
				"weapons/morning_star",
				"weapons/falchion",
				"weapons/arming_sword",
				"weapons/flail",
				"weapons/dagger",
				"weapons/legend_ranged_flail",
				"weapons/spetum",
				"weapons/battle_whip"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.dagger")
			{
				::Legends.Perks.grant(this, ::Legends.Perk.Duelist);
			}
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && !this.m.Skills.hasPerk(::Legends.Perk.Duelist))
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(0, 2);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.patched_mail_shirt],
			[1, ::Legends.Armor.Standard.leather_lamellar],
			[1, ::Legends.Armor.Standard.basic_mail_shirt],
			[1, ::Legends.Armor.Standard.mail_hauberk]
		]));

		if (this.Math.rand(1, 100) <= 90)
		{
			local helm = [
				[1, ::Legends.Helmet.Standard.nasal_helmet],
				[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
				[1, ::Legends.Helmet.Standard.reinforced_mail_coif],
				[1, ::Legends.Helmet.Standard.headscarf],
				[1, ::Legends.Helmet.Standard.kettle_hat],
				[1, ::Legends.Helmet.Standard.kettle_hat_with_mail],
				[1, ::Legends.Helmet.Standard.nordic_helmet],
				[1, ::Legends.Helmet.Standard.nordic_helmet_with_closed_mail],
				[1, ::Legends.Helmet.Standard.barbute_helmet]
			];
			helm.push([1, ::Legends.Helmet.Standard.theamson_barbute_helmet]);
			local item = this.Const.World.Common.pickHelmet(helm);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
