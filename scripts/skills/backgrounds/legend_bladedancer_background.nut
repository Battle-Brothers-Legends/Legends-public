this.legend_bladedancer_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendBladedancer);
		this.m.Name = "Bladedancer";
		this.m.Icon = "ui/backgrounds/background_bladedancer.png";
		this.m.BackgroundDescription = "A skilled nomadic fighter of the south who prefers speed and reach over raw power.";
		this.m.GoodEnding = "%name% found %themselves% in the possession of more crowns than %their% family had accumulated across six generations. Despite this, the bladedancer returned to the desert and used %their% wealth to train the next generation of bladedancers as %their% tutor did before %them%.";
		this.m.BadEnding = "The pride and glory went to the head of %name% after you left. Last you heard %they% broke from the company and traveled alone challenging champions in crownling companies to single combat. You never heard from %them% ever again.";
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
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
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
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Ranger;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.MaceTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.ClothArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.FitTree,
				::Const.Perks.CalmTree,
				::Const.Perks.ViciousTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree,
				::Const.Perks.OutlawTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (this.m.Ethnicity == 1) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemaleMuscular, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernMuscular, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 90);
		}
		else if (this.m.Ethnicity == 2) {	
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanFemaleMuscular, Faces = ::Const.Faces.AfricanFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.African}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanMale, Faces = ::Const.Faces.AfricanMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.African, Beards = ::Const.Beards.Southern}, 90);
		}
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
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendBountyHunter);
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

