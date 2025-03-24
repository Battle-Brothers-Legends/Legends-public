::mods_hookExactClass("skills/backgrounds/tailor_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.tailor";
		this.m.Name = "Tailor";
		this.m.Icon = "ui/backgrounds/background_48.png";
		this.m.BackgroundDescription = "Tailors are not used to hard physical labor.";
		this.m.GoodEnding = "What was a tailor doing in a mercenary company? A good question, but %name% certainly answered it well by killing so many enemies they could\'ve made an epic tapestry out of story. After a few good years in the company, he eventually left to start up a business creating clothes for nobility. His name is world-renowned, well, the known-world-renowned, and he gets so much business he\'s making a very different killing these days.";
		this.m.BadEnding = "A tailor at heart, it didn\'t take much to compel %name% to bail from the quickly sinking company. He left to go start a business, but was kidnapped along the way by a group of brigands. When they threatened to kill him, he pretended to be a simple and weak tailor and showed his talents in creating clothes. Impressed, the raggedly dressed outlaws took him into their band. A few days later they were all dead and this \'meek\' man walked out of their camp with a bit of red on him. He started his business a week later and is doing well to this day.";
		this.m.HiringCost = 50;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial)
		];
		this.m.Titles = [
			"the Peculiar",
			"the Tailor",
			"the Particular",
			"the Fine",
			"Silkworm"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.CalmTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [this.Const.Perks.RepairClassTree],
			Magic = []
		}
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Seamstress";
		this.m.Icon = "ui/backgrounds/seamstress.png";
		this.m.BackgroundDescription = "Seamstresses are not used to hard physical labor.";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "What was a Seamstress doing in a mercenary company? A good question, but %name% certainly answered it well by killing so many enemies they could\'ve made an epic tapestry out of story. After a few good years in the company, she eventually left to start up a business creating clothes for nobility. Her name is world-renowned, well, the known-world-renowned, and she gets so much business she\'s making a very different killing these days.";
		this.m.BadEnding = "A tailor at heart, it didn\'t take much to compel %name% to bail from the quickly sinking company. She left to go start a business, but was kidnapped along the way by a group of brigands. When they threatened to kill her, she pretended to be a simple and weak tailor and showed her talents in creating clothes. Impressed, the raggedly dressed outlaws took her into their band. A few days later they were all dead and this \'meek\' woman walked out of their camp with a bit of red on her. She started his business a week later and is doing well to this day.";
	}

	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name% was always curious about fabrics, seeing more science in a linen cloth than {a diviner would in the sands of the desert. | a haruspex would in a toad\'s entrails. | an alchemist would in a mortar and pestle.} | %name% was always an odd girl growing up, fancying a good silk waistcoat instead of the boy beneath it. | Daughter to a {milling mother | fine lady | baroness | farmhand}, %name%\'s turn toward fashioning clothes was a surprise to all. | While %name%\'s sisters fancied being warriors and heroes, %name% thought of herself as a future dresser of kings. | %name% spent much of her youth in the company of girls, but not for the reasons one might think. | %name% always fancied animals, particularly how they would look as a good coat or scarf. | As tunics and shirts grew popular, %name% turned to seamstressing to make a crown or two. | With a surge in pantaloons popularity, %name% went from being a tanner to a seamstress to make more money. | %name% hails from a faraway land where how a man dresses is more important than how he fights. | Seamstressinging is the science of colors and fabrics, by which standards %name% is renowned. | Good with measuring and calculating, %name% turned her mathematical prowess to seamstressing to earn as much as she could. | %name%\'s career in seamstressing started when her mother pushed her into the vocation to dodge a passing noble\'s attentions. | %name% took up seamstressing to honor her father, a seamstress who was killed by an unhappy customer. | Widowed by war, %name%\'s mother taught her how to put her hands to better use in seamstressing instead of killing.} {When raiders attacked her home, %name% dressed everyone up in clever disguises. The town was destroyed, but not a soul was lost. | She spent many years dressing royalty until a fashion faux pas led her being exiled. | Unfortunately, a woman fancying a good fabric, as %name% is wont to do, left the seamstress ostracized from many a village. | She tried to make her break in the big cities, but sadly she just could not compete with the other seamstresses. | When a lord organized an army, %name% handled the clothes, giving the soldiers proper uniforms. | But a fierce competition between seamstresses led to a linen-wrapped deadman and %name% coincidentally leaving his shop behind. | Sadly, robbers ransacked her shop and, with the wars going on, it would be impossible to restock. | But when she sheared a sheep that did not belong to her, %name% was kicked out of town. | She once choked out a would-be thief with a cord of measuring wire. So she says, anyway. | But dressing unlikeable and unfriendly nobility eventually {bored her. | wore on her.} | Once tasked with making a tunic embroidered with epic feats, %name% wondered what the outside world was really like. | Designing a dress adorned with {epic quests | epic feats}, %name% wondered if maybe she should be the one they wove stories about.} Now the seamstress looks for a new life, no matter where it takes her. {Maybe she can dress the unit well, or something. | She\'s particular and peculiar, peppering everyone with clothing criticisms. | She\'s no natural soldier, but she appraises a man\'s attire as if he\'s about to go to war with it. | The way she measures and calculates for dressing, it\'s too bad %name% wasn\'t a siege engineer. | While hardly a soldier, %name%\'s earnest love for seamstressing is to be admired. | %name%\'s knowledge of various cloths is seriously impressive. | A bit on the nimby-pimbly side, %name% has the footwork of a swordfighter, but the swordfighting of a soft breeze. | %name% would seem very out of place in a suit of armor, but boy is she going to need one. | As it turns out, %name% can in fact make a silk purse out of a sow\'s ear. | Don\'t let his vocation fool you, %name% is more deft with her hands than some {cardsharks | jugglers | pickpockets}. | Seamstresses don\'t seem fit for combat, but then again neither do most of the men you run across these days. | A seamstress seems ill-fit for combat, yet for some reason you find the finest soldiers in the strangest of places. | With an eye {for calculations | for measuring}, %name% is a lot smarter than she lets on at first glance.}";
		}
		else
		{
			return "{%name% was always curious about fabrics, seeing more science in a linen cloth than {a diviner would in the sands of the desert. | a haruspex would in a toad\'s entrails. | an alchemist would in a mortar and pestle.} | %name% was always an odd boy growing up, fancying a good silk dress instead of the girl beneath it. | Son to a {mining father | squire | knight | farmhand}, %name%\'s turn toward fashioning clothes was a surprise to all. | While %name%\'s sisters fancied being warriors and heroes, %name% thought of himself as a future dresser of kings. | %name% spent much of his youth in the company of girls, but not for the reasons one might think. | %name% always fancied animals, particularly how they would look as a good coat or scarf. | As tunics and shirts grew popular, %name% turned to tailoring to make a crown or two. | With a surge in pantaloons popularity, %name% went from being a tanner to a tailor to make more money. | %name% hails from a faraway land where how a man dresses is more important than how he fights. | Tailoring is the science of colors and fabrics, by which standards %name% is renowned. | Good with measuring and calculating, %name% turned his mathematical prowess to tailoring to earn as much as he could. | %name%\'s career in tailoring started when his mother pushed him into the vocation to dodge a passing noble\'s conscription. | %name% took up tailoring to honor his father, a tailor who was killed by an unhappy customer. | Widowed by war, %name%\'s mother taught him how to put his hands to better use in tailoring instead of killing.} {When raiders attacked his home, %name% dressed everyone up in clever disguises. The town was destroyed, but not a soul was lost. | He spent many years dressing royalty until a fashion faux pas led his being exiled. | Unfortunately, a man fancying a good fabric, as %name% is wont to do, left the tailor ostracized from many a village. | He tried to make his break in the big cities, but sadly he just could not compete with the other tailors. | When a lord organized an army, %name% handled the clothes, giving the soldiers proper uniforms. | But a fierce competition between tailors led to a linen-wrapped deadman and %name% coincidentally leaving his shop behind. | Sadly, robbers ransacked his shop and, with the wars going on, it would be impossible to restock. | But when he sheared a sheep that did not belong to him, %name% was kicked out of town. | He once choked out a would-be thief with a cord of measuring wire. So he says, anyway. | But dressing unlikeable and unfriendly nobility eventually {bored him. | wore on him.} | Once tasked with making a tunic embroidered with epic feats, %name% wondered what the outside world was really like. | Designing a dress adorned with {epic quests | epic feats}, %name% wondered if maybe he should be the one they wove stories about.} Now the tailor looks for a new life, no matter where it takes him. {Maybe he can dress the unit well, or something. | He\'s particular and peculiar, peppering everyone with clothing criticisms. | He\'s no natural soldier, but he appraises a man\'s attire as if he\'s about to go to war with it. | The way he measures and calculates for dressing, it\'s too bad %name% wasn\'t a siege engineer. | While hardly a soldier, %name%\'s earnest love for tailoring is to be admired. | %name%\'s knowledge of various cloths is seriously impressive. | A bit on the nimby-pimby side, %name% has the footwork of a swordfighter, but the swordfighting of a soft breeze. | %name% would seem very out of place in a suit of armor, but boy is he going to need one. | As it turns out, %name% can in fact make a silk purse out of a sow\'s ear. | Don\'t let his vocation fool you, %name% is more deft with his hands than some {cardsharks | jugglers | pickpockets}. | Tailors don\'t seem fit for combat, but then again neither do most of the men you run across these days. | A tailor seems ill-fit for combat, yet for some reason you find the finest soldiers in the strangest of places. | With an eye {for calculations | for measuring}, %name% is a lot smarter than he lets on at first glance.}";
		}

	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-2,
				2
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				-5,
				0
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
				0,
				5
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "feathered_hat"]
		]))
	}

});

