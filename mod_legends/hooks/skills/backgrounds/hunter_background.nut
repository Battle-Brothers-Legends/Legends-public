::mods_hookExactClass("skills/backgrounds/hunter_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.hunter";
		this.m.Name = "Hunter";
		this.m.Icon = "ui/backgrounds/background_22.png";
		this.m.BackgroundDescription = "Hunters are used to expertly hunt animals with bow and arrow, and traverse the woods on their own.";
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the hunter eventually saw fit to leave it all behind. They returned to the forests and fields, hunting deer and small game. They rarely showed the grim reality of hunting humans, but you have to imagine they\'d just rather stop doing it. As far as you know, they are doing well for themselves these days. They purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the hunter departed from the company and returned to game hunting. Unfortunately, a hunting trip with a nobleman went awry when the lord was gored through both cheeks by a boar. The hunter, feeling he\'d be blamed, shot by the nobleman and his guard and fled through the forests on their own. They have not been seen since.";
		this.m.HiringCost = 120;
		this.m.DailyCost = 20;
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
			::Legends.Traits.getID(::Legends.Trait.Drunkard)
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

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 2);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[3];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
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
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.BowTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.DirewolfTree,
				this.Const.Perks.SpiderTree,
				this.Const.Perks.SchratTree,
				this.Const.Perks.ArcherTree
			],
			Class = [
				this.Const.Perks.SharpshooterClassTree
			],
			Profession = [], 
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}


	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);
		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "While the %companyname% continued on with great success, %name% the hunter eventually saw fit to leave it all behind. She returned to the forests and fields, hunting deer and small game. She rarely showed the grim reality of hunting humans, but you have to imagine she\'d just rather stop doing it. As far as you know, she\'s doing well for herself these days. She purchased a bit of land and helps guide nobles on pricy hunting trips.";
		this.m.BadEnding = "With the decline of the %companyname% readily obvious, %name% the hunter departed from the company and returned to game hunting. Unfortunately, a hunting trip with a nobleman went awry when the lord was gored through both cheeks by a boar. The hunter, feeling she\'d be blamed, shot by the nobleman and his guard and fled through the forests on her own. She has not been seen since.";
	}

	o.onBuildDescription <- function ()
	{
		return "{Without his father around, %name%\'s mother taught them how to shoot a bow, and how to feed the rest of his family. | Born in the hinterlands of %randomtown%, %name% has spent much of his life stalking the beasts amongst the trees. | %name% once took a bet to shoot an apple off a pig\'s head. They missed. With a belly full of bacon, they became determined to never miss again - unless it meant more bacon, of course. | Early in his life, %name% liked to traipse about the forests. When a rabid fox attacked them, they learned to take a bow. When a devilish eagle clawed his face, they learned to shoot it.} {Once employed by local royalty, a disastrous boar hunt ended with a gored baron and all the blame - and blood - on %name%\'s hands. | The hunter hid the thought well, but for the longest time they wondered what it would be like to hunt the ultimate game: man. | Sadly, a bad game of peasant-roulette forced the deer hunter into seeking other means of income. | Unfortunately, they are not nearly as good at cooking deer as  is at shooting them. A dinner consisting of undercooked meats poisoned his entire family. His desperation for a new life is understandable. | After an arduous trip to town to sell meats and leathers, they followed the call of mercenary work. | War drove the game out of the forests, and the hunt out of %name%. Now they seek another line of work. | When his wife fell ill, they could not heal her with hunted meat. Needing to earn crowns to pay for treatment, they took up the vocation of sellswords - or sellbows, as it were.} {Any outfit could use a deadeye such as this man. | Not entirely without faults, %name% is a professional bowman nonetheless. | A quick demonstration is offered: %name% shoots one arrow high into the sky, and with another they knock it out. Impressive. | %name% looks like they have something to prove - just make sure they do it at range. When first given a sword, they grabbed it at the wrong end. Yes, that end. | The hunter wields his bow like another limb, and shoots his arrows like a preacher does words.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				5
			],
			Stamina = [
				5,
				7
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				17,
				20
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				3
			],
			Initiative = [
				0,
				5
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		if (this.Math.rand(0, 1) == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.leather_tunic],
			[1, ::Legends.Armor.Standard.ragged_surcoat],
			[1, ::Legends.Armor.Standard.linen_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
				[1, ::Legends.Helmet.Standard.hood]
				// [1, ::Legends.Helmet.Standard.hunters_hat]
		]))
	}

});
