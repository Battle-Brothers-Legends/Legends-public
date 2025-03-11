this.cripple_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.cripple";
		this.m.Name = "Cripple";
		this.m.Icon = "ui/backgrounds/background_51.png";
		this.m.BackgroundDescription = "The only thing swift about a cripple is their expected demise in a real battle.";
		this.m.GoodEnding = "It\'s shocking that a person of %name%\'s stature survived at all, but the cripple did retire from the %companyname% with a sizeable stack of crowns. He runs an orphanage these days, spending his crowns to help the world\'s broken and abandoned children. That, or it\'s just a front for cheap labor. Can\'t be too sure these days.";
		this.m.BadEnding = "When you left the %companyname%, there was one thing you were almost certain of: that damned cripple, %name%, wouldn\'t last long. Despite all odds, he did survive. Long enough in fact to retire himself, albeit departing with about as many crowns as he had when he joined up. You\'ve no idea what became of him, but surely he\'s dead by now. Surely, right?";
		this.m.HiringCost = 30;
		this.m.DailyCost = 2;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Lucky),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Initiative
		];
		this.m.Titles = [
			"the Cripple",
			"the Maimed",
			"the Broken",
			"the Grotesque"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMin;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.FistsTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [
				this.Const.Perks.NoblesTree
			],
			Class = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.GoodEnding = "It\'s shocking that a woman of %name%\'s stature survived at all, but the cripple did retire from the %companyname% with a sizeable stack of crowns. She runs an orphanage these days, spending her crowns to help the world\'s broken and abandoned children. That, or it\'s just a front for cheap labor. Can\'t be too sure these days.";
		this.m.BadEnding = "When you left the %companyname%, there was one thing you were almost certain of: that damned cripple, %name%, wouldn\'t last long. Despite all odds, she did survive. Long enough in fact to retire herself, albeit departing with about as many crowns as she had when she joined up. You\'ve no idea what became of her, but surely she\'s dead by now. Surely, right?";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);

	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
		return "%name% {hobbles toward you like a mangy dog | greets you with a hand missing numerous fingers | smiles at you with a toothless grin | carries the slouching posture of a woman with a broken back | wobbles on two very stiff, possibly even wooden legs | uses a cane to walk toward you | crawls toward you at first, but then rises to her feet with all the grace of a drunk on church steps | has bones that creak and croak with every step | carries an arm in a sling, and has a cane standing in support for one of her legs | has a smashed nose and two blackened eyes | looks like someone tried to scalp and burn her alive | has flesh that smells partly cooked, her eyes wincing with every step she takes toward you | is missing two ears, though the holes she still hears | reeks of shit and urine | is missing one eye, and the other wanders severely | has two lazy eyes and a crooked, gap-filled smile}. She explains that {she was once a mason, but that she was attacked by a madman for trying to replicate his work | she once donned the atire of a belly dancer, but that cruel fate has taken all of that from her | once upon a time she was a Vizier\'s wife, but her poor vocabulary suggests this may be a lie | she was a peddler once, but the sale of a lobo-rail ended with her at the mercy of an angry town mob | she dabbled in cultism, but when she bailed they punished her for it | she used to wash and cook for decadent traders, but a beatdown by nomad raiders left her crippled | she used to serve food in the arena, but a bad match ended with her horribly crippled | she used to rob graves, but when she got caught a parishioner broke more of her bones than she knew a skeleton even had | she dabbled in {the arcane arts | necromancy} but, made obvious by her near-deathly state, that experiment was shortlived | she was once a successful gambler, but as it turns out not paying back your debts is bad for business - and your bones | she used to catch rats for a living, but apparently a giant rat paid her a vengeful visit in the night | she once served a vizier of %randomcitystate%, but after dropping a plate of food she was sent to the dungeons where she was promptly forgotten for years | she once killed a man, sure, but that she deserved a better fate than the irreversible torture she received as punishment | she used to hunt witches, but a cruel mistress tricked her into drinking a concoction which crippled her very bones | she once deserted an a master and, obviously, got caught | she used to dance for the rich until she accidentally fell down some steps in the middle of a performance. The steps proved rather edgy against her bones, it seems | she was born with a horrific deformity | her father brutally attacked her for not finding a husband early enough | her mother scarred her with endless torture | her siblings tortured hr all her life}. {The woman looks so weak you can almost see her mortal coil flapping in the wind. | Hiring her would almost certainly be the woman\'s doom. How merciful! | You don\'t want to be seen as hiring just anybody, but if this woman is a nobody, does that still count as \'anybody\'? | You\'ve seen dead people who look better than this woman. | This woman is wolf-lunch on two legs. | The good news is that if she comes back from the dead she shouldn\'t be too hard to put down a second time. | Dreams and inanimate objects are more threatening than this poor wench. | To be honest, you\'d rather hire a child, but apparently people look down on that so here we are instead. | And you thought %randombrother% smelled bad. | Hiring a woman such as this would send anyone\'s moral compass spinning. | Oh c\'mon, look at her! Are the %companyname% really that in need of warm bodies? | Hiring this woman just wouldn\'t be right. Whelp, here goes. | A pair of crutches has more value than this poor woman. | This woman is in such a sorry state she can play dead standing up.}";
		}
		else
		{
		return "%name% {hobbles toward you like a mangy dog | greets you with a hand missing numerous fingers | smiles at you with a toothless grin | carries the slouching posture of a man with a broken back | wobbles on two very stiff, possibly even wooden legs | uses a cane to walk toward you | crawls toward you at first, but then rises to his feet with all the grace of a drunk on church steps | has bones that creak and croak with every step | carries an arm in a sling, and has a cane standing in support for one of his legs | has a smashed nose and two blackened eyes | looks like someone tried to scalp and burn him alive | has flesh that smells partly cooked, his eyes wincing with every step he takes toward you | is missing two ears, though the holes he still hears | reeks of shit and urine | is missing one eye, and the other wanders severely | has two lazy eyes and a crooked, gap-filled smile}. He explains that {he was once a mason, but that he was attacked by a madman for trying to replicate his work | he once donned armor as a knight, but that cruel fate has taken all of that from him | once upon a time he was a Vizier, but his poor vocabulary suggests this may be a lie | he was a peddler once, but the sale of a lobo-rail ended with him at the mercy of an angry town mob | he dabbled in cultism, but when he bailed they punished him for it | he used to brawl for decadent traders, but a beatdown by other fighters left him crippled | he used to fight in the arena, but a bad match ended with him horribly crippled | he used to rob graves, but when he got caught a parishioner broke more of his bones than he knew a skeleton even had | he dabbled in {the arcane arts | necromancy} but, made obvious by his near-deathly state, that experiment was shortlived | he was once a successful gambler, but as it turns out not paying back your debts is bad for business - and your bones | he used to catch rats for a living, but apparently a giant rat paid him a vengeful visit in the night | he once served a vizier of %randomcitystate%, but after dropping a plate of food he was sent to the dungeons where he was promptly forgotten for years | he once killed a man, sure, but that he deserved a better fate than the irreversible torture he received as punishment | he used to hunt witches, but a cruel mistress tricked him into drinking a concoction which crippled his very bones | he once deserted an army and, obviously, got caught | he used to juggle for the rich until he accidentally fell down some steps in the middle of a stunt. The steps proved rather edgy against his bones, it seems | he was born with a horrific deformity | his father brutally attacked him for not living up to his image | his mother scarred him with endless torture | his siblings tortured him all his life}. {The man looks so weak you can almost see his mortal coil flapping in the wind. | Hiring him would almost certainly be the man\'s doom. How merciful! | You don\'t want to be seen as hiring just anybody, but if this guy is a nobody, does that still count as \'anybody\'? | You\'ve seen dead people who look better than this man. | This guy is wolf-lunch on two legs. | The good news is that if he comes back from the dead he shouldn\'t be too hard to put down a second time. | Dreams and inanimate objects are more threatening than this poor git. | To be honest, you\'d rather hire a child, but apparently people look down on that so here we are instead. | And you thought %randombrother% smelled bad. | Hiring a man such as this would send anyone\'s moral compass spinning. | Oh c\'mon, look at him! Are the %companyname% really that in need of warm bodies? | Hiring this man just wouldn\'t be right. Whelp, here goes. | A pair of crutches has more value than this poor man. | This man is in such a sorry state he can play dead standing up.}";
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-7
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
				-5,
				0
			],
			RangedSkill = [
				-5,
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
				-15,
				-10
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "leather_wraps"]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, "hood", 38],
			[3, ""]
		]);
		items.equip(helm);
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.IsContentWithBeingInReserve = true;
	}

});

