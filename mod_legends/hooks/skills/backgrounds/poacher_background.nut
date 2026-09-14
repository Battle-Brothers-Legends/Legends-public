::mods_hookExactClass("skills/backgrounds/poacher_background", function (o) {
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.Poacher);
		this.m.BackgroundDescription = "Poachers tend to have some skill in using bow and arrow to hunt down rabbits and the like.";
		this.m.GoodEnding = "%name%, former poacher, eventually saved enough money to leave the %companyname%. You learned %they% found a bit of mountain land and works it for a local nobleman. Ironically, %their% job is to hunt down poachers.";
		this.m.BadEnding = "No longer seeing the point in risking %their% life for so few crowns, %name% the former poacher put down the sellsword\'s life and returned to unlawfully hunting deer in the woods. A nobleman once offered you a good satchel of crowns to specifically hunt the %person% down. You declined the offer, but the writing was on the wall: %their% days are numbered.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		];
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
	}

	o.getTooltip = function () {
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.FemaleSkinny, Faces = ::Const.Faces.PrettyFemale, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
	}

	o.onBuildDescription <- function ()
	{
		//gender neutral description
		return "{Interested in the thrill of the hunt, | Looking to support a family, | With a grumbling stomach, | After a long and hard winter without a stock of food,} %name% {set off into the woods in chase of deer | sought wildlife to which, if skittishness is any indication, the hunter may or may not have had proper claim | ate a fill of all manner of woodland creatures, a well-used bow yoked across shoulders indicating the means to the meals | took to the woods to hunt game with bow and spear}. Hailing from %townname%, %name% {was, as a poacher, the hunter and the hunted | needed to feed the children back home | sought to support oneself, one\'s own hide, and one\'s ever-growling stomach | was poaching, an act of rebellion against the order of things as much as a means to a full belly}. {Fearful these pursuits would attract bounty hunters or lawmen, decided to settle on life as a bow for hire. | Tired of working so hard just to put food on the table, buying a meal with a sellsword\'s pay just seemed so much easier. | After a bad hunt led to a long stay in a lord\'s dungeon, the poacher would rather put neck on the line as a mercenary now than in the noose as a poacher. | Years of lonely hunting wore on. Although life as a mercenary is exceedingly dangerous, it seems better to die with company than alone. | With a mother pleading for a change of ways, lest the whole family pay for the crimes. the poacher stands here now, a testament to who won the argument.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.Poacher);
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(1, 100);

		if (r <= 40)
		{
			items.equip(this.new("scripts/items/weapons/short_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		if (r <= 50)
		{
			items.equip(this.new("scripts/items/weapons/legend_sturdy_sling"));
		}
		else if (r <= 70)
		{
			items.equip(this.new("scripts/items/weapons/legend_dilapidated_sling"));
		}
		else if (r <= 85)
		{
			items.equip(this.new("scripts/items/weapons/legend_slingshot"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/wonky_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/militia_spear"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.leather_wraps],
			[1, ::Legends.Armor.Standard.ragged_surcoat]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood]
		]));
	}
});

