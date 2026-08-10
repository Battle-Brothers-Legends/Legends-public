::mods_hookExactClass("skills/backgrounds/peddler_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.Peddler);
		this.m.Name = "Peddler";
		this.m.Icon = "ui/backgrounds/background_19.png";
		this.m.BackgroundDescription = "Peddlers are not used to hard physical labor or warfare, but they do excel at haggling for good prices.";
		this.m.GoodEnding = "A lover of the sale, %name% the peddler couldn\'t stay fighting for long. %They% eventually left the %companyname% to go out and start %their% own business. Recently, you got word that %they% was selling trinkets with the company\'s sigil on them. You specifically told %them% to do whatever they wanted except just this one thing, but apparently your warning merely fostered the idea. When you went to tell %them% to stop, %they% slammed a crown-bulging satchel on a rather ornate table, saying it was your \'cut.\' %They% sells those trinkets to this day.";
		this.m.BadEnding = "With hard times hitting the %companyname%, many %sibling%s saw fit to return to their old lives. %name% the peddler was no different. Last you heard %they% got the tar beaten out of %them% trying to sell stolen wares that \'fell off the wagon\' to the very merchant which they originally belonged.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial)
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.CrossbowTree,
				::Const.Perks.MaceTree

			],
			Defense = [
				::Const.Perks.ClothArmorTree
			],
			Traits = [
				::Const.Perks.OrganisedTree,
				::Const.Perks.CalmTree,
				::Const.Perks.IntelligentTree,
				::Const.Perks.DeviousTree
			],
			Enemy = [::Const.Perks.OutlawTree],
			Class = [],
			Profession = [
				::Const.Perks.BarterProfessionTree
			],
			Magic = []
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleThick, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Thick, Hairs = ::Const.Hair.TidyMale, HairColors = ::Const.HairColors.Old, Beards = ::Const.Beards.Tidy});
	}

	o.onBuildDescription <- function ()	{
		return "{House to house, | Once a proud merchant, now | An annoyance to most, | In tough times, everyone has to scrape by somehow, hence why | Not a %person% of the trades, but instead of trade itself,} %name% is a mere peddler. {%They%\'ll dance, %they%\'ll sing, %they%\'ll boast and %they%\'ll act a king, anything to make that sale. | Pushy and unrelenting, %their% tenacity is admirable. | %They%\'ll try to sell off a rusty bucket for a helm once worn by kings. This %person% will sell anything. | This %person% will make you crave things you never knew you wanted. No refunds, though. | %They% used to make a decent living selling {used carts | pots, pans and jars}, until fierce competition drove %them% out of business - by breaking %their% arm.} {Marketing %themselves% is what this frail %person% does best, though few believe %their% pitch about having \'Great swordsmanship and resolute bravery\'. | %They% supposedly handed out \'coupons\' for %their% services, whatever those are. %They're% chippy, though, and any outfit these days could use a warm body no matter its real value. | If hired, %they% promises, you\'ll get a special discount on a virility enhancing potion. | The %person% lowers his voice and tells you %they're% got a great deal on rusted arrow tips, just for you. %They% looks disappointed at your lack of interest. | This %person% knows a %person% who knows a %person% who knows a %person%. All three strangers potentially better at fighting than %them%. | A shame a %person% can\'t fight with %their% words these days. %name% would be unstoppable.}"
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Peddler);
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.PeddlerTitles[this.Math.rand(0, this.Const.Strings.PeddlerTitles.len() - 1)]);
		}

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
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.feathered_hat]
		]));

	}
});

