this.legend_master_archer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(this, ::Legends.Background.LegendMasterArcher);
		this.m.Name = "Master Archer";
		this.m.Icon = "ui/backgrounds/background_master_archer.png";
		this.m.BackgroundDescription = "Master Archers have spent years honing their craft in hunting, sport and war.";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the master archer eventually saw fit to leave it all behind. %They% returned to the life of an archer, working for whoever paid the best. %They% rarely showed the grim reality of hunting humans, but you have to imagine they\'d just rather stop doing it. As far as you know, %they% is doing well these days. %They% purchased a bit of land and helps guide nobles on pricey hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the master archer departed from the company and returned to archery contests. Unfortunately, a shoot off went awry while shooting apples off each other\'s heads. %They% was the better shot, but being better does not help if you\'re dead.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Dastard)
		];
		this.m.Titles = [
			"Target Finder",
			"the Accurate",
			"the Archer",
			"Arrowsplitter",
			"True-Shot",
			"One Shot",
			"Eagle Eye"
		];

		this.m.ExcludedTalents = [
			this.Const.Attributes.MeleeSkill,
			this.Const.Attributes.MeleeDefense
		];

		this.m.Level = this.Math.rand(3, 6);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Cruel;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale, HairColors = ::Const.HairColors.Young, Beards = ::Const.Beards.Untidy});
	}

	function onBuildDescription()
	{
		return "{Without %their% father around, %name%\'s mother taught %them% how to shoot a bow, and how to feed the rest of %their% family. | Born in the hinterlands of %randomtown%, %name% has spent much of %their% life stalking the beasts amongst the trees. | %name% once took a bet to shoot an apple off a pig\'s head. %They% missed. With a belly full of bacon, %they% became determined to never miss again - unless it meant more bacon, of course. | Early in %their% life, %name% liked to traipse about the forests. When a rabid fox attacked %them%, %they% learned to take a bow. When a devilish eagle clawed %their% face, %they% learned to shoot it.} {Once employed by local royalty, a disastrous boar hunt ended with a gored baron and all the blame - and blood - on %name%\'s hands. | The hunter hid the thought well, but for the longest time %they% wondered what it would be like to hunt the ultimate game: man. | Sadly, a bad game of peasant-roulette forced the deer hunter into seeking other means of income. | Unfortunately, %they% is not nearly as good at cooking deer as %they% is at shooting them. A dinner consisting of undercooked meats poisoned his entire family. %their% desperation for a new life is understandable. | After an arduous trip to town to sell meats and leathers, %they% followed the call of mercenary work. | War drove the game out of the forests, and the hunt out of %name%. Now %they% seeks another line of work. | When %their% %partner% fell ill, %they% could not heal her with hunted meat. Needing to earn crowns to pay for treatment, %they% took up the vocation of sellswords - or sellbows, as it were.} {Any outfit could use a deadeye such as this %person%. | Not entirely without faults, %name% is a professional bowman nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another %they% knocks it out. Impressive. | %name% looks like %they% has something to prove - just make sure %they% does it at range. When first given a sword, %they% grabbed it at the wrong end. Yes, that end. | The hunter wields %their% bow like another limb, and shoots %their% arrows like a preacher does words.}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendMasterArcher);
	}

	function onAddEquipment()
	{
		local actor = this.getContainer().getActor();
		actor.setVeteranPerks(3);
		local items = actor.getItems();
		local r;
		items.equip(this.new("scripts/items/weapons/war_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.padded_surcoat],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[1, ::Legends.Armor.Standard.leather_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood]
			// [1, ::Legends.Helmet.Standard.hunters_hat]
		]));

	}

});

