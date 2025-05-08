this.legend_preserver_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_preserver"; //always female
		this.m.Name = "Preserver";
		this.m.Icon = "ui/backgrounds/background_necromancer_2.png";
		this.m.BackgroundDescription = "Preservers practice the art of anatomy over ressurection - taking a more scientific approach to how dead things work.";
		this.m.GoodEnding = "As time went on, %name% found work not too far from where they once grew up. The local village needed a new herbalist to heal the sick and tend to the wounded coming back from the wars. %name% occasionally recognised some of the casualties that ended up in her hut as a few of those who got away in the past. Thankfully they did not have the same attention to detail.";
		this.m.BadEnding = "%name% continued to move with the company for some time. As time went on their interest in the sciences around the dead shifted more from the living and further towards the dead. Living in a graveyard with a few puppets for company, %name% was eventually subdued and burnt at the stake by a mercenary company sent to clear the graveyard.";
		this.m.HiringCost = 1200000000000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.Titles = [
			"the Morbid",
			"the Surgeon",
			"the Butcher",
			"the Fleshshaper"
		];
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Ethnicity = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Kind;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Druid | this.Const.BackgroundType.Female;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[3];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.0, //hills
				0.10, //forest
				0.10, //forest
				0.10, //forest_leaves
				0.10, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.02, // snow
				0.02, // badlands
				0.02, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
		this.m.CustomPerkTree = [
		[
			::Legends.Perk.LegendSpecialistShepherd,
			::Legends.Perk.NineLives,
			::Legends.Perk.CripplingStrikes,
			::Legends.Perk.BagsAndBelts,
			::Legends.Perk.LegendSpecialistReaper,
			::Legends.Perk.LegendSpecialistHerbalist,
			::Legends.Perk.Student,
			::Legends.Perk.Recover,
			::Legends.Perk.LegendMedPackages,
			::Legends.Perk.LegendAlert
		],
		[
			::Legends.Perk.Dodge,
			::Legends.Perk.HoldOut,
			::Legends.Perk.FortifiedMind,
			::Legends.Perk.Gifted,
			::Legends.Perk.Bullseye,
			::Legends.Perk.LegendGatherer,
			::Legends.Perk.LegendPrepareBleed,
			::Legends.Perk.LegendPrepareGraze
		],
		[
			::Legends.Perk.Backstabber,
			::Legends.Perk.LegendDebilitate,
			::Legends.Perk.LegendFavouredEnemyCaravan,
			::Legends.Perk.LegendLookout,
			::Legends.Perk.RallyTheTroops,
			::Legends.Perk.InspiringPresence,
			::Legends.Perk.LegendTrueBeliever,
			::Legends.Perk.LegendSpecialistSelfdefense,
			::Legends.Perk.LegendBloodbath
		],
		[
			::Legends.Perk.SpecSword,
			::Legends.Perk.SpecCleaver,
			::Legends.Perk.LegendMasteryStaves,
			::Legends.Perk.LegendPotionBrewer,
			::Legends.Perk.SpecPolearm,
			::Legends.Perk.LegendMasterySlings,
			::Legends.Perk.LegendSpecPoison,
			::Legends.Perk.LegendSpecBandage
		],
		[
			::Legends.Perk.Nimble,
			::Legends.Perk.LegendSpecStaffStun,
			::Legends.Perk.LegendFavouredEnemyGhoul,
			::Legends.Perk.LegendBlendIn,
			::Legends.Perk.LegendMindOverBody,
			::Legends.Perk.LegendMedIngredients,
			::Legends.Perk.LegendConservation,
			::Legends.Perk.LegendCarnage
		],
		[
			::Legends.Perk.LegendClarity,
			::Legends.Perk.LegendReclamation,
			::Legends.Perk.LegendHerbcraft,
			::Legends.Perk.LegendFavouredEnemyHexen,
			::Legends.Perk.LegendRebound
		],
		[
			::Legends.Perk.Fearsome,
			::Legends.Perk.LegendPerfectFocus,
			::Legends.Perk.LegendFreedomOfMovement,
			::Legends.Perk.LegendBalance,
			::Legends.Perk.LegendInspire,
			::Legends.Perk.LegendFieldTriage
		],
		[],
		[],
		[],
		[]
	];
	}

	function onBuildDescription()
	{
		return "{After being raised as a peasant girl in a backwater town, %name% took a shine to gathering herbs with their mother. | %name% did not get far in later life, often failing to gather what was asked of her by local herbalists. | %name% became more interested in how to kill rather than heal, which lead to them being run out of the village as a young girl after exhuming a fresh grave. | %name% wandered far and wide, often around %randomtown% until they had an outbreak of living dead from the nearby graveyard. | After being led into the forest and left to die by her parents, %name% found a local Hexe hiding amonst the ruins of an old hut. The tale goes that %name% slew the hag by pushing her into her own boiling pot. Like anyone would believe that.} {Regardless of their path, all roads led to %name% discovering a lone necromancer on the road. Who offered to take her in and teach her how to reach her full potential.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				7,
				13
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				10,
				20
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 1;
		talents[this.Const.Attributes.Initiative] = 1;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			[3, ::Legends.Helmet.Standard.necromancer_hat],
			[2, ::Legends.Helmet.Standard.dark_cowl],
			[1, ::Legends.Helmet.None],
			[4, ::Legends.Helmet.Standard.witchhunter_hat]
		]));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.thick_dark_tunic]
		]));
		local r;
		r = this.Math.rand(0, 8);

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
		else if (r >= 4)
		{
		 items.equip(this.new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}
	}
});
