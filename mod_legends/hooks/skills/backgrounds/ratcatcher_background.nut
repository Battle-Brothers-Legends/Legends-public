::mods_hookExactClass("skills/backgrounds/ratcatcher_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Ratcatcher);
		this.m.Name = "Ratcatcher";
		this.m.Icon = "ui/backgrounds/background_41.png";
		this.m.BackgroundDescription = "Ratcatchers need to have quick reflexes to catch their prey.";
		this.m.GoodEnding = "%name% the ratcatcher came from stranger stocks, and to stranger stocks %they% returned. After retiring from the %companyname%, %they% started a ratcatching company. %They% was doing wonderful business until it came out that %they% hadn\'t been killing any of the rats, but instead stowing thousands of them in a storehouse just outside town. Last you heard, the %person% was quite content with %their% new and numerous friends.";
		this.m.BadEnding = "You didn\'t think %name% would fit in with sellswords, but %they% proved %themselves% capable. Unfortunately, the %companyname% fell apart and %they% returned to ratcatching. You got word that %their% body was found in a sewer utterly covered in nibbling rats. It\'s said that %they% had a smile on %their% face.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy)
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMax;
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny, Hairs = ::Const.Hair.UntidyMale}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.onBuildDescription = function () {
		return "{Catcher of rats, that\'s the title %name% once preferred. | With perhaps misplaced pride, %name% fashions %themselves% as a %person% of the sewers. | Bowlegged and scrawny, %name%\'s career of hunting rats has seemingly turned %them% into one.} %They% grew up in %townname%, surviving {in the alleys | on rat, the fruit of the sewers | alongside the furry and scuttling, as well as some rats}. {For cheap entertainment, %their% father taught %them% the ways of snaring tiny rodents | %Their% fallen brother\'s body was eaten by rats, forging an angry future of rodent-revenge | %Their% mother demanded the finest meats %they% could find, and she didn\'t mean from the market}. But %townname% wears on people, and it wore on %name% like a giant, nibbling creature. {Hearing of greater rats in the world | Sensing that there must be more to life than rats | Trusting %their% rat-whispering skills}, %name% now seeks to {put %their% shriveled nose, odd gnawing habits, and quick but kind of gross hands to better use. | crush every rat, see them driven before %them%, and to hear the squeals of their kin. %They% has a thousand-yard stare and a clenched fist as %they% tells you this. | perhaps graduate %their% skills from rats to dogs and maybe humans, so %they% says. %They% doesn\'t appear to know what %they're% in for, but perhaps it is best to not tell %them%. | dish up some rat soup, rat salad, rat kebab, rat bread, rat stew, rat chicken, rat wine... after a while, you just stop listening.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Ratcatcher);
	}

	o.onAdded = function ()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.RatcatcherTitles[this.Math.rand(0, this.Const.Strings.RatcatcherTitles.len() - 1)]);
		}
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(this.new("scripts/items/tools/throwing_net"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[1, ::Legends.Armor.Standard.sackcloth]
		]))
	}
});

