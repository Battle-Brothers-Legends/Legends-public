::mods_hookExactClass("skills/backgrounds/fisherman_background", function(o)
{
	o.create = function () {
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.Fisherman);
		this.m.Name = "Fisher";
		this.m.Icon = "ui/backgrounds/background_15.png";
		this.m.BackgroundDescription = "Fishers are used to physical labor.";
		this.m.GoodEnding = "%name% retired from fighting and returned to %their% fishing ventures. A huge storm ran up the shores, destroying every skiff and drifter - except that wily fisher\'s! The only boat afloat, %name%\'s business boomed. %They% lives a comfortable life waking up to a nice beachfront view every morning.";
		this.m.BadEnding = "With the fighting career going so poorly, %name% decided to retire from the field and return to fishing. %They% went missing at sea after an enormous storm wrecked the shorelines.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fat)
		];
		this.m.Titles = [
			"the Angler",
			"the Fisher",
			"the Net Caster"
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.SpearTree,
				::Const.Perks.DaggerTree
			],
			Defense = [
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.FitTree,
				::Const.Perks.LargeTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.FastTree
			],
			Enemy = [
				::Const.Perks.BeastTree
			],
			Class = [
				::Const.Perks.BeastClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale});
	}

	o.onBuildDescription <- function () {
		return "{%name% loved the sea and the serenity of fishing alone on the water | Ironically, %name% always hated the water, but became a fisher after %their% father and %their% father\'s father | %name% was a strong and able fisher | %name% was content with being a fisher | %name% always had a lucky hand in finding the best fishing grounds and catching the fattest fish}. As long as there was no storm, %they% was out there, fishing, day in and out. {Sadly, %their% fishing cabin burned to the ground while %they% was out at sea. | But disaster struck as %they% lost %their% best friend at sea when a storm suddenly came up, leaving %them% with a badly damaged boat and no one to sail out with. | But disaster struck when %their% %partner% died during in an accident, shattering all what %they% held dear. | After being unable pay %their% debts for some time, however, %their% boat was taken from %them% by a merciless loan shark. | It was after %they% strangled %their% %partner% in a fit of rage that %they% lost all interest in the fishing trade. | Much to %their% dismay, for almost a whole summer most of the fish %they% caught was already dead and rotten inside. | It was after a priest of the gods told %name% that the life of a fisher was not what they desired of %them%, but that they wished for %them% to spill blood in their name, that %they% would set %their% eyes on another trade.} Visiting the tavern one evening, a new opportunity presented itself with the promise of coin for dangerous work.";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Fisherman);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.sackcloth],
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.linen_tunic, this.Math.rand(6, 7)]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.straw_hat],
			[1, ::Legends.Helmet.None]
		]));
	}
});
