this.beggar_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.beggar";
		this.m.Name = "Beggar";
		this.m.Icon = "ui/backgrounds/background_18.png";
		this.m.BackgroundDescription = "Beggars aren\'t the most determined persons, and living on the street tends to be detrimental to their health.";
		this.m.GoodEnding = "Having enough of all the fighting, %name% the once-beggar retired from the %companyname%. You know the man made a pretty crown in his time with the mercenary company, yet the other day you saw him out begging again. You asked if he\'d wasted all his money and he laughed. He said he\'d purchased land and was doing just fine. Then he held out his little tin and asked for a crown. You gave him two.";
		this.m.BadEnding = "The fighting life is a rough one, and %name% the once-beggar saw fit to retire from it before it became a deadly one. Unfortunately, he went back to beggaring. Word has it that a nobleman cleaned a city of riff-raff and sent them marching north despite it being winter. Cold and hungry, %name% died on the side of a road, a tin cup frozen to his finger.";
		this.m.HiringCost = 30;
		this.m.DailyCost = 3;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendNatural)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"the Dirty",
			"the Poor",
			"the Ragged",
			"the Sick",
			"the Liar",
			"the Idle",
			"the Sloth",
			"the Useless",
			"the Beggar",
			"the Weasel",
			"the Skunk",
			"the Sluggard",
			"the Homeless"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.StaffTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.CalmTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.FistsClassTree
			],
			Magic = []
		}
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Name = "Widow";
		this.m.Icon = "ui/backgrounds/background_widow.png";
		this.m.BackgroundDescription = "Widows who can\'t find another husband have few choices, mercenary work is a last resort of the hopeless.";	
		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "Having enough of all the fighting, %name% the once-beggar retired from the %companyname%. You know the woman made a pretty crown in her time with the mercenary company, yet the other day you saw her out begging again. You asked if she\'d wasted all his money and he laughed. He said she\'d purchased land and was doing just fine. Then she held out her little tin and asked for a crown. You gave her two.";
		this.m.BadEnding = "The fighting life is a rough one, and %name% the once-beggar saw fit to retire from it before it became a deadly one. Unfortunately, she went back to begging. Word has it that a nobleman cleaned a city of riff-raff and sent them marching north despite it being winter. Cold and hungry, %name% died on the side of a road, a tin cup frozen to her finger.";

	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]50% less likely[/color] to be targeted by an enemy."
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{After losing her husband to a fire | After her husband\'s gambling addiction got the better of him | Her husband was framed for a crime he didn\'t commit, and having to pay the constable everything to keep herself out of the dungeons | A refugee and widow after her village was burned to the ground | Banished from her home after a violent struggle with her husband | A woman with few talents and no husband | After being released alone from a lord\'s dungeon where she spent countless years chained to a wall | After giving all her worldly possessions to an obscure cult that took her husband and promised salvation of her eternal soul | Married to a very intelligent man until a brigand knocked him over the head}, {%name% found herself on the streets, | %name% was forced onto the streets,} {having to beg for bread | depending on the goodwill of others | being beaten and resigned to her fate | spending what little coin she had to drink the days away | digging into the trash of others and scurrying away from lawmen | avoiding ruffians and thugs while she begged for crowns}. {While she seems earnest in becoming a mercenary, there is little doubt that all his time on the street, and her former marriage, have robbed %name% of her best years. | Years have passed and took a toll on her health by now. | Once a woman like %name% has spent a few days on the streets, much less a few years, even the very dangerous job of being a sellsword seems like the greenest of pastures. | Only the gods know what %name% has done to survive, but she is a frail woman standing before you now. | At the sight of you she rises with open arms to embrace you, claiming to know you well from years past and many a shared adventure, although your name escapes her at the moment.}";
		}
		else
		{
			return "{After losing everything to a fire | After his gambling addiction got the better of him | Framed for a crime he didn\'t commit, and having to pay the constable everything to keep himself out of the dungeons | A refugee after his village was burned to the ground | Banished from his home after a violent struggle with his brother | A man with few talents and no ambition | After being released from a lord\'s dungeon where he spent countless years chained to a wall | After giving all his worldly possessions to an obscure cult promising salvation of his eternal soul | A very intelligent man until a brigand knocked him over the head}, {%name% found himself on the streets, | %name% was forced onto the streets,} {having to beg for bread | depending on the goodwill of others | being beaten and resigned to his fate | spending what little coin he had to drink the days away | digging into the trash of others and scurrying away from lawmen | avoiding ruffians and thugs while he begged for crowns}. {While he seems earnest in becoming a mercenary, there is little doubt that all his time on the street have robbed %name% of his best years. | Years have passed and took a toll on his health by now. | Once a man like %name% has spent a few days on the streets, much less a few years, even the very dangerous job of being a sellsword seems like the greenest of pastures. | Only the gods know what %name% has done to survive, but he is a frail man standing before you now. | At the sight of you he rises with open arms to embrace you, claiming to know you well from years past and many a shared adventure, although your name escapes him at the moment.}";
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-4,
				-2
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				-10,
				-10
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
				1,
				4
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
			[1, "leather_wraps"],
			[1, "legend_rabble_tunic"]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[3, ""],
			[1, "hood", 28]
		])
		items.equip(item);
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.TargetAttractionMult *= 0.5;
	}

});

