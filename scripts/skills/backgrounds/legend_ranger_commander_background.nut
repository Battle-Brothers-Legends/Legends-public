this.legend_ranger_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger);
		this.m.Name = "Ranger";
		this.m.Icon = "ui/backgrounds/background_ranger.png";
		this.m.BackgroundDescription = "Rangers are expert trackers and archers, used to hunting prey of any kind";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the ranger eventually saw fit to leave it all behind. %They% returned to the forests and fields, hunting deer and small game. %They% rarely showed the grim reality of hunting humans, but you have to imagine %they%\'d just rather stop doing it. As far as you know, %they're% doing well for %themselves% these days. %They% purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the ranger departed from the company and returned to game hunting. Unfortunately, a hunting trip with a nobleman went awry when the lord was gored through both cheeks by a boar. The hunter, fearing %they%\'d be blamed, shot by the nobleman and his guard and fled through the forests on %their% own. %They% has not been seen since.";
		this.m.HiringCost = 12000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.Titles = [
			"the Deerhunter",
			"Woodstalker",
			"the Woodsman",
			"the Hunter",
			"True-Shot",
			"One Shot",
			"Eagle Eye"
		];
		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.CrossbowTree,
				::Const.Perks.BowTree,
				::Const.Perks.SlingTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.AxeTree,
			],
			Defense = [
				::Const.Perks.ClothArmorTree,
				::Const.Perks.LightArmorTree,
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree,
				::Const.Perks.FastTree,
				::Const.Perks.IntelligentTree,
				::Const.Perks.FitTree,
				::Const.Perks.AgileTree,
				::Const.Perks.LargeTree
			],
			Enemy = [
				::Const.Perks.BeastTree,
				::Const.Perks.GreenskinTree,
				::Const.Perks.OccultTree,
			],
			Class = [
				::Const.Perks.BeastClassTree,
				::Const.Perks.HoundmasterClassTree
			],
			Profession = [],
			Magic = [
				::Const.Perks.RangerHuntMagicTree,
				::Const.Perks.MasterArcherTree,
				::Const.Perks.ArcherCommandTree
			]
		};

		this.m.CustomPerkTree = [
			[
				::Legends.Perk.LegendTacticalManeuvers
			],
			[],
			[
				::Legends.Perk.LegendHairSplitter
			],
			[],
			[],
			[],
			[],
			[],
			[],
			[],
			[]
		];
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.setCommanderGender();
		_gender ? this.setBodyCharacteristics(_gender, {Faces = ::Const.Faces.PrettyFemale, HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.TidyMale, Beards = ::Const.Beards.Tidy});
	}

	function onBuildDescription() {
		return "This is your commander, when %they% dies the company ends. {Without %their% father around, %name%\'s mother taught %them% how to shoot a bow, and how to feed the rest of %their% family. | Born in the hinterlands of %randomtown%, %name% has spent much of %their% life stalking the beasts amongst the trees. | %name% once took a bet to shoot an apple off a pig\'s head. %They% missed. With a belly full of bacon, %they% became determined to never miss again - unless it meant more bacon, of course. | Early in %their% life, %name% liked to traipse about the forests. When a rabid fox attacked %them%, %they% learned to take a bow. When a devilish eagle clawed %their% face, %they% learned to shoot it.} {Once employed by local royalty, a disastrous boar hunt ended with a gored baron and all the blame - and blood - on %name%\'s hands. | The hunter hid the thought well, but for the longest time %they% wondered what it would be like to hunt the ultimate game: man. | Sadly, a bad game of peasant-roulette forced the deer hunter into seeking other means of income. | Unfortunately, %they% is not nearly as good at cooking deer as %they% is at shooting them. A dinner consisting of undercooked meats poisoned his entire family. %their% desperation for a new life is understandable. | After an arduous trip to town to sell meats and leathers, %they% followed the call of mercenary work. | War drove the game out of the forests, and the hunt out of %name%. Now %they% seeks another line of work. | When %their% %partner% fell ill, %they% could not heal her with hunted meat. Needing to earn crowns to pay for treatment, %they% took up the vocation of sellswords - or sellbows, as it were.} {Any outfit could use a deadeye such as this %person%. | Not entirely without faults, %name% is a professional bowman nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another %they% knocks it out. Impressive. | %name% looks like %they% has something to prove - just make sure %they% does it at range. When first given a sword, %they% grabbed it at the wrong end. Yes, that end. | The hunter wields %their% bow like another limb, and shoots %their% arrows like a preacher does words.}";
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendCommanderRanger);
	}

	function onAdded()
	{
		if (this.m.IsNew)
			::Legends.Traits.grant(this, ::Legends.Trait.Athletic);
		this.character_background.onAdded();
	}


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();


		local r;
		items.equip(this.new("scripts/items/weapons/short_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));


		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/dagger"));
		}
		if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[1, ::Legends.Armor.Standard.leather_tunic]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.hood]
			// [1, ::Legends.Helmet.Standard.hunters_hat]
		]));

	}
});
