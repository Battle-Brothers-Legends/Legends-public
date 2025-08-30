::mods_hookExactClass("skills/backgrounds/butcher_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.butcher";
		this.m.Name = "Butcher";
		this.m.Icon = "ui/backgrounds/background_43.png";
		this.m.BackgroundDescription = "Butchers are used to bloodshed.";
		this.m.GoodEnding = "Mercenary work is a bloody business, which is probably why a butcher like %name% felt right at home in it. While an outstanding fighter, you hear that he still has problems with the war dogs in the party and has been repeatedly caught trying to slaughter them. Eventually, if not desperately, the company gave the man an adorable puppy to raise as his own. From what you know of, the little runt\'s glowy doe eyes converted the dog hater into a lover. Now he goes into an insatiable bloodlust whenever a wardog is harmed and his little mongrel grew up to be the fiercest beast in the company!";
		this.m.BadEnding = "%name% the butcher eventually left the declining company. He joined up with another outfit, but was caught slaughtering one of their war dogs. Apparently, he had been feeding the mercenaries dogmeat from all their mongrels that had gone \'missing\'. They did not take this news kindly, stripped the butcher, and fed him to the beasts.";
		this.m.HiringCost = 80;
		this.m.DailyCost = 9;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Optimist)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"the Butcher",
			"the Cleaver",
			"the Red",
			"Redmeat",
			"Bloodeye"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Bodies = this.Const.Bodies.Thick;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.LargeTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ButcherClassTree
			],
			Profession = [
				this.Const.Perks.ChefProfessionTree
			],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Fishmonger";
		this.m.Icon = "ui/backgrounds/fishwife.png";
		this.m.BackgroundDescription = "Fishmongers are used to spilled guts.";
		this.m.GoodEnding = "Mercenary work is a bloody business, which is probably why a fishmonger like %name% felt right at home in it. While an outstanding fighter, you hear that she still has problems with the war dogs in the party and has been repeatedly caught trying to slaughter them. Eventually, if not desperately, the company gave the woman an adorable puppy to raise as her own. From what you know of, the little runt\'s glowy doe eyes converted the dog hater into a lover. Now she goes into an insatiable bloodlust whenever a wardog is harmed and her little mongrel grew up to be the fiercest beast in the company!";
		this.m.BadEnding = "%name% the fishmonger eventually left the declining company. She joined up with another outfit, but was caught slaughtering one of their war dogs. Apparently, she had been feeding the mercenaries dogmeat from all their mongrels that had gone \'missing\'. They did not take this news kindly, stripped the butcher, and fed her to the beasts.";
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);

	}

	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{After her father\'s death, %name% took over the family butcher shop in %randomtown%. | Growing up poor, %name% quickly learned to kill and strip animals, eventually founding a butcher\'s shop. | With droughts ruining the farmlands, %name%\'s butcher shop took off in %randomtown%. | Always a strange girl, %name% took to butchering not only for profit, but for pleasure. | Grinning ear to ear, %name% never looked so happy as when her shop opened and she got her first order of live pigs in stock. | As a butcher, %name% has spent years squishing guts out of dead rabbits and lopping heads off sometimes-dead fish.} {But rumors of animal torture eventually drove the cleaver-swinger from her business. | Given the terrible rumors of dark arts already going around, it wasn\'t long until people began questioning the source of her meats and drove her out of business. | But killing animals, for one reason or another, didn\'t quite excite her anymore. She sought something new. | After a human finger was found in one of her deer wrappings, the woman was driven from his business. | Some say she most enjoyed butchering for soldiers during the orc invasions and wishes to return to that experience once more. | Unfortunately, the war drove through her shop, leaving behind a number of carcasses she wouldn\'t dare butcher. | Living in a city under siege, she provided meat for the hungry. When it was found out where that meat came from, she was handed over to the besiegers who, unwittingly, let her live. | The woman\'s friendliness with poachers caught up with her, ultimately leaving her on the road with a retinue of the local lords\'s men on her tail. | Butchering a tiny fish became a scandal when it turned out to be a nobleman\'s pet. She fled to save her own scales.} {Something about blood and guts sits just right with %name%. In that case, welcome to the battlefield. | %name% looks at everything as a potential meat sale with breathing, moving packaging. | Many are disturbed by %name%\'s mere presence and all-too-wide eyes. | %name% is known to bite her tongue and savor the blood. | %name%\'s ears perk whenever a pig squeals. The same thing happens when a man screams. Interesting. | %name%\'s a butcher, but apparently has little interest in actually feeding the outfit.}";
		}
		else
		{
			return "{After his father\'s death, %name% took over the family butcher shop in %randomtown%. | Growing up poor, %name% quickly learned to kill and strip animals, eventually founding a butcher\'s shop. | With droughts ruining the farmlands, %name%\'s butcher shop took off in %randomtown%. | Always a strange boy, %name% took to butchering not only for profit, but for pleasure. | Grinning ear to ear, %name% never looked so happy as when his shop opened and he got his first order of live pigs in stock. | As a butcher, %name% has spent years squishing guts out of dead rabbits and lopping heads off sometimes-dead fish.} {But rumors of animal torture eventually drove the cleaver-swinger from his business. | Given the terrible rumors of dark arts already going around, it wasn\'t long until people began questioning the source of his meats and drove him out of business. | But killing animals, for one reason or another, didn\'t quite excite him anymore. He sought something new. | After a human finger was found in one of his deer wrappings, the man was driven from his business. | Some say he most enjoyed butchering for soldiers during the orc invasions and wishes to return to that experience once more. | Unfortunately, the war drove through his shop, leaving behind a number of carcasses he wouldn\'t dare butcher. | Living in a city under siege, he provided meat for the hungry. When it was found out where that meat came from, he was handed over to the besiegers who, unwittingly, let him live. | The man\'s friendliness with poachers caught up with him, ultimately leaving him on the road with a retinue of the local lords\'s men on his tail. | Butchering a tiny pig became a scandal when it turned out to be a nobleman\'s pet. He fled to save his own bacon.} {Something about blood and guts sits just right with %name%. In that case, welcome to the battlefield. | %name% looks at everything as a potential meat sale with breathing, moving packaging. | Many are disturbed by %name%\'s mere presence and all-too-wide eyes. | %name% is known to bite his tongue and savor the blood. | %name%\'s ears perk whenever a pig squeals. The same thing happens when a man screams. Interesting. | %name%\'s a butcher, but apparently has little interest in actually feeding the outfit.}";
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				4
			],
			Bravery = [
				3,
				5
			],
			Stamina = [
				0,
				4
			],
			MeleeSkill = [
				4,
				7
			],
			RangedSkill = [
				-3,
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
				0
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r <= 1)
		{
			items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.butcher_apron]
		]));
	}
});
