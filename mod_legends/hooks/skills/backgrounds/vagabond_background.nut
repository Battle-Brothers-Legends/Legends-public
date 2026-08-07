::mods_hookExactClass("skills/backgrounds/vagabond_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.Vagabond);
		this.m.Name = "Vagabond";
		this.m.Icon = "ui/backgrounds/background_32.png";
		this.m.BackgroundDescription = "Vagabonds are used to long travels, but don\'t excel in anything in particular.";
		this.m.GoodEnding = "Some %people% were just intended to wander. While %their% time with the %companyname% went well, %name% the vagabond eventually departed with the company and set off on the roads once more. You\'ve no idea where %they're% gone, you just know all %they're% interested in is going.";
		this.m.BadEnding = "As the company fell apart, it\'s little surprise that a vagabond like %name% chose to leave it behind and return to the roads. Unfortunately, with the world in such a dire state, it did not take long for %them% to find trouble. %Their% body was found hanging outside a small farming village. A sign nailed to his chest read: \'No Free Rangers\'.";
		this.m.HiringCost = 70;
		this.m.DailyCost = 9;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic)
		];
		this.m.Titles = [
			"the Vagabond",
			"the Wanderer",
			"Threefeet",
			"Bindlestiff",
			"Tatterdemalion",
			"the Homeless",
			"the Restless",
			"the Traveller",
			"the Raven"
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin; //Bottom half of neutral for slightly neutral evil
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.IndestructibleTree,
				::Const.Perks.OrganisedTree,
				::Const.Perks.FastTree,
				::Const.Perks.FitTree
			],
			Enemy = [],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Faces = ::Const.Faces.AllWhiteMale, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.onBuildDescription <- function () {
		return "{Pushed out of his town by war, %name% wanders the world as a vagabond. | Lazy and unmotivated, %name% one day put all three of his belongings into a knapsack and hit the road. | Never a strong learner in school, %name% dropped out to wander the earth. | %name% did not have the business acumen to protect %their% inheritance from debtors, lawmen, and other maleficent men. Now %they% wanders with the last of %their% crowns jangling in a pocket. | Life on the road has taught %name% to be a jack of all trades, and a master of none - except walking, of course. | Not quite one for the city, and not quite one for the wild, %name% spends %their% purposeless days traveling between both. | During %their% drinking days, %name% managed to gamble away a small fortune. Now homeless, %they% simply wanders. | When %their% %partner% was murdered while %they% was away, %name% refused to sleep in the house. The %person% walks the earth, trying to forget the memory. | %Their% son murdered five others. In shame, %name% abandoned %their% hometown to walk the earth and forget %their% failures as a father.} {But when a gang of thieves took all he had - including %their% shoes - %they% knew %they% needed yet another change. | But when %they% came to a literal fork in the road, the %person% realized %they% hadn\'t eaten in some time. %Their% stomach demanded a change in scenery - and diet. | Sadly, the world is not a pleasant place for those who nobody would miss. %They% was harassed and bullied every day. | After one particularly harsh day trudging through mud, %they% realized there was no life to be had in walking around. | Strangely, one day %they% came across his long-forgotten brother %they%-never-had who said there was plenty of walking to be done for a mercenary outfit - and they\'d pay %them% to do it, too! | Like any good, impulsive %person%, %they% flipped a coin on whether or not to try %their% hand at mercenary work.} {%They're% not particularly good at anything, but %name% has seen and done a lot, and that\'s worth at least something. | Mucking about this violent land and surviving with all %their% limbs is a lot more than some folks can say. | A mercenary band would be but another adventure for a vagabond like %name%. One hopes %they% survives to write about it. | Through %their% travels %their% only weapon was a walking stick. Let\'s see how %they% does with something a smidge sharper. | A thief, a scoundrel, a baker, a tailor, %name%\'s done it all. Too bad %they% was never good at any of those things. Maybe it\'ll be different this time. | The world has been harsh to %name% for many years now. That isn\'t going to change, but at least %they% will be with %sibling%s now.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Vagabond);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_saw"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}

		r = this.Math.rand(0, 3);
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.leather_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.hood],
			[1, ::Legends.Helmet.Standard.straw_hat]
		]));
	}
});

