::mods_hookExactClass("entity/tactical/enemies/bandit_marauder", function(o) {
	local create = o.create;
	o.create = function() {
		create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_melee_agent_less_flanking");
		this.m.AIAgent.setActor(this);
		this.m.OnDeathLootTable.extend([
			[0.5, "scripts/items/misc/legend_masterwork_fabric"],
			[0.3, "scripts/items/misc/legend_masterwork_metal"],
			[0.2, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	o.onInit = function() {
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditMarauder);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.getSprite("armor").Saturation = 0.85;
		this.getSprite("helmet").Saturation = 0.85;
		this.getSprite("helmet_damage").Saturation = 0.85;
		this.getSprite("shield_icon").Saturation = 0.85;
		this.getSprite("shield_icon").setBrightness(0.85);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.Bullseye);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.CripplingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.SunderingStrikes);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.HeadHunter);
		::Legends.Perks.grant(this, ::Legends.Perk.Backstabber);
		if (::Legends.isLegendaryDifficulty()) {
			::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendOnslaught);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		}
	}

	o.assignRandomEquipment = function() {
		local r;
		local weapons = [];

		if (this.Math.rand(1, 100) <= 55) {
			weapons.extend([
				"weapons/pike",
				"weapons/longaxe",
				"weapons/exesword",
				"weapons/warbrand",
				"weapons/two_handed_flail",
				"weapons/two_handed_mace",
				"weapons/longsword",
				"weapons/greatsword",
				"weapons/legend_zweihander",
				"weapons/legend_battle_glaive",
				"weapons/legend_infantry_axe"
			]);
		} else {
			weapons.extend([
				"weapons/hand_axe",
				"weapons/flail",
				"weapons/arming_sword",
				"weapons/morning_star",
				"weapons/scramasax",
				"weapons/military_pick"
			]);

			if (this.Math.rand(1, 100) <= 50) {
				this.getItems().equip(::Const.World.Common.pickItem([
					[3, "shields/kite_shield"],
					[1, "shields/legend_tower_shield"],
				], "scripts/items/"));
			}
		}
		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		if (this.Math.rand(1, 100) <= 50) {
			local secondaryWeapons = [
				"weapons/throwing_axe",
				"weapons/javelin",
				"weapons/throwing_spear"
			];
			this.m.Items.addToBag(this.new("scripts/items/" + secondaryWeapons[this.Math.rand(0, secondaryWeapons.len() - 1)]));
		}

		local armorList = [
			[5, ::Legends.Armor.Standard.rusted_mail_hauberk],
			[5, ::Legends.Armor.Standard.patchwork_scale_armor],
			[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
			[1, ::Legends.Armor.Standard.scale_armor],
			[1, ::Legends.Armor.Standard.heavy_lamellar_armor],
		];

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60) {
			armorList.extend([
				[10, ::Legends.Armor.Standard.pillaged_heavy_lamellar_armor],
				[3, ::Legends.Armor.Standard.bandit_armor_heavy],
				[3, ::Legends.Armor.Standard.bandit_armor_ultraheavy]
			]);
		}

		this.getItems().equip(::Const.World.Common.pickArmor(armorList));


		local helmetList = [];
		if (this.Math.rand(1, 100) <= 90) {
			helmetList.extend([
				[10, ::Legends.Helmet.Standard.marauder_helmet_with_rusty_mail],
				[10, ::Legends.Helmet.Standard.marauder_helmet_with_rusty_mail_cloth],
				[1, ::Legends.Helmet.Standard.nasal_helmet],
				[1, ::Legends.Helmet.Standard.rondel_helm],
				[1, ::Legends.Helmet.Standard.barbute_helmet],
				[1, ::Legends.Helmet.Standard.legend_enclave_vanilla_skullcap_01],
				[1, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_01],
				[1, ::Legends.Helmet.Standard.scale_helm],
				[1, ::Legends.Helmet.Standard.deep_cervelliere],
				[1, ::Legends.Helmet.Standard.dented_nasal_helmet],
				[1, ::Legends.Helmet.Standard.nasal_helmet_with_rusty_mail],
				[1, ::Legends.Helmet.Standard.rusty_mail_coif]
			]);

			if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60) {
				helmetList.extend([
					[10, ::Legends.Helmet.Standard.marauder_helmet_with_closed_mail]
					//[5, ::Legends.Helmet.Standard.flat_top_with_rusty_mail]
				]);
			}
		} else {
			helmetList.extend([
				[2, ::Legends.Helmet.Standard.headscarf],
				[1, ::Legends.Helmet.Standard.rusty_mail_coif]
			]);
			::Legends.Perks.grant(this, ::Legends.Perk.SteelBrow);
		}
		this.getItems().equip(::Const.World.Common.pickHelmet(helmetList));
	}
});
