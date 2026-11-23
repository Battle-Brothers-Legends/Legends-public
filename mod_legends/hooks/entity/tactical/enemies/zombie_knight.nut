::mods_hookExactClass("entity/tactical/enemies/zombie_knight", function(o)
{
	local create = o.create;
	o.create = function () {
		create();
		this.m.OnDeathLootTable.extend([
			[0.5, "scripts/items/misc/legend_masterwork_fabric"],
			[0.5, "scripts/items/misc/legend_masterwork_metal"],
			[0.5, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		local b = this.m.BaseProperties;
		b.SurroundedBonus = 5; // resetting from vanilla
		if (::Legends.isLegendaryDifficulty())
		{
			b.Hitpoints *= 1.5;
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Steadfast);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.Colossus);
		}
		::Legends.S.scaleBaseProperties(b);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendPoisonImmunity);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
	}

	local onResurrected = o.onResurrected;
	o.onResurrected = function (_info) {
		onResurrected(_info);
		if (!_info.IsHeadAttached) {
			this.m.Skills.removeByID(::Legends.Actives.getID(::Legends.Active.ZombieBite));
			this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;

		local weapons = [
			"weapons/hand_axe",
			"weapons/morning_star",
			"weapons/arming_sword",
			"weapons/flail",
			"weapons/longsword",
			"weapons/greataxe",
			"weapons/goedendag",
			"weapons/legend_battle_glaive",
			"weapons/legend_reinforced_flail",
			"weapons/legend_infantry_axe",
			"weapons/legend_zweihander",
		];

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/worn_heater_shield",
				"shields/worn_kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		local aList = [
			[1, ::Legends.Armor.Standard.decayed_coat_of_plates],
			[1, ::Legends.Armor.Standard.decayed_coat_of_scales],
			[1, ::Legends.Armor.Standard.decayed_reinforced_mail_hauberk]
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
				[1, ::Legends.Helmet.Standard.decayed_closed_flat_top_with_sack],
				[3, ::Legends.Helmet.Standard.decayed_closed_flat_top_with_mail],
				[3, ::Legends.Helmet.Standard.decayed_full_helm],
				[3, ::Legends.Helmet.Standard.decayed_great_helm]
			];
			local h = this.Const.World.Common.pickHelmet(helmet);

			if (this.Math.rand(1, 100) <= 33)
			{
				h.setArmor(this.Math.round(h.getArmorMax() / 2 - 1));
			}

			this.m.Items.equip(h);
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.m.BaseProperties.Armor[this.Const.BodyPart.Head] += 50;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Head] += 50;
		this.m.BaseProperties.Armor[this.Const.BodyPart.Body] += 100;
		this.m.BaseProperties.ArmorMax[this.Const.BodyPart.Body] += 100;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"named_axe",
			"named_cleaver",
			"named_flail",
			"named_greataxe",
			"named_greatsword",
			"named_mace",
			"named_two_handed_hammer",
			"legend_named_longsword",
			"legend_named_glaive",
			"legend_named_swordstaff",
			"legend_named_halberd",
			"legend_named_ranged_flail",
			"legend_named_infantry_axe",
			"legend_named_warhammer",
			"named_two_handed_mace",
			"named_two_handed_flail"
		];

		local shields = clone this.Const.Items.NamedUndeadShields;

		if (this.Math.rand(1, 100) <= 80)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/named/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMuscularity);
		return true;
	}
});
