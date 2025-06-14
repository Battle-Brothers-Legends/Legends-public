this.legend_bladedancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.bladedancer";
		this.m.Name = "Bladedancer";
		this.m.Icon = "ui/backgrounds/background_bladedancer.png";
		this.m.BackgroundDescription = "A skilled nomadic fighter of the south who prefers speed and reach over raw power.";
		this.m.GoodEnding = "%name% found themselves in the possession of more crowns they their family had accumulated across six generations. Despite this, the bladedancer returned to the desert and used their wealth to train the next generation of bladedancers as their tutor did before them.";
		this.m.BadEnding = "The pride and glory went to the head of %name% after you left. Last you heard they broke from the company and travelled alone challenging champions in crownling companies to single combat. You never heard from them ever again.";
		this.m.HiringCost = 850;
		this.m.DailyCost = 45;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
		];
		this.m.Titles = [
			"the Desert Devil",
			"Dunestalker",
			"the Wanderer",
			"the Restless",
			"the Chosen One" //if someone gets this ref. i'll be surprised.
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernMuscular;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
		}
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Ranger;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.MaceTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree,
				this.Const.Perks.MercenaryTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		if (this.m.Ethnicity == 1)
		{
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Young;
			this.m.Bodies = this.Const.Bodies.SouthernFemaleMuscular;
		}
		else
		{
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Bodies = this.Const.Bodies.AfricanFemaleMuscular;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{

		if(this.isBackgroundType(this.Const.BackgroundType.Female)) //holdover text, need to expand this.
		{

		return "{The South is brimming with slaves, and those not among their ranks should be considered lucky. Outside of the walls of southern society %name% was born into a nameless nomadic tribe and made a living off the land. Every year the natural bounty of nature becomes slimmer and the walls of the city states expand further into their homeland.}";
		}
		else
		{

		return "{The South is brimming with slaves, and those not among their ranks should be considered lucky. Outside of the walls of southern society %name% was born into a nameless nomadic tribe and made a living off the land. Every year the natural bounty of nature becomes slimmer and the walls of the city states expand further into their homeland.}";
		}

	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				7
			],
			Bravery = [
				7,
				10
			],
			Stamina = [
				10,
				15
			],
			MeleeSkill = [
				15,
				20
			],
			RangedSkill = [
				-10,
				-10
			],
			MeleeDefense = [
				4,
				6
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				15,
				25
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/oriental/swordlance"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/shamshir"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/oriental/polemace"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.assassin_robe],
			[1, ::Legends.Armor.Southern.blade_dancer_armor_00]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.blade_dancer_head_wrap],
			[1, ::Legends.Helmet.Southern.blade_dancer_helmet_00]
		]));

	}
});

