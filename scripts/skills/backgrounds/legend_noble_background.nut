this.legend_noble_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_noble";
		this.m.Name = "Noble";
		this.m.Icon = "ui/backgrounds/noble_02.png";
		this.m.BackgroundDescription = "A noble of the realm, practiced in fencing but quite unfit";
		this.m.GoodEnding = "Adventurousness never leaves the soul of a man like %name%. {Instead of returning to the armed services, he left the %companyname% and headed east in search of rare beasts. Word has it he returned to town with the head of what looked like a giant lizard, but you don\'t believe such fantastical tripe. | He departed the %companyname% and ventured west, sailing across the oceans to unseen lands. There\'s no telling where he is these days, but you\'ve little doubt that he\'ll be coming back with stories to tell. | He retired from the %companyname% and, instead of returning to his noble family, headed south. Word has it he fought in a great noble civil war, killed an orc warlord, climbed the highest mountain in the land, and is currently writing an epic about his travels. | The nobleman left the %companyname% and, preferring the life of adventure to noble boredom, he headed north. Word has it that he\'s currently marching a troop of explorers to the furthest reaches of the world.}";
		this.m.BadEnding = "%name% departed the %companyname% and continued his adventuring elsewhere. {He headed east, hoping to discover the source of the greenskins, but the nobleman has not been heard from since. | He headed north into the snowy wastes. Word has it he was seen a week ago, marching south this time, looking rather pale and shuffling moreso than walking. | He headed south into brutal marshlands. Word has it that a mysterious flame appeared in the fog and he walked toward it. The men who saw this said he disappeared into the mist and never returned. | He headed west and sailed the open sea. Despite having no experience at sea, he saw fit to make himself captain of the boat. They say pieces of his ship and dead sailors kept washing ashore for weeks.}";
		this.m.HiringCost = 2000;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.IsGuaranteed = ["disloyal_trait"];
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.Level = 2;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Untalented;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.Adrenaline,
				::Legends.Perk.Backstabber,
				::Legends.Perk.CripplingStrikes,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.NineLives,
				::Legends.Perk.Student,
				::Legends.Perk.Recover,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.LegendBackToBasics
			],
			[
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Dodge,
				::Legends.Perk.HoldOut,
				::Legends.Perk.SteelBrow,
				::Legends.Perk.QuickHands,
				::Legends.Perk.FortifiedMind,
				::Legends.Perk.Gifted,
				::Legends.Perk.LegendAthlete,
				// ::Legends.Perk.LegendComposure
			],
			[
				::Legends.Perk.Brawny,
				::Legends.Perk.Anticipation,
				::Legends.Perk.Taunt,
				::Legends.Perk.LegendFeint,
				::Legends.Perk.RallyTheTroops,
				::Legends.Perk.InspiringPresence,
				::Legends.Perk.LegendToolsDrawers,
				::Legends.Perk.LegendTrueBeliever,
				::Legends.Perk.LegendFavouredEnemyCaravan,
				::Legends.Perk.LegendOnslaught
			],
			[
				::Legends.Perk.SpecPolearm,
				::Legends.Perk.SpecSword,
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecCrossbow,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.LegendSpecBandage,
				::Legends.Perk.LegendEfficientPacking,
				::Legends.Perk.LegendBarterConvincing,
				::Legends.Perk.LegendShieldsUp
			],
			[
				::Legends.Perk.ReachAdvantage,
				::Legends.Perk.Overwhelm,
				::Legends.Perk.Underdog,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.LegendLithe,
				::Legends.Perk.LegendFavouredEnemyBandit,
				::Legends.Perk.LegendFavouredEnemyBarbarian,
				::Legends.Perk.LegendHoldTheLine
			],
			[
				::Legends.Perk.Berserk,
				::Legends.Perk.LegendClarity,
				::Legends.Perk.HeadHunter,
				::Legends.Perk.BattleForged,
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendPerfectFit,
				::Legends.Perk.LegendFavouredEnemyMercenary,
				::Legends.Perk.LegendForwardPush,
				::Legends.Perk.LegendCoordinatedVolleys
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.Duelist,
				::Legends.Perk.LegendInspire,
				::Legends.Perk.LegendMindOverBody,
				::Legends.Perk.LegendBribe,
				::Legends.Perk.LegendBalance,
				::Legends.Perk.LegendFieldTriage,
				::Legends.Perk.LegendRelax,
				::Legends.Perk.LegendFieldRepairs,
				::Legends.Perk.LegendFavouredEnemyNoble
			],
			[],
			[],
			[],
			[]
		];
	}



	function onBuildDescription()
	{
		return "{A viscount of the realm | As the third in the line of the noble retinue | A young and brash noble | A skilled swordsman}, %name%\'s life at court {had grown stale for him | was not exciting enough for him with endless studying of tactics and strategy | felt like wasting the best time of his life | was not half as exciting to him as the tales of adventures, battles, fearsome beasts to vanquish and fair maidens to conquer}. {Wearing the house crest proudly | At the encouragement of his brother | To the frustration of his mother | Finally making a decision to change things}, %name% rode out to {prove himself | make a name for himself | earn glory on the battlefield | test his skills in battle} and {live life to its fullest as he imagined it from behind the castle walls | see all the wonders and exotic places of the world | earn his place in the world | be knighted for his valor | become famous and loved in all the known world | become infamous and feared in all the known world}.";
	}



	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-10
			],
			Bravery = [
				20,
				20
			],
			Stamina = [
				-10,
				-10
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				5,
				5
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.noble_tunic]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.legend_noble_hat],
			[1, ::Legends.Helmet.Standard.legend_noble_crown],
			[1, ::Legends.Helmet.Standard.legend_noble_floppy_hat],
			[1, ::Legends.Helmet.Standard.legend_noble_hood]
		]));
		local r;
		r = this.Math.rand(1, 3);

		if (r <= 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
			items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/fencing_sword"));
			items.equip(this.new("scripts/items/weapons/legend_parrying_dagger"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/legend_estoc"));
		}
	}
});
