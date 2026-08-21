::mods_hookExactClass("skills/backgrounds/miner_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Miner);
		this.m.BackgroundDescription = "A miner will be used to physical labor, but breathing in the dusty air of the mines may have taken a toll on %their% health over the years.";
		this.m.GoodEnding = "%name% the miner never did return to the mines, thankfully. If there\'s one life that could be worse than that of fighting for a living, it very well may be digging into mountains for a living! Apparently, the miner built a home by the sea, spending the rest of %their% days peacefully fishing for dinner and enjoying sunrises or some such sappy shite.";
		this.m.BadEnding = "If there\'s one life that\'s more rough than that of being a sellsword, it is that of being a miner. Sadly, %name% returned to that life, going back into the mines to dig out metals and ores to fill some rich man\'s pockets. A recent earthquake collapsed many such mines. You\'re not sure if the ol\' %sibling% survived, but it\'s looking pretty grim.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard)
		];
		this.m.Titles = [
			"the Miner",
			"the Crawler",
			"Earthside"
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
	}

	o.getTooltip = function () {
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.onBuildDescription <- function ()	{
		return "{To support a fatherless family, %name% went into the mines at a very young age. | An orphan, the only work %name% could find was working the mines of the earth. | Mining is tough work, the sort of job %people% like %name% flock to. | Even though %their% father died in the mines, %name% felt compelled to work in them %themselves%, like most people do where %they% grew up. | %name% worked in the mines as a family tradition spanning many generations. | Whenever wars start up, miners like %name% are more needed than ever, lest an army wishes to go without steel to wield. | A hardhelm and a pickaxe, the tools %name% has been taking deep into the earth for years.} {But, as always, a mine doesn\'t last forever, and the miner barely escaped the last collapse. | Sadly, %they% proved to be the only survivor of a shaft collapse, and there\'s no way %they're% digging back in there by %themselves%. | After a tragic mine collapse, the sight of dozens of widows and widowers moved the %person% to think of a different field of work. | Surviving yet another collapse, the %person%\'s %partner% demanded %they% seek a new line of work no matter what it was. | Bending over and scuttling about in the dark gets old, though, and so the %person% sought a different vocation. | Working in environments far too dark, the %person% accidentally killed a coworker. The tragedy pushed %them% from the field. | After %their% own son lost %their% life in the mines, the %person% left the job forever. | But suffering from relentless coughs, the %person% felt maybe a career in fresh air would better serve %them%.} {%name% has the stocky frame of a miner. Unfortunately, %they% has the lungs of one, too. | %They're% tough alright, but %name%\'s wheezing sounds like rusted blades grinding together.  | You have to wonder if %name%\'s lungs have enough metal dust in them to fashion a blade or two. | %name%\'s breath could probably ink a chunk of coal. | %name% spent years earning keep for a company store. Now %they% wants to earn some real coin. | %name% looks forward to pocketing some of that gold %they% spent years plucking out of the earth. | Annoyingly, %name% points at half your gear - the metal stuff, mostly - and reminds everyone who\'s responsible for it being there. | %name% has almost catlike vision in the dark. %They% would have made for a good assassin if it weren\'t for %their% damned wheezing. | %name% has cheated death a few times, so why not try it a few times more as mercenary? | %name%\'s already had the earth itself out for %their% head so a few things above the soil don\'t scare %them% much. | If darkness truly is death\'s ambassador, %name%\'s already been talking to it for years. | Stupidly brave souls like %name% can definitely find a good register in an outfit such as this. | %name% proudly boasts that, once upon a time, %they% could play cards in the dark. You don\'t doubt it. | If %name% can swing a sword as well as a pickaxe, then all is well.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Miner);
	}

	o.onSetAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/weapons/pickaxe"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.mouth_piece]
		]));
	}

});
