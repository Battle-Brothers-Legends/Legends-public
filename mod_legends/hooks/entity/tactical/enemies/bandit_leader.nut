::mods_hookExactClass("entity/tactical/enemies/bandit_leader", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_melee_agent_less_flanking");
		this.m.AIAgent.setActor(this);
	}

	o.onInit = function ()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditLeader);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		b.IsSpecializedInDaggers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.ShieldExpert);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Brawny);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.CoupDeGrace);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendSmackdown);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.QuickHands);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.NineLives);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Rotation);
		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Recover);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.BattleForged);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.LegendComposure);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Relentless);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Dodge);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Backstabber);
			::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Underdog);
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/actives/rally_the_troops"));
		}
	}

	o.onAppearanceChanged = function ( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setArmorBrightness(0.9);
		this.setDirty(true);
	}

	o.assignRandomEquipment = function ()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/fighting_axe",
				"weapons/warhammer",
				"weapons/legend_glaive",
				"weapons/fighting_spear",
				"weapons/winged_mace",
				"weapons/arming_sword",
				"weapons/military_cleaver"
			];

			if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/legend_swordstaff",
					"weapons/legend_longsword",
					"weapons/warbrand",
					"weapons/legend_estoc"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 35)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[1, "coat_of_plates"],
				[1, "coat_of_scales"],
				[1, "heavy_lamellar_armor"],
				[1, "footman_armor"],
				[1, "brown_hedgeknight_armor"],
				[1, "northern_mercenary_armor_02"],
				[1, "lamellar_harness"],
				[1, "reinforced_mail_hauberk"],
				[1, "leather_scale_armor"],
				[1, "light_scale_armor"]
			]

			local helmet = [
				[1, "closed_mail_coif"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat_with_closed_mail"],
				[1, "kettle_hat_with_mail"],
				[1, "padded_flat_top_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "flat_top_with_mail"],
				[1, "padded_nasal_helmet"],
				[1, "bascinet_with_mail"]
			]

			local outfits = [
				[1, "red_bandit_leader_outfit_00"]
			]

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item)
			}
			return;
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local armor = [
				[1, "reinforced_mail_hauberk"],
				[2, "heavy_lamellar_armor"],
				[2, "bandit_armor_heavy"]
			];

			if (this.Const.DLC.Unhold)
			{
				armor.extend([
					[1, "footman_armor"],
					[1, "leather_scale_armor"],
					[1, "light_scale_armor"],
					[1, "red_bandit_leader_armor"]
				]);
			}

			this.m.Items.equip(this.Const.World.Common.pickArmor(armor))
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[1, "closed_mail_coif"],
				[1, "padded_kettle_hat"],
				[1, "kettle_hat_with_closed_mail"],
				[1, "kettle_hat_with_mail"],
				[1, "padded_flat_top_helmet"],
				[1, "nasal_helmet_with_mail"],
				[1, "flat_top_with_mail"],
				[1, "padded_nasal_helmet"],
				[1, "bascinet_with_mail"],
				[1, "red_bandit_leader_helmet"]
			]);
			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local shields = clone this.Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);
		local r = this.Math.rand(1, 4);

		if (r == 1)
		{
			local namedWeaponArray = clone ::Const.Items.NamedMeleeWeapons;		// Temporary solution to prevent these minibosses from spawning with bad or incombatible weapons
			::MSU.Array.remove(namedWeaponArray, "weapons/named/named_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_parrying_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_shovel");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_sickle");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/named_battle_whip");
			this.m.Items.equip(this.new("scripts/items/" + ::MSU.Array.rand(namedWeaponArray)));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else if (r == 3)
		{
			local named = this.Const.Items.NamedArmors;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickArmor(weightName));
		}
		else
		{
			local named = this.Const.Items.NamedHelmets;
			local weightName = this.Const.World.Common.convNameToList(named);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(weightName));
		}

		::Legends.Perks.grant(this, ::Const.Perks.PerkDefs.Underdog);
		return true;
	}
});
