::mods_hookExactClass("skills/backgrounds/gravedigger_background", function (o) {
	o.create = function () {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Gravedigger);
		this.m.BackgroundDescription = "Gravediggers are used to physical labor and handling the dead.";
		this.m.GoodEnding = "With the great successes of the %companyname%, %name% the gravedigger got continued practice in %their% trade. As the crowns began to stack, %they% eventually left the company and returned to the graveyards. Last you heard, %they% had retired to digging holes again and was happily raising a family of sextons.";
		this.m.BadEnding = "The way you heard things, %name% the gravedigger was one of the last men to leave the %companyname%. With hardly a crown to %their% name, %they% slipped hard into drinking and last you heard %their% body was found in a muddied gully.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Optimist)
		];
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
	}

	o.getTooltip = function () {
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale});
	}

	o.onBuildDescription <- function () {
		return "{%name% got %their% start as a gravedigger by burying %their% baby brother. | Putting a sword to %their% drunken father\'s neck, %name%\'s start in gravedigging was a nasty one. First %they% buried the crime, and then %they% buried the lawmen who came around asking questions. | After disease swept through %townname%, %name% was the last %person% standing. %They% had to abandon %their% trade to take up the only thing left: gravedigging.} There\'s a look in the dead, they say. But there\'s also a look in those who have seen the dead. %name% has now spent a life and a half {staring at corpses | putting bodies in the ground | digging graves, big ones and small}. To the gravedigger, {death is now but a science | the dead have been better company than the living | earning gold for burying the dead is no new task}. {Employed by a wagon-train, %name% traveled the land and dug it up, too. But one day %their% burial was suddenly undone. Not by the buzzards or rats, but by the dead itself. Seeing such a sight, and having to bury the same man twice, no doubt compels a swift career change. | Every gravedigger is eyed with suspicion. It wasn\'t long until %their% patrons became accusers and the notion of a horrific crime of undead passion drove %them% from %their% work. The claims are absurd, but you can\'t get a read on %their% pale face. It\'s like playing cards with the moon. | By now, the %person% looks as if %they% could use a change of scenery. Just don\'t ask %them% to bury the casualties.}";
	}

	o.onChangeAttributes = function () {
		return ::Legends.Backgrounds.getStats(::Legends.Background.Gravedigger);
	}

	o.onAddEquipment = function () {
		local items = this.getContainer().getActor().getItems();
		local r = ::Math.rand(0, 2);

		if (r == 0) {
			items.equip(this.new("scripts/items/weapons/legend_hoe"));
		} else if (r == 1) {
			items.equip(this.new("scripts/items/weapons/legend_shovel"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.leather_tunic]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.None]
		]));
	}
});
