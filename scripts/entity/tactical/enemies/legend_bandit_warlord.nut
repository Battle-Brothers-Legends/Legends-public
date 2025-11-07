this.legend_bandit_warlord <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.BanditWarlord;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.BanditWarlord.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Raider;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_bandit_melee_agent_less_flanking");
		this.m.AIAgent.setActor(this);

		this.m.OnDeathLootTable.extend([
			[5, "scripts/items/misc/legend_masterwork_fabric"],
			[5, "scripts/items/misc/legend_masterwork_metal"],
			[5, "scripts/items/misc/legend_masterwork_tools"]
		]);
	}

	function generateName()
	{
		local vars = [
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomtown",
				this.Const.World.LocationNames.VillageWestern[this.Math.rand(0, this.Const.World.LocationNames.VillageWestern.len() - 1)]
			]
		];
		return this.buildTextFromTemplate(this.Const.Strings.BanditLeaderNames[this.Math.rand(0, this.Const.Strings.BanditLeaderNames.len() - 1)], vars);
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditWarlord);
		b.IsImmuneToDisarm = true;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.6);
		this.getSprite("shield_icon").setBrightness(0.6);
		::Legends.Perks.grant(this, ::Legends.Perk.Captain);
		::Legends.Perks.grant(this, ::Legends.Perk.ShieldExpert);
		::Legends.Perks.grant(this, ::Legends.Perk.Brawny);
		::Legends.Perks.grant(this, ::Legends.Perk.NineLives);
		::Legends.Perks.grant(this, ::Legends.Perk.CoupDeGrace);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSmackdown);
		::Legends.Perks.grant(this, ::Legends.Perk.Overwhelm);
		::Legends.Perks.grant(this, ::Legends.Perk.QuickHands);
		::Legends.Perks.grant(this, ::Legends.Perk.Rotation);
		::Legends.Perks.grant(this, ::Legends.Perk.Recover);
		::Legends.Perks.grant(this, ::Legends.Perk.BattleForged);
		::Legends.Perks.grant(this, ::Legends.Perk.InspiringPresence);
		::Legends.Perks.grant(this, ::Legends.Perk.RallyTheTroops);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendImmovableObject);
		::Legends.Perks.grant(this, ::Legends.Perk.LoneWolf); // Am I unfair? No - it is the players who are wrong.
		::Legends.Perks.grant(this, ::Legends.Perk.LegendComposure);
		::Legends.Perks.grant(this, ::Legends.Perk.Underdog);
		::Legends.Perks.grant(this, ::Legends.Perk.LegendTrueBeliever);

		if (::Legends.isLegendaryDifficulty())
		{
			::Legends.Perks.grant(this, ::Legends.Perk.LegendLithe);
			::Legends.Perks.grant(this, ::Legends.Perk.Relentless);
			::Legends.Perks.grant(this, ::Legends.Perk.Dodge);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendStrengthInNumbers);
			::Legends.Perks.grant(this, ::Legends.Perk.LegendBattleheart);
			::Legends.Traits.grant(this, ::Legends.Trait.Fearless);
		}

		::Legends.S.scaleBaseProperties(b);
	}

	function assignRandomEquipment()
	{
		local weightName;
		local shields = clone this.Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);
		local r = this.Math.rand(1, 100);
		if (r > 25)
		{
			local namedWeaponArray = clone ::Const.Items.NamedMeleeWeapons;
			::MSU.Array.remove(namedWeaponArray, "weapons/named/named_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_parrying_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_shovel");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_sickle");
			this.getItems().equip(this.Const.World.Common.pickItem(namedWeaponArray.map(@(_it) [1, _it]), "scripts/items/"));
		}
		else
		{
			this.getItems().equip(this.Const.World.Common.pickItem(shields.map(@(_it) [1, _it]), "scripts/items/"));
		}

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/fighting_axe",
				"weapons/warhammer",
				"weapons/boar_spear",
				"weapons/winged_mace",
				"weapons/arming_sword",
				"weapons/military_cleaver"
			];

			if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/legend_swordstaff",
					"weapons/legend_longsword",
					"weapons/warbrand",
					"weapons/legend_estoc",
					"weapons/legend_battle_glaive"
				]);
			}
			this.getItems().equip(this.Const.World.Common.pickItem(weapons.map(@(_it) [1, _it]), "scripts/items/"));
		}

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			this.getItems().equip(::Const.World.Common.pickItem([
				[1, "shields/wooden_shield"],
				[1, "shields/heater_shield"],
				[1, "shields/kite_shield"],
			], "scripts/items/"));
		}

		if (this.Math.rand(1, 100) > 50)
		{
			local named = this.Const.Items.NamedArmors;
			weightName = this.Const.World.Common.convNameToList(named);
			this.getItems().equip(this.Const.World.Common.pickArmor(weightName));

		}
		else
		{
			local named = this.Const.Items.NamedHelmets;
			weightName = this.Const.World.Common.convNameToList(named);
			this.getItems().equip(this.Const.World.Common.pickHelmet(weightName));
		}

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			this.getItems().equip(::Const.World.Common.pickArmor([
				[1, ::Legends.Armor.Standard.bandit_armor_ultraheavy],
				[2, ::Legends.Armor.Standard.coat_of_plates],
				[2, ::Legends.Armor.Standard.coat_of_scales],
				[2, ::Legends.Armor.Standard.heavy_lamellar_armor],
				[1, ::Legends.Armor.Standard.reinforced_mail_hauberk],
				[1, ::Legends.Armor.Standard.brown_hedgeknight_armor],
				[1, ::Legends.Armor.Standard.northern_mercenary_armor_02]
			]));
		}

		if (this.getItems().getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			this.getItems().equip(::Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.closed_mail_coif],
				[1, ::Legends.Helmet.Standard.legend_enclave_vanilla_kettle_sallet_01],
				[1, ::Legends.Helmet.Standard.padded_kettle_hat],
				[1, ::Legends.Helmet.Standard.kettle_hat_with_closed_mail],
				[1, ::Legends.Helmet.Standard.kettle_hat_with_mail],
				[1, ::Legends.Helmet.Standard.padded_flat_top_helmet],
				[1, ::Legends.Helmet.Standard.nasal_helmet_with_mail],
				[1, ::Legends.Helmet.Standard.flat_top_with_mail],
				[1, ::Legends.Helmet.Standard.padded_nasal_helmet],
				[1, ::Legends.Helmet.Standard.bascinet_with_mail]
			]));
		}
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss())
			return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});
