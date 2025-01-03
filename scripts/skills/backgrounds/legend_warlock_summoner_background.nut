this.legend_warlock_summoner_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_warlock_summoner";
		this.m.Name = "Summoner";
		this.m.Icon = "ui/backgrounds/background_necromancer_4.png";
		this.m.BackgroundDescription = "Summoners practice raising the dead from the earth, what they do after that is anyone's guess...";
		this.m.GoodEnding = "%name% continued to look for a cure to their ailments after you left the company. A few years later they would wander into the woods and meet a witch who was more than happy to help at the cost of some protection. %name% and the witch lived out most of their lives away from prying eyes, surrounded by ever shifting rings of undead patrolling the perimiter.";
		this.m.BadEnding = "Seeing their affliction as a permament problem that wouldn\'t go away, %name% split from the company shorting after your departure. They took a differant approach and looked for cures closer to the grave, allowing a puppet of their own correction to bite them. Upon taking their own life shortly after, %name% did not rise as co herant as they intended - instead as a spectator to their own body's actions. They remained trapped and decaying until a mercenary company cut them down outside of a nameless hamlet.";
		this.m.HiringCost = 1200000000000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.fear_undead",
			"trait.brute",
			"trait.gluttonous",
			"trait.disloyal",
			"trait.dumb",
			"trait.craven",
			"trait.tough",
			"trait.huge",
			"trait.legend_firm",
			"trait.strong",
			"trait.spartan",
			"trait.fat",
			"trait.lumbering",
			"trait.greedy"
		];
		this.m.Titles = [
			"the Raiser",
			"the Waker",
			"the Gravewalker",
			"the Summoner"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue
		];
		this.m.Faces = this.Const.Faces.Necromancer;
		this.m.Hairs = this.Const.Hair.Vampire;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Raider;

		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.1, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
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
				this.Const.Perks.PerkDefs.CripplingStrikes,
				this.Const.Perks.PerkDefs.BagsAndBelts,
				this.Const.Perks.PerkDefs.Student,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.LegendBalance,
				this.Const.Perks.PerkDefs.LegendSpecialistScytheSkill,
				this.Const.Perks.PerkDefs.LegendSpawnZombieLow
			],
			[
				this.Const.Perks.PerkDefs.CoupDeGrace,
				this.Const.Perks.PerkDefs.FortifiedMind,
				this.Const.Perks.PerkDefs.Gifted,
				this.Const.Perks.PerkDefs.LegendPerfectFit,
				this.Const.Perks.PerkDefs.LegendTrueBeliever,
				this.Const.Perks.PerkDefs.LegendPrepareBleed,
				this.Const.Perks.PerkDefs.LegendPrepareGraze
			],
			[
				this.Const.Perks.PerkDefs.Backstabber,
				this.Const.Perks.PerkDefs.LegendDebilitate,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
				this.Const.Perks.PerkDefs.LegendLookout,
				this.Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
				this.Const.Perks.PerkDefs.LegendSpecStaffSkill,
				this.Const.Perks.PerkDefs.LegendBloodbath
			],
			[
				this.Const.Perks.PerkDefs.SpecDagger,
				this.Const.Perks.PerkDefs.SpecMace,
				this.Const.Perks.PerkDefs.SpecCleaver,
				this.Const.Perks.PerkDefs.SpecPolearm,
				this.Const.Perks.PerkDefs.LegendMasteryStaves,
				this.Const.Perks.PerkDefs.LegendSpecPoison,
				this.Const.Perks.PerkDefs.LegendLacerate,
				this.Const.Perks.PerkDefs.LegendSpawnZombieMed
			],
			[
				this.Const.Perks.PerkDefs.Underdog,
				this.Const.Perks.PerkDefs.LegendLithe,
				this.Const.Perks.PerkDefs.LegendSpecStaffStun,
				this.Const.Perks.PerkDefs.LegendBlendIn,
				this.Const.Perks.PerkDefs.LegendReclamation,
				this.Const.Perks.PerkDefs.LegendCarnage
			],
			[
				this.Const.Perks.PerkDefs.LegendClarity,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
				this.Const.Perks.PerkDefs.Taunt
			],
			[
				this.Const.Perks.PerkDefs.Fearsome,
				this.Const.Perks.PerkDefs.LegendPerfectFocus,
				this.Const.Perks.PerkDefs.LegendPush,
				this.Const.Perks.PerkDefs.LegendSpawnZombieHigh,
				this.Const.Perks.PerkDefs.LegendExtendendAura,
				this.Const.Perks.PerkDefs.LegendInTheZone
			],
			[],
			[],
			[],
			[]
		];
	}

	function onBuildDescription()
	{
		return "{Born sick and lame, %name% grew up in %randomtown% not far from the frozen north. Their sickness often caused them to be shunned by their own community and they quickly turned to the gravestones as a means to keep company. | By curious gift or freak of nature, %name% discovered that they could make arms, fingers and toes of corpses twitch from the corpses of the mass graves in their village. The first step on the road to where they are now. | %name% attempts to hide their face and skin as much as possible. Their skin is pocked with rashes and weeping sores that never heal. Once blood starts to flow from their body, it never stops. | %name% has always had an affinity with the dead. They do not attack him and often gravitate towards his presence. Controlling them has proved difficult however. | %name% coughs and wheezes with every other breath, almost as if they were treading the line closer between life and death than anyone else would be able to manage. | %name% could easily manipulate the dead from a young age and would often visit the mass graves left by soldiers outside of town. | %name% was chronically ill as a child and continues to be so. Their condition forced them out of society and they spent many an evening talking to the hanged men outside of town.} {%name% only had one outcome in life - to serve a greater necromancer. He found %name% taking shelter in an old ruin outside of %randomtown%. Whatever he saw, it had potential.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-5
			],
			Bravery = [
				5,
				10
			],
			Stamina = [
				-10,
				-5
			],
			MeleeSkill = [
				-2,
				0
			],
			RangedSkill = [
				-4,
				-2
			],
			MeleeDefense = [
				4,
				6
			],
			RangedDefense = [
				5,
				7
			],
			Initiative = [
				-15,
				-5
			]
		};
		return c;
	}


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		//items
		items.equip(this.Const.World.Common.pickHelmet([
			[3, "necromancer_hat"],
			[2, "dark_cowl"],
			[1, ""],
			[4, "witchhunter_hat"]
		]));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"],
			[1, "ragged_dark_surcoat"]
		]));

		items.equip(this.new("scripts/items/weapons/legend_staff"));
	}
});
