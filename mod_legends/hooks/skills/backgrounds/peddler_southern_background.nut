::mods_hookExactClass("skills/backgrounds/peddler_southern_background", function (o) {
	o.create = function ()
	{
		this.peddler_background.create();
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
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
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleThick, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors = ::Const.HairColors.Southern}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernMale, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 90);
	}

	o.onBuildDescription <- function ()	{
		return "{House to house, | Once a proud merchant, now | An annoyance to most, | In tough times, everyone has to scrape by somehow, hence why | Not a %person% of the trades, but instead of trade itself,} %name% is a mere peddler. {%They%\'ll dance, %they%\'ll sing, %they%\'ll boast and %they%\'ll act a king, anything to make that sale. | Pushy and unrelenting, %their% tenacity is admirable. | %They%\'ll try to sell off a rusty bucket for a helm once worn by kings. This %person% will sell anything. | This %person% will make you crave things you never knew you wanted. No refunds, though. | %They% used to make a decent living selling {used carts | pots, pans and jars}, until fierce competition drove %them% out of business - by breaking %their% arm.} {Marketing %themselves% is what this frail %person% does best, though few believe %their% pitch about having \'Great swordsmanship and resolute bravery\'. | %They% supposedly handed out \'coupons\' for %their% services, whatever those are. %They're% chippy, though, and any outfit these days could use a warm body no matter its real value. | If hired, %they% promises, you\'ll get a special discount on a virility enhancing potion. | The %person% lowers his voice and tells you %they're% got a great deal on rusted arrow tips, just for you. %They% looks disappointed at your lack of interest. | This %person% knows a %person% who knows a %person% who knows a %person%. All three strangers potentially better at fighting than %them%. | A shame a %person% can\'t fight with %their% words these days. %name% would be unstoppable.}";
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

		local armor = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash]
		]);
		items.equip(armor);
		local helm = this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Southern.southern_head_wrap],
			[1, ::Legends.Helmet.Standard.legend_noble_southern_hat],
			[3, ::Legends.Helmet.None]
		]);
		items.equip(helm)
	}
});

