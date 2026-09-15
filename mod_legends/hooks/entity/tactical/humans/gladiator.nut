::mods_hookExactClass("entity/tactical/humans/gladiator", function(o) {
	local create = o.create;
	o.create = function(){
		create();
		if (this.randomizeEnemyGender() == 1) {
			this.setGender(1);
		}
	}
	
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
		::Legends.Perks.grant(this, ::Legends.Perk.Footwork);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendMasteryNets);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendNetCasting);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendAlert);
			::Legends.Perks.grant(this, ::Legends.Perk.LoneWolf);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/shamshir",
				"weapons/shamshir",
				"weapons/oriental/heavy_southern_mace",
				"weapons/oriental/heavy_southern_mace",
				"weapons/fighting_axe",
				"weapons/fighting_axe",
				"weapons/fighting_spear"
			];

			if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/oriental/two_handed_scimitar",
					"weapons/oriental/swordlance",
					"weapons/oriental/polemace",
					"weapons/two_handed_hammer",
					"weapons/greataxe",
					"weapons/legend_ranged_flail"
				]);
			}

			if (::Const.DLC.Wildmen && this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
			{
				weapons.extend([
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace",
					"weapons/bardiche"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));
		}

		if (this.getIdealRange() == 1 && ::Math.rand(1, 100) <= 50)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin",
				"weapons/throwing_spear"
			];

			this.m.Items.equip(this.new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local offhand = [
				"tools/throwing_net",
				"shields/oriental/metal_round_shield"
			];
			this.m.Items.equip(this.new("scripts/items/" + offhand[::Math.rand(0, offhand.len() - 1)]));
		}


		local armor = ::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.gladiator_harness]
		]);

		if (::Math.rand(1,3) <= 2)
		{
			armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		}
		else
		{
			armor.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		}

		this.m.Items.equip(armor);

		local helm = ::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.gladiator_helmet, ::Math.rand(13, 15)],
			[1, ::Legends.Helmet.None]
		]);
		this.m.Items.equip(helm);
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local r = ::Math.rand(1, 3);

		local armor = clone ::Const.Items.NamedSouthernArmors;
		local helmets = clone ::Const.Items.NamedSouthernHelmets;

		if (r == 1)
		{
			if (::Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(this.new("scripts/items/" + ::Const.Items.NamedSouthernMeleeWeapons[::Math.rand(0, ::Const.Items.NamedSouthernMeleeWeapons.len() - 1)]));
			}
			else
			{
				local namedWeaponArray = clone ::Const.Items.NamedMeleeWeapons;		// Temporary solution to prevent these minibosses from spawning with bad or incombatible weapons
				::MSU.Array.remove(namedWeaponArray, "weapons/named/named_dagger");
				this.m.Items.equip(this.new("scripts/items/" + ::MSU.Array.rand(namedWeaponArray)));
			}
		}
		else if (r == 2)
		{
			if (::Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(this.new("scripts/items/" + ::Const.Items.NamedSouthernShields[::Math.rand(0, ::Const.Items.NamedSouthernShields.len() - 1)]));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/" + ::Const.Items.NamedShields[::Math.rand(0, ::Const.Items.NamedShields.len() - 1)]));
			}
		}
		else if (r == 3)
		{
			if (::Math.rand(0, 1) == 0)
			{
				this.m.Items.equip(::Const.World.Common.pickArmor(
					::Const.World.Common.convNameToList(
						armor
					)
				));
			}
			else
			{
				this.m.Items.equip(::Const.World.Common.pickHelmet(
					::Const.World.Common.convNameToList(
						helmets
					)
				));
			}

		}

		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		return true;
	}
});
