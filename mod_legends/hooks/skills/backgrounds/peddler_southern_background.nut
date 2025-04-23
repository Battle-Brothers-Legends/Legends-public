::mods_hookExactClass("skills/backgrounds/peddler_southern_background", function (o) {
	o.create = function ()
	{
		this.peddler_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernMale;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
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


	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.GoodEnding = "A lover of the sale, %name% the peddler couldn\'t stay fighting for long. She eventually left the %companyname% to go out and start her own business. Recently, you got word that she was selling trinkets with the company\'s sigil on them. You specifically told her to do whatever they wanted except just this one thing, but apparently your warning merely fostered the idea. When you went to tell her to stop, she slammed a crown-bulging satchel on a rather ornate table, saying it was your \'cut.\' She sells those trinkets to this day.";
		this.m.BadEnding = "With hard times hitting the %companyname%, many brothers saw fit to return to their old lives. %name% the peddler was no different. Last you heard she got the tar beaten out of her trying to sell stolen wares that \'fell off the wagon\' to the very merchant which they originally belonged.";

		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleThick;
		this.addBackgroundType(this.Const.BackgroundType.Female);

	}

	o.onBuildDescription <- function ()
	{
		return "{House to house, | Once a proud merchant, now | An annoyance to most, | In tough times, everyone has to scrape by somehow, hence why | Not of the trades, but instead of trade itself,} %name% is a mere peddler. {dancing, singing, boasting and acting like a king, anything to make that sale. | Pushy and unrelenting, that tenacity is admirable. | %name%\'ll try to sell off a rusty bucket for a helm once worn by kings. This peddler will sell anything. | This peddler will make you crave things you never knew you wanted. No refunds, though. | %name% used to make a decent living selling {used carts | pots, pans and jars}, until fierce competition drove down business - by breaking arms.} {Marketing is what this frail peddler does best, though few believe the pitch about having \'Great swordsmanship and resolute bravery\'. | %name% supposedly handed out \'coupons\' for services, whatever those are. %name%\'s chippy, though, and any outfit these days could use a warm body no matter its real value. | If hired, %name% promises, you\'ll get a special discount on a virility enhancing potion. | The merchant lowers their voice and tells you the\'ve got a great deal on rusted arrow tips, just for you. %name% looks disappointed at your lack of interest. | This merchant knows a man who knows a man who knows a man. All three strangers potentially better at fighting. | A shame a war can\'t be fought with words these days. %name% would be unstoppable.}";
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

