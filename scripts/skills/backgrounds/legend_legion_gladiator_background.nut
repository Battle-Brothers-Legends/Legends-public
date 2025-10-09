this.legend_legion_gladiator_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_gladiator";
		this.m.Name = "Gladiator";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "A leader to few, a slave of many.";
		// this.m.GoodEnding = ""; //to do
		// this.m.BadEnding = ""; //to do
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = [ //can roll; brute, clubfooted, clumsy, fragile, huge, hesitant, strong, sure footing, survivor, tough, bright, lucky, shortsighted, aggressive, martial, predictable, lumbering, quick, swift, team player, hate nobles, frail, etc (see commented out below)
			::Legends.Traits.getID(::Legends.Trait.Ailing), //only including naturally occouring or obtainable traits.
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			// ::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			// ::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			// ::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			// ::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			// ::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			// ::Legends.Traits.getID(::Legends.Trait.EagleEyes),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			// ::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			// ::Legends.Traits.getID(::Legends.Trait.HateGreenskins),
			// ::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			// ::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.NightOwl),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			// ::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Weasel),

			//legend traits
			// ::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			// ::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			// ::Legends.Traits.getID(::Legends.Trait.LegendFrail),
			//::Legends.Traits.getID(::Legends.Trait.LegendCannibalistic),
			// ::Legends.Traits.getID(::Legends.Trait.LegendSteadyHands),
			// ::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			// ::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			// ::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			// ::Legends.Traits.getID(::Legends.Trait.LegendTalented),
		];

		this.m.ExcludedTalents = [

			this.Const.Attributes.Bravery
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
		this.m.Level = this.Math.rand(4, 5);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2]; // 0.0, 0.1, 0.2, 0.3
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, //snow
				0.0, //badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				1.0, //desert
				1.0 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.ButcherClassTree,
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.JugglerClassTree,
				this.Const.Perks.SpearfisherClassTree
			],
			Profession = [],
			Magic = []
		}
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
		this.m.BeardChance = 1;
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
				20,
				30
			],
			Bravery = [ //not needed except for resisting charm and sleep
				5,
				10
			],
			Stamina = [ //not needed except for equipment weight
				10,
				15
			],
			MeleeSkill = [
				12,
				16
			],
			RangedSkill = [
				10,
				18
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				4,
				7
			],
			Initiative = [
				20,
				30
			]
		};
		return c;
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = [ //all injuries associated with stamina regen, health or resolve
		//perma injuries must be managed in actor.nut, NOT here!
		//	"injury.traumatized",
		//	"injury.brain_damage",
		//	"injury.missing_nose",
		//	"injury.weakened_heart",
		//	"injury.collapsed_lung_part",
		//temp
			"injury.cut_artery",
			"injury.cut_throat",
			"injury.deep_abdominal_cut",
			"injury.deep_chest_cut",
			"injury.exposed_ribs",
			"injury.grazed_kidney",
			"injury.grazed_neck",
			"injury.infected_wound",
			"injury.sickness",
			"injury.stabbed_guts",
			"injury.broken_nose",
			"injury.crushed_windpipe",
			"injury.fractured_ribs",
			"injury.inhaled_flames",
			"injury.pierced_chest",
			"injury.pierced_lung",
			"injury.pierced_side"
		];
		this.getContainer().getActor().getFlags().add("legion_can_command");  //justfies if this background is subject to the legion command skill
	}

	function adjustHiringCostBasedOnEquipment() //reduces cost for equipment worn on skeletons to zero for recruiting purposes.
	{
		local actor = this.getContainer().getActor();
		actor.m.HiringCost = this.Math.floor(this.m.HiringCost + 500 * this.Math.pow(this.m.Level - 1, 1.5));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/throwing_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/ancient/legend_gladius"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/ancient/legend_kopis"));
		}

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 66)
			{
				items.equip(this.new("scripts/items/tools/throwing_net"));
			}
			else
			{
				items.equip(this.new("scripts/items/shields/ancient/tower_shield"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[1, ::Legends.Armor.Standard.indebted_armor_rags],
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_gladiator_helmet]
		]));
	}
});
