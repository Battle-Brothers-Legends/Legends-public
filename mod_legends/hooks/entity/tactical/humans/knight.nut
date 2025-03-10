::mods_hookExactClass("entity/tactical/humans/knight", function(o)
{
	local onInit = o.onInit;
	o.onInit = function ()
	{
		onInit();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendLastStand);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);

		if(::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFeint);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSpecialistShieldSkill);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendSmashingShields);
			::Legends.Perks.grant(this, ::Legends.Perk.ShieldBash);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendFullForce);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function ()
	{
		local r;
		local banner = 4;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (this.Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/fighting_axe",
				"weapons/noble_sword",
				"weapons/winged_mace",
				"weapons/warhammer"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			r = this.Math.rand(1, 2);
			local shield;

			if (r == 1)
			{
				shield = this.new("scripts/items/shields/faction_heater_shield");
			}
			else if (r == 2)
			{
				shield = this.new("scripts/items/shields/faction_kite_shield");
			}

			shield.setFaction(banner);
			this.m.Items.equip(shield);
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[1, "coat_of_plates"],
			[1, "coat_of_scales"]
		]));

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[30, "full_helm"],
				[5, "legend_helm_breathed"],
				[5, "legend_helm_full"],
				[5, "legend_helm_bearded"],
				[5, "legend_helm_point"],
				[5, "legend_helm_snub"],
				[5, "legend_helm_wings"],
				[5, "legend_helm_short"],
				[5, "legend_helm_curved"],
				[2, "legend_enclave_vanilla_great_helm_01"],
				[2, "legend_enclave_vanilla_great_bascinet_01"],
				[2, "legend_enclave_vanilla_great_bascinet_02"],
				[2, "legend_enclave_vanilla_great_bascinet_03"],
				[15, "faction_helm", banner],
				[5, "legend_frogmouth_helm"],
				[1, "legend_frogmouth_helm_crested"]
			]))
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/named_greatsword",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/legend_named_longsword"
		];
		local shields = clone this.Const.Items.NamedShields;
		local armor = [
			"armor/named/brown_coat_of_plates_armor",
			"armor/named/golden_scale_armor",
			"armor/named/green_coat_of_plates_armor",
			"armor/named/heraldic_mail_armor"
		];

		local r = this.Math.rand(1, 3);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}
		else
		{
			local h = this.Const.World.Common.pickArmor(
				this.Const.World.Common.convNameToList(
					armor
				)
			);
			this.m.Items.equip(h);
		}
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[3, "named/legend_frogmouth_helm_crested_painted"],
			[3, "named/bascinet_named"],
			[3, "named/kettle_helm_named"],
			[3, "named/deep_sallet_named"],
			[3, "named/barbute_named"],
			[3, "named/italo_norman_helm_named"],
			[1, "named/legend_helm_full_named"]
		]));


		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		return true;
	}

	o.onDeath <- function(_killer, _skill, _tile,  _fatalityType)
	{
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);

		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			if (this.Math.rand(1, 1000) <= 25) //2.5%
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_fabric");
				loot.drop(_tile);
			}

			if (this.Math.rand(1, 1000) <= 15) //1.5%
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_metal");
				loot.drop(_tile);
			}

			if (this.Math.rand(1, 100) <= 1)
			{
				local loot = this.new("scripts/items/misc/legend_masterwork_tools");
				loot.drop(_tile);
			}
		}
	}

});
