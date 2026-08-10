this.legend_nightwatch_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.LegendNightwatch);
		this.m.Name = "Night Watch";
		this.m.Icon = "ui/backgrounds/background_nightwatch.png";
		this.m.BackgroundDescription = "The night watch are an unlucky few chosen to break up fights and keep towns lawful at the worst time of the day.";
		this.m.GoodEnding = "%name% found themselves quite comfortable within the darkness, mingling with the company and learning many valuable skills. After %they% retired from service, %they% joined with a group of beast hunters that sought to hunt down the horrors of the night. Last you heard, %they% have been doing quite well for themselves. Able to spot and expel an alp from a village without breaking a sweat.";
		this.m.BadEnding = "After many sleepless nights, remembering the horrors %they% faced within the company, %Name% returned to %their% village and became a night watchman once more. Unfortunately, a few days later %they% were found dead at their post. %Their% eyes shut, yet face contorted into a look of horror. Not a single villager heard any commotion during the night, but one reported seeing a pale figure stalking off in the moonlight.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable)
		];
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.CrossbowTree,
				::Const.Perks.SlingTree
			],
			Defense = [
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.FitTree,
				::Const.Perks.LargeTree,
				::Const.Perks.IndestructibleTree,
				::Const.Perks.SturdyTree
			],
			Enemy = [
				::Const.Perks.OccultTree
			],
			Profession = [],
			Class = [],
			Magic = []
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Muscular, Hairs = ::Const.Hair.CommonMale});
	}

	function onBuildDescription() {
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
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendNightwatch);
	}

	function onAdded() // always has night owl
	{
		if (this.m.IsNew)
			::Legends.Traits.grant(this, ::Legends.Trait.NightOwl);
		this.character_background.onAdded();
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
			items.equip(this.new("scripts/items/weapons/legend_dilapidated_sling"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.linen_tunic, this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood],
			[2, ::Legends.Helmet.Standard.aketon_cap]
		]));
	}
});

