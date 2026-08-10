this.legend_beggar_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.LegendCommanderBeggar);
		this.m.Name = "Framed Beggar";
		this.m.Icon = "ui/backgrounds/background_18.png";
		this.m.BackgroundDescription = "Beggars aren\'t the most determined persons, and living on the street tends to be detrimental to their health.";
		this.m.GoodEnding = "Having enough of all the fighting, %name% the once-beggar retired from the %companyname%. You know the %person% made a pretty crown in %their% time with the mercenary company, yet the other day you saw %them% out begging again. You asked if %they%\'d wasted all %their% money and %they% laughed. %They% said %they%\'d purchased land and was doing just fine. Then %they% held out %their% little tin and asked for a crown. You gave %them% two.";
		this.m.BadEnding = "The fighting life is a rough one, and %name% the once-beggar saw fit to retire from it before it became a deadly one. Unfortunately, %they% went back to beggaring. Word has it that a nobleman cleaned a city of riff-raff and sent them marching north despite it being winter. Cold and hungry, %name% died on the side of a road, a tin cup frozen to %their% finger.";
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
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
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
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery
		];

		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.Adrenaline,
				::Legends.Perk.NineLives,
				::Legends.Perk.Recover,
				::Legends.Perk.BagsAndBelts
			],
			[
				::Legends.Perk.Dodge,
				::Legends.Perk.HoldOut,
				::Legends.Perk.QuickHands
			],
			[
				::Legends.Perk.Anticipation,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.Taunt
			],
			[
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecThrowing,
			],
			[
				::Legends.Perk.LoneWolf,
				::Legends.Perk.Underdog
			],
			[
				::Legends.Perk.Nimble,
			],
			[
				::Legends.Perk.Fearsome
			],
			[],
			[],
			[],
			[]
		];
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.setCommanderGender();
		_gender ? this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale}) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
		if(_gender) {
			this.m.Name = "Framed Widow";
		}
	}

	function onBuildDescription()
	{
		return "{Having stolen gold from a dead noble, and being framed for the murder, this beggar is on the run!}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendCommanderBeggar);
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	function onAddEquipment()
	{
		this.World.Assets.addMoney(-208);
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
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps]
		]));

		local item = this.Const.World.Common.pickHelmet([
			[3, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.hood, 38]
		]);
		items.equip(item);

	}
});
