::mods_hookExactClass("entity/tactical/humans/knight", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.OnDeathLootTable.extend([
			[2.5, "scripts/items/misc/legend_masterwork_fabric"],
			[1.5, "scripts/items/misc/legend_masterwork_metal"],
			[1.0, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}
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
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBackToBasics);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendForcefulSwing);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBloodyHarvest);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}
	}

	o.assignRandomEquipment = function () {
		local banner = 6;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())	{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		} else {
			banner = this.getFaction();
		}

		if (this.Tactical.State.isScenarioMode()) {
			banner = 9;
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
			local shields = [
				"shields/faction_heater_shield",
				"shields/faction_kite_shield"
			];

			local shield = this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]);
			shield.setFaction(banner);
			this.m.Items.equip(shield);
		}

		local armor = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.coat_of_plates],
			[1, ::Legends.Armor.Standard.coat_of_scales]
		]);

		if (::Math.rand(1, 100) <= 40 && ::Const.DLC.Unhold) {
			local pauldrons = ::new("scripts/items/legend_armor/armor_upgrades/legend_armor_pauldrons_shoulderplates_heraldic");

			local bannerVariants = {
				[3] = 4,
				[4] = 3,
				[6] = 1,
				[7] = 5,
				[9] = 3,
				[10] = 5
			};

			if (banner in bannerVariants) {
				pauldrons.setVariant(bannerVariants[banner]);
				pauldrons.updateVariant();
			}

			armor.setUpgrade(pauldrons);
		}

		this.m.Items.equip(armor);

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			this.m.Items.equip(this.Const.World.Common.pickHelmet([
				[30, ::Legends.Helmet.Standard.full_helm],
				[5, ::Legends.Helmet.Standard.legend_helm_breathed],
				[5, ::Legends.Helmet.Standard.legend_helm_full],
				[5, ::Legends.Helmet.Standard.legend_helm_bearded],
				[5, ::Legends.Helmet.Standard.legend_helm_point],
				[5, ::Legends.Helmet.Standard.legend_helm_snub],
				[5, ::Legends.Helmet.Standard.legend_helm_wings],
				[5, ::Legends.Helmet.Standard.legend_helm_short],
				[5, ::Legends.Helmet.Standard.legend_helm_curved],
				[5, ::Legends.Helmet.Standard.legend_helm_sharp],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_helm_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_01],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_02],
				[2, ::Legends.Helmet.Standard.legend_enclave_vanilla_great_bascinet_03],
				[15, ::Legends.Helmet.Standard.faction_helm, banner],
				[5, ::Legends.Helmet.Standard.legend_frogmouth_helm],
				[1, ::Legends.Helmet.Standard.legend_frogmouth_helm_crested]
			]))
		}
	}

	o.makeMiniboss = function ()
	{
		if (!this.actor.makeMiniboss())	{
			return false;
		}

		local banner = 9;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())	{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		} else {
			banner = this.getFaction();
		}

		if (this.Tactical.State.isScenarioMode()) {
			banner = 9;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_axe",
			"weapons/named/legend_named_zweihander",
			"weapons/named/legend_named_flamberge",
			"weapons/named/named_mace",
			"weapons/named/named_sword",
			"weapons/named/legend_named_longsword",
			"weapons/named/named_poleaxe"
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

			if (::Math.rand(1, 100) <= 75 && ::Const.DLC.Unhold) {
				local upgrades = [
					"armor_upgrades/legend_armor_pauldrons_shoulderplates_heraldic",
					"armor_upgrades/legend_joint_cover_upgrade",
					"armor_upgrades/legend_mail_patch_upgrade"
				];
				local r = ::Math.rand(0, upgrades.len() - 1);
				local pauldrons = ::new("scripts/items/legend_armor/" + upgrades[r]);

				if(r == 0) {
					local bannerVariants = {
						[3] = 4,
						[4] = 3,
						[6] = 1,
						[7] = 5,
						[9] = 3,
						[10] = 5
					};
					if (banner in bannerVariants) {
						pauldrons.setVariant(bannerVariants[banner]);
						pauldrons.updateVariant();
					}
					armor.setUpgrade(pauldrons)
				}
			}

			this.m.Items.equip(h);
		}
		this.m.Items.equip(this.Const.World.Common.pickHelmet([
			[3, ::Legends.Helmet.Named.legend_frogmouth_helm_crested_painted],
			[3, ::Legends.Helmet.Named.bascinet_named],
			[3, ::Legends.Helmet.Named.kettle_helm_named],
			[3, ::Legends.Helmet.Named.deep_cervelliere_named],
			[3, ::Legends.Helmet.Named.barbute_named],
			[3, ::Legends.Helmet.Named.italo_norman_helm_named],
			[1, ::Legends.Helmet.Named.legend_helm_full_named]
		]));


		::Legends.Perks.grant(this, ::Legends.Perk.KillingFrenzy);
		::Legends.Perks.grant(this, ::Legends.Perk.HoldOut);
		return true;
	}
});
