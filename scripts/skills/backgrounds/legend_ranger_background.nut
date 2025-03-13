this.legend_ranger_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_ranger";
		this.m.Name = "Ranger";
		this.m.Icon = "ui/backgrounds/ranger_01.png";
		this.m.BackgroundDescription = "Rangers are expert trackers and marksman, used to hunting prey of any kind";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the ranger eventually saw fit to leave it all behind. He returned to the forests and fields, hunting deer and small game. He rarely showed the grim reality of hunting humans, but you have to imagine he\'d just rather stop doing it. As far as you know, he\'s doing well for himself these days. He purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the ranger departed from the company and returned to game hunting. Unfortunately, a hunting trip with a nobleman went awry when the lord was gored through both cheeks by a boar. The hunter, feeling he\'d be blamed, shot by the nobleman and his guard and fled through the forests on his own. He has not been seen since.";
		this.m.HiringCost = 2500;
		this.m.DailyCost = 35;
		this.m.Excluded = [
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
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Untidy;


		this.m.Level = 1;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.0, //swamp
			0.0, //hills
			0.05, //forest
			0.05, //forest
			0.05, //forest_leaves
			0.05, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.01, // snow
			0.01, // badlands
			0.01, //highlands
			0.0, //stepps
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.CripplingStrikes,
				::Legends.Perk.FastAdaption,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.Student,
				::Legends.Perk.Recover,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.LegendLookout,
				::Legends.Perk.LegendSummonHound,
				::Legends.Perk.LegendBackToBasics,
				::Legends.Perk.LegendAlert
			],
			[
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Bullseye,
				::Legends.Perk.Dodge,
				::Legends.Perk.QuickHands,
				::Legends.Perk.Gifted,
				::Legends.Perk.LegendNightvision,
				::Legends.Perk.LegendDebilitate,
				::Legends.Perk.LegendAthlete,
				::Legends.Perk.LegendFavouredEnemyDirewolf,
				::Legends.Perk.LegendFavouredEnemySpider,
			],
			[
				::Legends.Perk.Backstabber,
				::Legends.Perk.Anticipation,
				::Legends.Perk.Rotation,
				::Legends.Perk.LegendFeint,
				::Legends.Perk.LegendOnslaught,
				::Legends.Perk.LegendDoubleStrike,
				::Legends.Perk.LegendSummonFalcon,
				::Legends.Perk.LegendAmmoBinding,
				::Legends.Perk.LegendFavouredEnemyDirewolf,
				::Legends.Perk.DevastatingStrikes
			],
			[
				::Legends.Perk.SpecAxe,
				::Legends.Perk.SpecSword,
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecCrossbow,
				::Legends.Perk.SpecBow,
				::Legends.Perk.LegendMasterySlings,
				::Legends.Perk.LegendMasteryNets,
				::Legends.Perk.LegendSpecPoison,
				::Legends.Perk.SpecThrowing
			],
			[
				::Legends.Perk.Overwhelm,
				::Legends.Perk.LoneWolf,
				::Legends.Perk.Footwork,
				::Legends.Perk.LegendCloseCombatArcher,
				::Legends.Perk.LegendBallistics,
				::Legends.Perk.LegendIncoming,
				::Legends.Perk.LegendSummonWolf,
				::Legends.Perk.LegendHeightenedReflexes,
				::Legends.Perk.LegendLithe,
				::Legends.Perk.LegendAmmoBundles,
				::Legends.Perk.LegendFavouredEnemyOrk,
				::Legends.Perk.LegendFavouredEnemyGoblin
			],
			[
				::Legends.Perk.Berserk,
				::Legends.Perk.HeadHunter,
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendRebound,
				::Legends.Perk.LegendWindReader,
				::Legends.Perk.LegendCascade,
				::Legends.Perk.LegendCoordinatedVolleys,
				::Legends.Perk.LegendPiercingShot,
				::Legends.Perk.LegendPerfectFit,
				::Legends.Perk.LegendSecondWind,
				::Legends.Perk.LegendBlendIn,
				::Legends.Perk.LegendFavouredEnemySchrat,
				::Legends.Perk.LegendFavouredEnemyArcher
			],
			[
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.LegendPerfectFocus,
				::Legends.Perk.BattleFlow,
				::Legends.Perk.LegendEvasion,
				::Legends.Perk.LegendBalance,
				::Legends.Perk.LegendBigGameHunter,
				::Legends.Perk.LegendFavouredEnemyUnhold,
				::Legends.Perk.LegendFavouredEnemyLindwurm,
				::Legends.Perk.LegendFreedomOfMovement,
				::Legends.Perk.LegendFavouredEnemyUnhold,
			],
			[],
			[],
			[],
			[]
		];
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the ranger eventually saw fit to leave it all behind. She returned to the forests and fields, hunting deer and small game. She rarely showed the grim reality of hunting humans, but you have to imagine she\'d just rather stop doing it. As far as you know, she\'s doing well for herself these days. She purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the ranger departed from the company and returned to game hunting. Unfortunately, a hunting trip with a nobleman went awry when the lord was gored through both cheeks by a boar. The hunter, feeling he\'d be blamed, shot by the nobleman and his guard and fled through the forests on her own. She has not been seen since.";

	}



	function onBuildDescription()
	{
		//gender neutral description, no need variants
		return " {Without a father around, %name%\'s mother taught how to shoot a bow, and how to feed the rest of the family. | Born in the hinterlands of %randomtown%, %name% has spent life stalking the beasts amongst the trees. | %name% once took a bet to shoot an apple off a pig\'s head. The shot missed. A belly full of bacon, determined to never miss again - unless it meant more bacon, of course. | Early in life, %name% liked to traipse about the forests. When a rabid fox attacked, %name% learned to take a bow. When a devilish eagle clawed %name%\'s face, the pain taught how to shoot it.} {Once employed by local royalty, a disastrous boar hunt ended with a gored baron and all the blame - and blood - on %name%\'s hands. | The hunter hid the thought well, but for the longest time wondered what it would be like to hunt the ultimate game: man. | Sadly, a bad game of peasant-roulette forced the deer hunter into seeking other means of income. | Unfortunately, the ranger is not nearly as good at cooking deer as shooting them. A dinner consisting of undercooked meats poisoned %name%\'s entire family. Desperation for a new life is understandable. | After an arduous trip to town to sell meats and leathers, %name% followed the call of mercenary work. | War drove the game out of the forests, and the hunt out of %name%. Now it has driven %name% to seek another line of work. | When %name%\'s partner fell ill, the wounds could not be healed with hunted meat. Needing to earn crowns to pay for treatment, %name% took up the vocation of sellswords - or sellbows, as it were.} {Any outfit could use a deadeye such as this ranger. | Not entirely without faults, %name% is a professional archer nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another knocks it out. Impressive. | %name% has the look of someone with something to prove - just make sure it is proved at range. When first given a sword, %name% grabbed it at the wrong end. Yes, that end. | The hunter wields a bow like another limb, and shoots arrows like a preacher does words.}";
	}

	function onChangeAttributes()
	{

		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				15,
				23
			],
			MeleeDefense = [
				-5,
				0
			],
			RangedDefense = [
				3,
				6
			],
			Initiative = [
				15,
				20
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		//this.m.Container.add(this.new("scripts/skills/perks/perk_pathfinder"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_footwork"));
		::Legends.Traits.grant(this, ::Legends.Trait.Loyal);

	}



	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 3;
		talents[this.Const.Attributes.Fatigue] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();


		local r;
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		if (r == 1)
		{
			items.addToBag(this.new("scripts/items/weapons/bludgeon"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_surcoat"],
			[1, "thick_tunic"],
			[1, "leather_tunic"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"]
			// [1, "hunters_hat"]
		]));

	}
});
