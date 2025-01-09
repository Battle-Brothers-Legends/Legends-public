this.legend_necro_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_necro";
		this.m.Name = "Master Necromancer";
		this.m.Icon = "ui/backgrounds/warlock_01.png";
		this.m.BackgroundDescription = "Years of practical training and close calls have shaped %name% into a cold, dark figure capable of calling colder and darker followers to serve them.";
		this.m.GoodEnding = "What awaits you at the top? You move from place to place and nothing ever holds your attention for long. Your mind bristles with ideas but the company you keep often fails to keep up in more ways than one. You repeated the same routes, strategies and maximised your efforts, perhaps cutting a few too many corners along the way. Why are you not happy? Is this not what you wanted? Nothing stirs within you — maybe you should have taken things more slowly? Enjoyed the small moments? Even if you did, would it change this outcome? Was this all too easy? Or perhaps too hard? Regardless, you are here now, and you can\'t go back anymore...";
		this.m.BadEnding = "What awaits you at the top? You move from place to place and nothing ever holds your attention for long. Your mind bristles with ideas but the company you keep often fails to keep up in more ways than one. You repeated the same routes, strategies and maximised your efforts, perhaps cutting a few too many corners along the way. Why are you not happy? Is this not what you wanted? Nothing stirs within you — maybe you should have taken things more slowly? Perhaps enjoyed the small moments? Even if you did, would it change this outcome? Was this all too easy? Or perhaps too hard? Regardless, you are here now, and you can\'t go back anymore...";
		this.m.HiringCost = 1200000000000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.brave",
			"trait.athletic",
			"trait.brute",
			"trait.dexterous",
			"trait.eagleyes",
			"trait.loyal",
			"trait.quick",
			"trait.swift",
			"trait.tough",
			"trait.disloyal",
			"trait.hate_undead",
			"trait.fear_undead",
			"trait.gluttonous",
			"trait.cocky",
			"trait.dumb",
			"trait.craven",
			"trait.greedy",
			"trait.bloodthirsty",
			"trait.legend_fear_dark",
			"trait.legend_sureshot"
		];
		this.m.Titles = [
			"the Sickening",
			"the Wretched",
			"the Widow Taunter",
			"the Hidden Hand",
			"the Fleshturner",
			"The Corpse Dancer",
			"the Puppeteer",
			"the Morbid",
			"the Surgeon",
			"the Waker",
			"the Gravewalker",
			"the Butcher",
			"the Fleshshaper",
			"the Overseer"
		];
		this.m.Faces = this.Const.Faces.NecromancerMale;
		this.m.Hairs = this.Const.Hair.Necromancer;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Raider;

		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];

		this.m.ExcludedTalents = [
			this.Const.Attributes.Fatigue,
			this.Const.Attributes.Bravery
		];

		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.15, //swamp
				0.0, //hills
				0.10, //forest
				0.10, //forest
				0.10, //forest_leaves
				0.10, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];

			this.m.CustomPerkTree = [
				[
					this.Const.Perks.PerkDefs.NineLives,
					this.Const.Perks.PerkDefs.LegendAlert,
					this.Const.Perks.PerkDefs.CripplingStrikes,
					this.Const.Perks.PerkDefs.BagsAndBelts,
					this.Const.Perks.PerkDefs.Recover,
					this.Const.Perks.PerkDefs.LegendWither,
					this.Const.Perks.PerkDefs.LegendSpecialistNinetailsSkill,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheSkill,
					this.Const.Perks.PerkDefs.LegendSpawnZombieLow,
					this.Const.Perks.PerkDefs.LegendPossession
				],
				[
					this.Const.Perks.PerkDefs.LegendReclamation,
					this.Const.Perks.PerkDefs.LegendSpecCultHood,
					this.Const.Perks.PerkDefs.FortifiedMind,
					this.Const.Perks.PerkDefs.Overwhelm,
					this.Const.Perks.PerkDefs.LegendTrueBeliever,
					this.Const.Perks.PerkDefs.LegendRust,
					this.Const.Perks.PerkDefs.LegendDeathtouch,
					this.Const.Perks.PerkDefs.LegendGatherer,
					this.Const.Perks.PerkDefs.LegendMedPackages,
					this.Const.Perks.PerkDefs.RallyTheTroops
				],
				[
					this.Const.Perks.PerkDefs.LegendMiasma,
					this.Const.Perks.PerkDefs.LegendDebilitate,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
					this.Const.Perks.PerkDefs.LegendSpawnZombieMed,
					this.Const.Perks.PerkDefs.LegendChanneledPower,
					this.Const.Perks.PerkDefs.LegendSpecialistNinetailsDamage,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
					this.Const.Perks.PerkDefs.LegendSpecStaffSkill,
					this.Const.Perks.PerkDefs.LegendBloodbath
				],
				[
					this.Const.Perks.PerkDefs.SpecDagger,
					this.Const.Perks.PerkDefs.SpecMace,
					this.Const.Perks.PerkDefs.SpecSword,
					this.Const.Perks.PerkDefs.SpecCleaver,
					this.Const.Perks.PerkDefs.LegendMasteryStaves,
					this.Const.Perks.PerkDefs.SpecPolearm,
					this.Const.Perks.PerkDefs.LegendSpecPoison,
					this.Const.Perks.PerkDefs.LegendSpecBandage,
					this.Const.Perks.PerkDefs.LegendExtendendAura
				],
				[
					this.Const.Perks.PerkDefs.LegendLacerate,
					this.Const.Perks.PerkDefs.LegendLithe,
					this.Const.Perks.PerkDefs.LegendSpecStaffStun,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
					this.Const.Perks.PerkDefs.LegendViolentDecomposition,
					this.Const.Perks.PerkDefs.LegendMedIngredients,
					this.Const.Perks.PerkDefs.LegendConservation,
					this.Const.Perks.PerkDefs.LegendCarnage,
					this.Const.Perks.PerkDefs.LegendSpawnZombieHigh
				],
				[
					this.Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
					this.Const.Perks.PerkDefs.LegendGruesomeFeast,
					this.Const.Perks.PerkDefs.LegendHerbcraft,
					this.Const.Perks.PerkDefs.LegendRebound,
					this.Const.Perks.PerkDefs.LegendSpecCultArmor,
					this.Const.Perks.PerkDefs.Backstabber,
					this.Const.Perks.PerkDefs.CoupDeGrace
				],
				[
					this.Const.Perks.PerkDefs.Fearsome,
					this.Const.Perks.PerkDefs.Footwork,
					this.Const.Perks.PerkDefs.Nimble,
					this.Const.Perks.PerkDefs.LegendPerfectFocus,
					this.Const.Perks.PerkDefs.LegendFreedomOfMovement,
					this.Const.Perks.PerkDefs.LegendBalance,
					this.Const.Perks.PerkDefs.LegendClarity,
					this.Const.Perks.PerkDefs.ReachAdvantage
				],
				[],
				[],
				[],
				[]
			];
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.NecromancerFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Experience Gain"
			}
		)
		return ret
	}

	function onBuildDescription() //—
	{
		return "Clothed in the un-reality of your life\'s work, manipulating the undead is second nature. With nothing to fear, manipulating people was not much more difficult. Despite the pacts you have made and the enemies bested along the way, you feel age catching up to you. How long has it been — how much longer is there to go?";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				20,
				25
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				2,
				6
			],
			RangedSkill = [
				10,
				18
			],
			MeleeDefense = [
				2,
				5
			],
			RangedDefense = [
				3,
				6
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		::Legends.Perks.grant(this, ::Legends.Perk.LegendSiphon);
		this.m.Container.add(this.new("scripts/skills/traits/old_trait"));
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "necromancer_hat"],
			[2, "dark_cowl"],
			[2, "undertaker_hat"],
			[3, "witchhunter_hat"],
			[3, "physician_mask"]
		]));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"],
			[1, "ragged_dark_surcoat"],
			[2, "undertaker_apron"],
			[2, "wanderers_coat"]
		]));

		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/legend_sickle"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/battle_whip"));
		}
		else if (r == 4)
		{
		 items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.15;
	}
});
