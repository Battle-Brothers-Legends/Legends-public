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
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.EagleEyes),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendFearDark),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot)
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
					::Legends.Perk.NineLives,
					::Legends.Perk.LegendAlert,
					::Legends.Perk.CripplingStrikes,
					::Legends.Perk.BagsAndBelts,
					::Legends.Perk.Recover,
					::Legends.Perk.LegendWither,
					::Legends.Perk.LegendSpecialistCultist,
					::Legends.Perk.LegendSpecialistReaper,
					::Legends.Perk.LegendSpawnZombieLow,
					::Legends.Perk.LegendPossession
				],
				[
					::Legends.Perk.LegendReclamation,
					::Legends.Perk.LegendSpecCultHood,
					::Legends.Perk.FortifiedMind,
					::Legends.Perk.Overwhelm,
					::Legends.Perk.LegendTrueBeliever,
					::Legends.Perk.LegendRust,
					::Legends.Perk.LegendDeathtouch,
					::Legends.Perk.LegendGatherer,
					::Legends.Perk.LegendMedPackages,
					::Legends.Perk.RallyTheTroops
				],
				[
					::Legends.Perk.LegendMiasma,
					::Legends.Perk.LegendDebilitate,
					::Legends.Perk.LegendFavouredEnemyCaravan,
					::Legends.Perk.LegendSpawnZombieMed,
					::Legends.Perk.LegendChanneledPower,
					::Legends.Perk.LegendSpecialistSelfdefense,
					::Legends.Perk.LegendBloodbath
				],
				[
					::Legends.Perk.SpecDagger,
					::Legends.Perk.SpecMace,
					::Legends.Perk.SpecSword,
					::Legends.Perk.SpecCleaver,
					::Legends.Perk.LegendMasteryStaves,
					::Legends.Perk.SpecPolearm,
					::Legends.Perk.LegendSpecPoison,
					::Legends.Perk.LegendSpecBandage,
					::Legends.Perk.LegendExtendendAura
				],
				[
					::Legends.Perk.LegendLacerate,
					::Legends.Perk.LegendLithe,
					::Legends.Perk.LegendSpecStaffStun,
					::Legends.Perk.LegendFavouredEnemyGhoul,
					::Legends.Perk.LegendViolentDecomposition,
					::Legends.Perk.LegendMedIngredients,
					::Legends.Perk.LegendConservation,
					::Legends.Perk.LegendCarnage,
					::Legends.Perk.LegendSpawnZombieHigh
				],
				[
					::Legends.Perk.LegendFavouredEnemyHexen,
					::Legends.Perk.LegendFavouredEnemyAlps,
					::Legends.Perk.LegendGruesomeFeast,
					::Legends.Perk.LegendHerbcraft,
					::Legends.Perk.LegendRebound,
					::Legends.Perk.LegendSpecCultArmor,
					::Legends.Perk.Backstabber,
					::Legends.Perk.CoupDeGrace
				],
				[
					::Legends.Perk.Fearsome,
					::Legends.Perk.Footwork,
					::Legends.Perk.Nimble,
					::Legends.Perk.LegendPerfectFocus,
					::Legends.Perk.LegendFreedomOfMovement,
					::Legends.Perk.LegendBalance,
					::Legends.Perk.LegendClarity,
					::Legends.Perk.ReachAdvantage
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
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Experience Gain"
			}
		);
		return ret;
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
		::Legends.Traits.grant(this, ::Legends.Trait.Old);
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
