::mods_hookExactClass("entity/tactical/enemies/zombie_knight", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Hitpoints = b.Hitpoints * 1.5;
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Colossus);
		}
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
	}

	o.assignRandomEquipment = function()
	{
		local r;

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/winged_mace",
				"weapons/hand_axe",
				"weapons/fighting_axe",
				"weapons/morning_star",
				"weapons/arming_sword",
				"weapons/flail",
				"weapons/military_cleaver"
			];

			if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/longsword",
					"weapons/legend_longsword",
					"weapons/greataxe",
					"weapons/legend_reinforced_flail",
				]);
			}

			if (this.Const.DLC.Unhold && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flail"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/worn_heater_shield",
				"shields/worn_kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		local aList = [
			[1, "decayed_coat_of_plates"],
			[1, "decayed_coat_of_scales"],
			[1, "decayed_reinforced_mail_hauberk"]
		];
		local armor = this.Const.World.Common.pickArmor(aList);


		if (this.Math.rand(1, 100) <= 33)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(armor);

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null && this.Math.rand(1, 100) <= 90)
		{
			local helmet = [
				[1, "decayed_closed_flat_top_with_sack"],
				[3, "decayed_closed_flat_top_with_mail"],
				[3, "decayed_full_helm"],
				[3, "decayed_great_helm"]
			];
			local h = this.Const.World.Common.pickHelmet(helmet);

			if (this.Math.rand(1, 100) <= 33)
			{
				h.setArmor(this.Math.round(h.getArmorMax() / 2 - 1));
			}

			this.m.Items.equip(h);
		}
	}
});
