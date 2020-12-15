this.apprentice_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.apprentice";
		this.m.Name = "Apprentice";
		this.m.Icon = "ui/backgrounds/background_40.png";
		this.m.BackgroundDescription = "Apprentices tend to be eager for knowledge and learn faster than others.";
		this.m.GoodEnding = "Perhaps one of the sharpest men you\'ve ever met, %name% the apprentice was the quickest learner in the %companyname%. With plenty of crowns stored, he retired from fighting to take his talents to the business world. Last you heard he was doing very well for himself across multiple trades. If you ever have a child, this is the man you\'ll send them to for apprenticeship.";
		this.m.BadEnding = "%name% the apprentice was, by far, the quickest learner in the %companyname%. Little surprise then that he was also one of the quickest to recognize its inevitable downfall and leave while he still could. Had he been born in a different time he would have gone on to do great things. Instead, many wars, invasions, and plagues spreading across the land ultimately ensured %name% and many other talented men went to total waste.";
		this.m.HiringCost = 90;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.dumb",
			"trait.clumsy",
			"trait.asthmatic",
			"trait.athletic",
			"trait.brute",
			"trait.bloodthirsty",
			"trait.aggressive"
		];
		this.m.Titles = [
			"the Learner",
			"Quickmind",
			"the Apprentice",
			"the Understudy",
			"Goodhand",
			"the Student",
			"the Young",
			"the Kid",
			"the Bright"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;

		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.IsCrusaderRecruitBackground = true;
		this.m.IsRangerRecruitBackground = true;
		this.m.IsEducatedBackground = true;
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[0];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.AxeTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FastTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		local r = _gender;
		if (_gender == -1)
		{
			r = 0;
			if (this.World.LegendsMod.Configs().LegendGenderEnabled())
			{
				r = this.Math.rand(0, 1);
			}
		}

		if (r == 0)
		{
			return;
		}

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.m.IsFemaleBackground = true;
		this.m.GoodEnding = "Perhaps one of the sharpest women you\'ve ever met, %name% the apprentice was the quickest learner in the %companyname%. With plenty of crowns stored, she retired from fighting to take her talents to the business world. Last you heard she was doing very well for herself across multiple trades. If you ever have a child, this is the woman you\'ll send them to for apprenticeship.";
		this.m.BadEnding = "%name% the apprentice was, by far, the quickest learner in the %companyname%. Little surprise then that she was also one of the quickest to recognize its inevitable downfall and leave while she still could. Had she been born in a different time she would have gone on to do great things. Instead, many wars, invasions, and plagues spreading across the land ultimately ensured %name% and many other talented women went to total waste.";

	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Experience Gain"
			}
		];
	}

	function onBuildDescription()
	{
		if (this.m.IsFemaleBackground == true)
		{
			return "{One enters the world always looking to be the best they can be, | Mastery of an art is prestigious, | Everybody looks up to the best,} {but no one gets there in an instant. | so what better way to be the best than to learn underneath one? | and it\'s no secret most look toward the masters for help.} {%name% thought the same, taking the role of an apprentice in %townname%. | Believing this to be true, %name% took up an apprenticeship in %townname%. | When %randomtown%\'s college asked for apprentices, %name% was the first to sign up. | Urged by her parents to better her craft, %name% looked to start her career as an apprentice. | Not to be outdone by her overachieving brother, %name% began looking for an apprenticeship.} {Unfortunately, her master was poorly chosen: an insane carpenter with a penchant for chopping the neckline instead of the treeline. Fleeing the impending doom by association, %name% has ended up in the company of sellswords. | Learning all she could, %name% built the greatest work of art possibly ever seen in the field of underwater basket-weaving. Her master, though, was a jealous one. Not to be outdone by a pupil, she burned the project to ash and eye-watering fumes. It was clear to %name%: she could learn fast, but perhaps there were better masters to study beneath. | She had soaked up all there was to learn: masonry, carpentry, blacksmithing, lovemaking. Now she turns her eyes on the martial arts. While she isn\'t exactly a warrior yet, %name% is a fast learner.}";
		}
		else
		{
			return "{One enters the world always looking to be the best they can be, | Mastery of an art is prestigious, | Everybody looks up to the best,} {but no one gets there in an instant. | so what better way to be the best than to learn underneath one? | and it\'s no secret most look toward the masters for help.} {%name% thought the same, taking the role of an apprentice in %townname%. | Believing this to be true, %name% took up an apprenticeship in %townname%. | When %randomtown%\'s college asked for apprentices, %name% was the first to sign up. | Urged by his parents to better his craft, %name% looked to start his career as an apprentice. | Not to be outdone by his overachieving brother, %name% began looking for an apprenticeship.} {Unfortunately, his master was poorly chosen: an insane carpenter with a penchant for chopping the neckline instead of the treeline. Fleeing the impending doom by association, %name% has ended up in the company of sellswords. | Learning all he could, %name% built the greatest work of art possibly ever seen in the field of underwater basket-weaving. His master, though, was a jealous one. Not to be outdone by a pupil, he burned the project to ash and eye-watering fumes. It was clear to %name%: he could learn fast, but perhaps there were better masters to study beneath. | He had soaked up all there was to learn: masonry, carpentry, blacksmithing, lovemaking. Now he turns his eyes on the martial arts. While he isn\'t exactly a warrior yet, %name% is a fast learner.}";
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
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
				0
			]
		};
		return c;
	}


	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "leather_tunic"],
			[1, "linen_tunic"],
			[1, "apron"]
		]))
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.1;
	}

});

