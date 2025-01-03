this.legend_ranger_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_ranger";
		this.m.Name = "Ranger";
		this.m.Icon = "ui/backgrounds/ranger_02.png";
		this.m.BackgroundDescription = "Rangers are expert trackers and archers, used to hunting prey of any kind";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the ranger eventually saw fit to leave it all behind. Returning to the forests and fields, hunting deer and small game. Rarely showed the grim reality of hunting humans, but you have to imagine they\'d just rather stop doing it. As far as you know, %name%\'s doing well these days. Purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the ranger departed from the company and returned to game hunting. Unfortunately, a hunting trip with a nobleman went awry when the lord was gored through both cheeks by a boar. The hunter, fearing the blame, shot by the nobleman and his guard and fled through the forests alone. %name% has not been seen since.";
		this.m.HiringCost = 12000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.short_sighted",
			"trait.fat",
			"trait.clumsy",
			"trait.gluttonous",
			"trait.asthmatic",
			"trait.craven",
			"trait.dastard",
			"trait.drunkard",
			"trait.disloyal",
			"trait.loyal"
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
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.ExpertHunter;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
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
				this.Const.Perks.PerkDefs.LegendSummonHound,
				this.Const.Perks.PerkDefs.LegendSpecialistShortbowSkill,
				this.Const.Perks.PerkDefs.CripplingStrikes,
				this.Const.Perks.PerkDefs.BagsAndBelts,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.LegendLookout,
				this.Const.Perks.PerkDefs.LegendBackToBasics,
				this.Const.Perks.PerkDefs.LegendAlert
			],
			[
				this.Const.Perks.PerkDefs.Bullseye,
				this.Const.Perks.PerkDefs.LegendHairSplitter,
				this.Const.Perks.PerkDefs.LegendDogWhisperer,
				this.Const.Perks.PerkDefs.LegendNetRepair,
				this.Const.Perks.PerkDefs.LegendDebilitate,
				this.Const.Perks.PerkDefs.LegendAthlete,
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.QuickHands,
				this.Const.Perks.PerkDefs.CoupDeGrace,
				this.Const.Perks.PerkDefs.LegendNightvision,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySpider

			],
			[
				this.Const.Perks.PerkDefs.LegendSpecialistShortbowDamage,
				this.Const.Perks.PerkDefs.LegendNetCasting,
				this.Const.Perks.PerkDefs.LegendDogBreeder,
				this.Const.Perks.PerkDefs.LegendSummonFalcon,
				this.Const.Perks.PerkDefs.Backstabber,
				this.Const.Perks.PerkDefs.Anticipation,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.LegendDoubleStrike,
				this.Const.Perks.PerkDefs.LegendAmmoBinding,
				this.Const.Perks.PerkDefs.DevastatingStrikes,
				this.Const.Perks.PerkDefs.LegendOnslaught
			],
			[
				this.Const.Perks.PerkDefs.SpecCrossbow,
				this.Const.Perks.PerkDefs.SpecBow,
				this.Const.Perks.PerkDefs.LegendMasteryNets,
				this.Const.Perks.PerkDefs.LegendPackleader,
				this.Const.Perks.PerkDefs.SpecAxe,
				this.Const.Perks.PerkDefs.SpecSword,
				this.Const.Perks.PerkDefs.SpecDagger,
				this.Const.Perks.PerkDefs.SpecThrowing,
				this.Const.Perks.PerkDefs.LegendMasterySlings,
				this.Const.Perks.PerkDefs.LegendSpecPoison,
				this.Const.Perks.PerkDefs.SpecThrowing
			],
			[
				this.Const.Perks.PerkDefs.LegendCloseCombatArcher,
				this.Const.Perks.PerkDefs.LegendDogMaster,
				this.Const.Perks.PerkDefs.Overwhelm,
				this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.LegendEvasion,
				this.Const.Perks.PerkDefs.LegendBallistics,
				this.Const.Perks.PerkDefs.LegendHeightenedReflexes,
				this.Const.Perks.PerkDefs.LegendIncoming,
				this.Const.Perks.PerkDefs.LegendAmmoBundles,
				this.Const.Perks.PerkDefs.LegendLithe,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin,
			],
			[
				this.Const.Perks.PerkDefs.Berserk,
				this.Const.Perks.PerkDefs.HeadHunter,
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.LegendRebound,
				this.Const.Perks.PerkDefs.LegendCoordinatedVolleys,
				this.Const.Perks.PerkDefs.LegendCascade,
				this.Const.Perks.PerkDefs.LegendWindReader,
				this.Const.Perks.PerkDefs.LegendPerfectFit,
				this.Const.Perks.PerkDefs.LegendPiercingShot,
				this.Const.Perks.PerkDefs.LegendSecondWind,
				this.Const.Perks.PerkDefs.LegendBlendIn,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySchrat,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyArcher
			],
			[
				this.Const.Perks.PerkDefs.LegendBigGameHunter,
				this.Const.Perks.PerkDefs.KillingFrenzy,
				this.Const.Perks.PerkDefs.LegendPerfectFocus,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyUnhold,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm,
				this.Const.Perks.PerkDefs.LegendBalance,
				this.Const.Perks.PerkDefs.LegendFreedomOfMovement
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
		return "This is your commander, when they die the company ends. {Without a father around, %name%\'s mother taught how to shoot a bow, and how to feed the rest of the family. | Born in the hinterlands of %randomtown%, %name% has spent life stalking the beasts amongst the trees. | %name% once took a bet to shoot an apple off a pig\'s head. The shot missed. A belly full of bacon, determined to never miss again - unless it meant more bacon, of course. | Early in life, %name% liked to traipse about the forests. When a rabid fox attacked, %name% learned to take a bow. When a devilish eagle clawed %name\'s face, the pain taught how to shoot it.} {Once employed by local royalty, a disastrous boar hunt ended with a gored baron and all the blame - and blood - on %name%\'s hands. | The hunter hid the thought well, but for the longest time wondered what it would be like to hunt the ultimate game: man. | Sadly, a bad game of peasant-roulette forced the deer hunter into seeking other means of income. | Unfortunately, the ranger is not nearly as good at cooking deer as shooting them. A dinner consisting of undercooked meats poisoned %name%\'s entire family. Desperation for a new life is understandable. | After an arduous trip to town to sell meats and leathers, %name% followed the call of mercenary work. | War drove the game out of the forests, and the hunt out of %name%. Now it has driven %name% to seek another line of work. | When %name%\'s partner fell ill, the wounds could not be healed with hunted meat. Needing to earn crowns to pay for treatment, %name% took up the vocation of sellswords - or sellbows, as it were.} {Any outfit could use a deadeye such as this ranger. | Not entirely without faults, %name% is a professional archer nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another knocks it out. Impressive. | %name% has the look of someone with something to prove - just make sure it is proved at range. When first given a sword, h%name% grabbed it at the wrong end. Yes, that end. | The hunter wields a bow like another limb, and shoots arrows like a preacher does words.}";
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
				15,
				15
			],
			MeleeSkill = [
				0,
				5
			],
			RangedSkill = [
				20,
				25
			],
			MeleeDefense = [
				-5,
				0
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_roster_2"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Container.add(this.new("scripts/skills/traits/athletic_trait"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_guide_steps"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_footwork"));

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

		local stash = this.World.Assets.getStash()
		stash.add(this.new("scripts/items/ammo/quiver_of_arrows"));
		stash.add(this.new("scripts/items/supplies/cured_venison_item"));
		stash.removeByID("supplies.ground_grains");

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
			[1, "legend_ranger_armor"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"]
			// [1, "hunters_hat"]
		]));

	}
});
