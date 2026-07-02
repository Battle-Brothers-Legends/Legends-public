this.legend_legion_legate_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_legate";
		this.m.Name = "Legate";
		this.m.Icon = "ui/backgrounds/background_legion_legate.png";
		this.m.BackgroundDescription = "A military figure of great experience and prowess, the legate has risen through the ranks with bloody blade in hand.";
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
		// this.m.BackgroundType = this.Const.BackgroundType.Untalented;
		this.m.Names = this.Const.Strings.AncientDeadNames;
		this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.Level = this.Math.rand(5, 7);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3]; // 0.0, 0.1, 0.2, 0.3
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.025,//plains
				0.01, //swamp
				0.01, //hills
				0.01, //forest
				0.01, //forest
				0.01, //forest_leaves
				0.01, //autumn_forest
				0.01, //mountains
				0.0, // ?
				0.025, //farmland
				0.011, // snow
				0.015, // badlands
				0.015, //highlands
				0.025, //stepps
				0.0, //ocean
				0.01, //desert
				0.025 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.DaggerTree,
				::Const.Perks.SpearTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.SwordTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.CleaverTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
				::Const.Perks.DeviousTree,
				::Const.Perks.LargeTree,
				::Const.Perks.InspirationalTree,
				::Const.Perks.IntelligentTree,
				::Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [],
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

	function onBuildDescription() //— \n { TODO | TODO }
	{ 
		return "{%name% was destined for leadership since they were a child — their family marking them out for something greater. | Initially struggling in life, %name% went through several prestigious military schools. | %name% never wished to be in command. A simple legionary in the beginning, they killed their commanding officer and was awarded with their rank after investigations found them to be a traitor. | In the heat of a losing battle, %name% rose to the occasion to become the man of the hour — turning the tide from a crushing defeat into a pyrrhic victory.} {Feeling underwhelmed by their rank, they took to taking a more active role in the field. | Tired with battle reports, meetings and strategy — they frequently absconded from their duties. | Taking the rank in their stride, %name% did what they could to serve the Empire.}";
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
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}
		this.character_background.onAdded();

		if (!this.m.Container.hasActive(::Legends.Active.LegendCommandLegion))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendCommandLegion);
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
