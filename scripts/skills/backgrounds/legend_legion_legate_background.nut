this.legend_legion_legate_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_legate";
		this.m.Name = "Legate";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "A military figure of great experience and prowess";
		// this.m.GoodEnding = ""; //to do
		// this.m.BadEnding = ""; //to do
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			// this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
			// this.Const.Attributes.Bravery,
			this.Const.Attributes.Fatigue
		];

		//apperance
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		//---
		this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.Names = this.Const.Strings.AncientDeadNames;
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.Level = this.Math.rand(5, 7);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3]; // 0.0, 0.1, 0.2, 0.3
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				1.0, //swamp
				0.05, //hills
				0.03, //forest
				0.03, //forest
				0.03, //forest_leaves
				0.03, //autumn_forest
				1.5, //mountains
				0.0, // ?
				0.0, //farmland
				0.03, //snow
				0.03, //badlands
				0.03, //highlands
				0.03, //stepps
				0.0, //ocean
				0.8, //desert
				0.8 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ButcherClassTree,
				this.Const.Perks.ScytheClassTree
			],
			Profession = [],
			Magic = []
		}
	}

	function getTooltip ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can directly command a single unit that is not another Legate" //see function onadded below.
		});
		return ret;
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.Names = this.Const.Strings.AncientDeadNamesFemale;
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription() //to do
	{
		return "{ TODO | TODO }";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				12,
				16
			],
			Bravery = [ //not needed except for resisting charm and sleep
				20,
				25
			],
			Stamina = [ //not needed except for equipment weight
				20,
				25
			],
			MeleeSkill = [
				15,
				20
			],
			RangedSkill = [
				5,
				9
			],
			MeleeDefense = [
				9,
				15
			],
			RangedDefense = [
				3,
				6
			],
			Initiative = [
				10,
				15
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		if (this.m.IsNew) {
			::Legends.Perks.grant(this, ::Legends.Active.LegendCommandLegion);
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
	}

	function adjustHiringCostBasedOnEquipment() //reduces cost for equipment worn on skeletons to zero for recruiting purposes.
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();

		items.equip(::Const.World.Common.pickItem([
			[1, "weapons/ancient/crypt_cleaver"],
			[1, "weapons/ancient/warscythe"],
			[1, "weapons/ancient/legend_gladius"],
			[1, "weapons/ancient/legend_kopis"]
		], "scripts/items/"));

		items.equip(::Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[2, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Ancient.ancient_honorguard_helmet],
			[1, ::Legends.Helmet.Ancient.legend_ancient_legionary_helmet_restored]
		]));
	}
});
