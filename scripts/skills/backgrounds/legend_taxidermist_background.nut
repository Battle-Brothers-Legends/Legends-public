this.legend_taxidermist_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_taxidermist";
		this.m.Name = "Taxidermist";
		this.m.Icon = "ui/backgrounds/taxidermist.png";
		this.m.BackgroundDescription = "Taxidermists are good at gutting beasts, but not fighting them.";
		this.m.GoodEnding = "What was a taxidermist doing in a mercenary company? A good question, but %name% got so much practice collecting trophies he became one of the most skilled taxidermists in the land. After a few good years in the company, he eventually left to start up a business creating trinkets from rare beasts. His name is world-renowned, well, the known-world-renowned, and he gets so much business he\'s making a very different killing these days.";
		this.m.BadEnding = "A taxidermist at heart, it didn\'t take much to compel %name% to bail from the quickly sinking company. He left to go start a business, but was kidnapped along the way by a group of brigands. When they threatened to kill him, he pretended to be a simple and weak taxidermist and showed his talents in creating trinkets. Impressed, the superstitious outlaws took him into their band. A few days later they were all dead and this \'meek\' man walked out of their camp with a bit of red on him. He started his business a week later and is doing well to this day.";
		this.m.HiringCost = 250;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.hate_beasts",
			"trait.fear_beasts",
			"trait.athletic",
			"trait.clumsy",
			"trait.spartan",
			"trait.tough",
			"trait.cocky",
			"trait.dumb"

		];
		this.m.Titles = [
			"the Stuffer",
			"the Trophy Taker",
			"the Trinket Maker",
			"the Collector"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.BackgroundType = this.Const.BackgroundType.Ranger;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[3];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.GhoulTree,
				this.Const.Perks.DirewolfTree,
				this.Const.Perks.UnholdTree,
				this.Const.Perks.AlpTree
			],
			Class = [],
			Magic = []
		}
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color] crafting rate in the crafting tent, [color=" + this.Const.UI.Color.PositiveValue + "]-10%[/color] medicine usage, [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] maximum medicine capacity,  [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] faster healing while in the heal tent. "
			}
		);
		return ret;
	}
	function onBuildDescription()
	{
		return "{%name% was always curious about trinkets, seeing more science in the remains of beasts than {a diviner would in the sands of the desert. | a tailor would in a sheet of cloth. | an alchemist would in a mortar and pestle.} | %name% was always an odd boy growing up, cutting up toads and snails. | Son to a {tailor | squire | knight | miller}, %name%\'s turn toward fashioning trinkets was a surprise to all. | While %name%\'s sisters fancied being warriors and heroes, %name% thought of himself as a future trophy hunter. | %name% spent much of his youth chasing down rare creatures, but not for the reasons one might think. | %name% always fancied animals, particularly how they would look as a good coat or scarf. | As trophies and trinkets grew popular, %name% turned to taxidermy to make a crown or two. | With a surge in potion popularity, %name% went from being a tanner to a taxidermist to make more money. | %name% hails from a faraway land where what a man takes down is more important than how he fights. | Taxidermy is the science of components and entrails, by which standards %name% is renowned. | Good with measuring and calculating, %name% turned his mathematical prowess to taxidermy to earn as much as he could. | %name%\'s career in taxidermy started when his mother pushed him into the vocation to dodge a passing noble\'s conscription. | %name% took up taxidermy to honor his father, a taxidermist who was killed by an unhappy customer. | Widowed by war, %name%\'s mother taught him how to put his hands to better use in taxidermy instead of killing.} {When raiders attacked his home, %name% dressed everyone up as stuffed animals. The town was destroyed, but not a soul was lost. | He spent many years preparing trophies for royalty until a fashion faux pas led his being exiled. | Unfortunately, a man collecting parts of dead animals, as %name% is wont to do, left the taxidermist ostracized from many a village. | He tried to make his break in the big cities, but sadly he just could not compete with the other taxidermists. | When a lord organized an army, %name% handled the trinkets, giving the soldiers wards and potions. | But a fierce competition between taxidermists led to a preserved and stuffed deadman and %name% coincidentally leaving his shop behind. | Sadly, robbers ransacked his shop and, with the wars going on, it would be impossible to restock. | But when he sheared a sheep that did not belong to him, %name% was kicked out of town. | He once choked out a would-be thief with a cord of measuring wire. So he says, anyway. | But working for unlikeable and unfriendly nobility eventually {bored him. | wore on him.} | Once tasked with stuffing a particularly impressive beast, %name% wondered what the outside world was really like. | Designing a trophy adorned with teh results of {epic quests | epic feats}, %name% wondered if maybe he should be the one they wove stories about.} Now the taxidermist looks for a new life, no matter where it takes him. {Maybe he can create trophies to protect the unit, or something. | He\'s particular and peculiar, peppering everyone with questions about their trophies. | He\'s no natural soldier, but he appraises each kill as if assessing it to hang on a wall. | The way he measures and calculates for trophies, it\'s too bad %name% wasn\'t a siege engineer. | While hardly a soldier, %name%\'s familiarity with gutting beasts should come in handy. | %name%\'s knowledge of beasts is seriously impressive. | A bit on the nimbly-pimbly side, %name% has the gut cutting skills of swordfighter, but the swordfighting of a soft breeze. | %name% would seem very out of place in a suit of armor, but boy is he going to need one. | As it turns out, %name% can in fact make a silk purse out of a sow\'s ear. | Don\'t let his vocation fool you, %name% is more deft with his hands than some {cardsharks | jugglers | pickpockets}. | Taxidermists don\'t seem fit for combat, but then again neither do most of the men you run across these days. | A taxidermist seems ill-fit for combat, but cutting up beasts is an uncommon skill. | With an eye {for beast innards | for trophies}, %name% is a lot smarter than he lets on at first glance.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-3,
				0
			],
			Bravery = [
				5,
				5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				5,
				10
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
				0,
				5
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.Const.World.Common.pickArmor([
			[1, "legend_blacksmith_apron"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "feathered_hat"]
		]));
	}
});
