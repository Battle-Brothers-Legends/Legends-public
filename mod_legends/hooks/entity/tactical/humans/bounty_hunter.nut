::mods_hookExactClass("entity/tactical/humans/bounty_hunter", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		this.m.Skills.removeByID("effects.dodge");
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Footwork);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Pathfinder);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBigGameHunter);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.HeadHunter);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPushTheAdvantage);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendMasteryNets);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendOnslaught);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
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
				"weapons/legend_glaive",
				"weapons/morning_star",
				"weapons/falchion",
				"weapons/arming_sword",
				"weapons/flail",
				"weapons/dagger",
				"weapons/legend_ranged_flail"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/spetum"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/battle_whip"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getID() == "weapon.dagger")
			{
				::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Duelist);
			}
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && !this.m.Skills.hasPerk(::Const.Perks.PerkDefs.Duelist))
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
			[1, "ragged_surcoat"],
			[1, "padded_leather"],
			[1, "patched_mail_shirt"],
			[1, "leather_lamellar"],
			[1, "basic_mail_shirt"],
			[1, "mail_hauberk"]
		]));

		if (this.Math.rand(1, 100) <= 90)
		{
			local helm = [
				[1, "nasal_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "reinforced_mail_coif"],
				[1, "headscarf"],
				[1, "kettle_hat"],
				[1, "kettle_hat_with_mail"],
				[1, "nordic_helmet"],
				[1, "nordic_helmet_with_closed_mail"],
				[1, "barbute_helmet"]
			];
			helm.push([1, "theamson_barbute_helmet"]);
			local item = this.Const.World.Common.pickHelmet(helm);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
