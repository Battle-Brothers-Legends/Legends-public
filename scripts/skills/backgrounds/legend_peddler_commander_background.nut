this.legend_peddler_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderPeddler);
		this.m.Name = "Merchant";
		this.m.Icon = "ui/backgrounds/background_19.png"; //needs new
		//gender neutral description
		this.m.BackgroundDescription = "Merchants were held in high regard and powerful people, they could bankroll armies or buy entire estates if they had the reason to do so.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 0; //avatar
		this.m.Excluded = [
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
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendMartial)
		];
		this.m.Ethnicity = this.Math.rand(0, 2);
		this.m.Level = this.Math.rand(1, 2);
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence;
		// this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		// this.m.AlignmentMax = this.Const.LegendMod.Alignment.Kind;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[3];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[4];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.2, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.1, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //steppes
				0.0, //ocean
				0.0, //desert
				0.1  //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.SlingTree,
				::Const.Perks.CrossbowTree,
				::Const.Perks.MaceTree

			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.OrganisedTree,
				::Const.Perks.CalmTree,
				::Const.Perks.IntelligentTree,
				::Const.Perks.DeviousTree
			],
			Enemy = [
				::Const.Perks.OutlawTree
			],
			Class = [],
			Profession = [
				::Const.Perks.BarterProfessionTree,
				::Const.Perks.CaravaneerProfessionTree
			],
			Magic = [
				::Const.Perks.PhilosophyMagicTree
			]
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.setCommanderGender();
		if (this.m.Ethnicity == 0) {
			_gender ? this.setBodyCharacteristics(_gender) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.Skinny, Hairs = ::Const.Hair.CommonMale}, 60);
		}
		else if (this.m.Ethnicity == 1) {
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemale, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernMale, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.Southern, Beards = ::Const.Beards.Southern}, 60);
		}
		else if (this.m.Ethnicity == 2) {	
			_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanFemale, Faces = ::Const.Faces.AfricanFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.African}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.AfricanMale, Faces = ::Const.Faces.AfricanMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.African, Beards = ::Const.Beards.Southern}, 60);
		}
	}

	function onBuildDescription() {
		//gender neutral
		return "{After an exchange gone bad, | Once a proud noble, now | Well read and learned, | In tough times, humanity has a habit of falling to pieces when they need to be together most, hence} %name% now roams the land buying and selling what they can. {More honest than most of their kind | Persistent but kind | Trying to hide from their past | A purveyor of exotic goods | After getting into the business selling {used weapons | wine | trinkets}} {, they prefer to be known as a merchant - not a desperate peddler. Even if an unhealthy lifestyle has caught up with them in the meantime. | , they prefer to be known as someone who is trying their best to get by in an uncaring world | , %name% moves from place to place, possibly for good reasons they\'d rather not discuss in the open. Or at all.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-8,
				-5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				-5,
				0
			],
			RangedSkill = [
				-5,
				0
			],
			MeleeDefense = [
				4,
				8
			],
			RangedDefense = [
				3,
				9
			],
			Initiative = [
				0,
				7
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		local actor = this.getContainer().getActor();

		if (this.Math.rand(0, 3) == 3)
		{
			actor.setTitle(this.Const.Strings.PeddlerTitles[this.Math.rand(0, this.Const.Strings.PeddlerTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 5);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_dilapidated_sling"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[4, ::Legends.Armor.Standard.linen_tunic],
			[2, ::Legends.Armor.Southern.cloth_sash],
			[3, ::Legends.Armor.Standard.noble_tunic],
			[1, ::Legends.Armor.Standard.noble_gear]
		]));

		items.equip(this.Const.World.Common.pickHelmet([ //higher number = more likely to spawn
			[4, ::Legends.Helmet.None],
			[2, ::Legends.Helmet.Standard.legend_noble_hood],
			[1, ::Legends.Helmet.Standard.noble_headgear],
			[3, ::Legends.Helmet.Standard.feathered_hat]
		]));

	}
});

