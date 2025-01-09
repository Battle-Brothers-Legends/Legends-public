this.legend_nightwatch_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_nightwatch";
		this.m.Name = "Night Watch";
		this.m.Icon = "ui/backgrounds/background_nightwatch.png";
		this.m.BackgroundDescription = "The night watch are an unlucky few chosen to break up fights and keep towns lawful at the worst time of the day.";
		this.m.GoodEnding = "%name% found themselves quite comfortable within the darkness, mingling with the company and learning many valuable skills. After they retired from service, they joined with a group of beast hunters that sought to hunt down the horrors of the night. Last you heard, they have been doing quite well for themselves. Able to spot and expell an alp from a village without breaking a sweat.";
		this.m.BadEnding = "After many sleepless nights, remembering the horrors they faced within the company, %Name% returned to their village and became a night watchman once more. Unfortunately, a few days later they were found dead at their post. Their eyes shut, yet face contorted into a look of horror. Not a single villager heard any commotion during the night, but one reported seeing a pale figure stalking off in the moonlight.";
		this.m.HiringCost = 120;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.asthmatic",
			"trait.legend_unpredictable"
		];

		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.015,//plains
				0.0, //swamp
				0.01, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.015, //farmland
				0.0, // snow
				0.01, // badlands
				0.01, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.PolearmTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [
				this.Const.Perks.AlpTree
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
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 1;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% found themselves quite comfortable within the darkness, mingling with the company and learning many valuable skills. After they retired from service, they joined with a group of beast hunters that sought to hunt down the horrors of the night. Last you heard, they have been doing quite well for themselves. Able to spot and expell an alp from a village without breaking a sweat.";
		this.m.BadEnding = "After many sleepless nights, remembering the horrors they faced within the company, %Name% returned to their village and became a night watchman once more. Unfortunately, a few days later they were found dead at their post. Their eyes shut, yet face contorted into a look of horror. Not a single villager heard any commotion during the night, but one reported seeing a pale figure stalking off in the moonlight.";

	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{Never one to fear the night, %name%'s path in life lead them to the mantle of watchman. | With pale skin and bloodshot eyes, %name% carries the 'look' of a night watchman. | %name% carries an old lantern attached to a stick over their shoulder. An eerie smile on their face as they stare you down. | With their bellowing voice and keen eyes, it's no wonder %name% was selected as %townname%\'s watchwoman. | %name% was assigned to watchman duty as punishment for falling asleep during the day. Cursed to a dark, and lonely service in the local militia. | %name% was forced into the duty of night watchman as a punishment after being accused for a string of night robberies within %townname%.} {Living a quiet life in the night became quite a lonely and soul crushing experience for %name%. They sought something more, hanging up their lantern and looking to join a band of wandering mercenaries. | After falling asleep at an inopportune time, which ended up with two children being kidnapped right out of their homes. %name% sought to escape persecution for the failure in any way they could. | After a string of haunting visions in the night, %name% found themselves unable to cope with such. Resigning immediately and looking for a new avenue of employment.} {Night watchman has molded them into a pale and wiry figure. But still a somewhat capable fighter. | With all the horrors that stalk the night, %name% seems like a fitting member to keep around. | %name% looks like they haven't slept in days. But they assure you they get plenty of rest, and their odd sleep patterns will not be an issue. | %name%'s keen eyes will be /very/ useful in the coming days. Having someone to watch you while you sleep is a blessing considering what roams in the dark.}";
		}
		else
		{
			return "{Never one to fear the night, %name%'s path in life lead them to the mantle of watchman. | With pale skin and bloodshot eyes, %name% carries the 'look' of a night watchman. | %name% carries an old lantern attached to a stick over their shoulder. An eerie smile on their face as they stare you down. | With their bellowing voice and keen eyes, it's no wonder %name% was selected as %townname%\'s watchman. | %name% was assigned to watchman duty as punishment for falling asleep during the day. Cursed to a dark, and lonely service in the local militia. | %name% was forced into the duty of night watchman as a punishment after being accused for a string of night robberies within %townname%.} {Living a quiet life in the night became quite a lonely and soul crushing experience for %name%. They sought something more, hanging up their lantern and looking to join a band of wandering mercenaries. | After falling asleep at an inopportune time, which ended up with two children being kidnapped right out of their homes. %name% sought to escape persecution for the failure in any way they could. | After a string of haunting visions in the night, %name% found themselves unable to cope with such. Resigning immediately and looking for a new avenue of employment.} {Night watchman has molded them into a pale and wiry figure. But still a somewhat capable fighter. | With all the horrors that stalk the night, %name% seems like a fitting member to keep around. | %name% looks like they haven't slept in days. But they assure you they get plenty of rest, and their odd sleep patterns will not be an issue. | %name%'s keen eyes will be /very/ useful in the coming days. Having someone to watch you while you sleep is a blessing considering what roams in the dark.}";
		}

	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				4,
				8
			],
			Bravery = [
				6,
				8
			],
			Stamina = [
				8,
				12
			],
			MeleeSkill = [
				0,
				4
			],
			RangedSkill = [
				0,
				8
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

	function onAdded() // always has night owl
	{
		this.character_background.onAdded();
		::Legends.Traits.grant(this, ::Legends.Trait.NightOwl);
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
		items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 1)
		{
		items.equip(this.new(""));
		}
		else if (r == 2)
		{
		items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 3)
		{
		items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 4)
		{
		items.equip(this.new("scripts/items/weapons/legend_sling"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "sackcloth"],
			[1, "linen_tunic", this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"],
			[2, "aketon_cap"]
		]));
	}
});

