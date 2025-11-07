this.legend_legion_slave_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_slave";
		this.m.Name = "Servus";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "Taken from a distant land lost to time, this slave still fights for their household.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue,
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
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		// this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[4]; // 5, 8, 13, 21, 34, 55
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.05, //plains
				0.01, //swamp
				0.02, //hills
				0.03, //forest
				0.03, //forest
				0.03, //forest_leaves
				0.03, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.05, //farmland
				0.02, //snow
				0.02, //badlands
				0.02, //highlands
				0.02, //stepps
				0.0, //ocean
				0.05, //desert
				0.05 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.CleaverTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.BeastClassTree,
				this.Const.Perks.SlingClassTree
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
		// this.m.LastNames = this.Const.Strings.AncientDeadTitles;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription() //—
	{
		return "{%name% hunches and hobbles along as though their bone frame was still burdened by calloused flesh and aching muscles. | %name% appears oblivious to their undeath, limping and lamenting their station, ever fearful of their superiors overhearing and adding to their misfortunes. | Wearing the scars of decades of servitude at the bottom of the Legion, %name%\'s bony frame threatens to crumble under the weight of more orders. | March. Dig. Cook. Build. March. Kill. March. The endless labours of %name% persist even in the face of their undeath. | With a bony frame that portrays weakness and years of backbreaking work even after death, %name% shuffles with a stiffness that betrays their battered state.} {A slave in the Legion, their station affords them an excessive regime of endless work. Digging trenches, stripping corpses, and making said corpses dominate the daily unlife of this walking cadaver. | Filling the disposable ranks of the Legion\'s many slaves, their work is dominated with manual and violent tasks to ensure the unimpeded task of the machine-like Legion. | As one of many faceless slaves within the Legion, they fill the role of the disposable body to throw at problems — fighting, carrying of supplies, and their eventual destruction are vital parts of their role. | Providing comforts to the rest of the Legion at the expense of their own, the work of a Legion slave is one of never-ending toil and torment. | The often unseen labour behind the Legion\'s frightening efficiency, the labouring slave shares no glory and wins no accolades for its success, but is first to suffer setbacks both on and off the battlefield.} {If %name%'s face had any flesh or human features left, it would betray unspeakable sadness and desperation in the face of their endless torment. Instead, a cold and hollow skull hides such inconveniences, only presenting as ready for more orders. | Despite their station, %name% wears a misplaced enthusiasm to serve and better their situation, tricked by their own delusion that eventually, their toils will end, and they will rise through the Legion as a respected figure. | Fearing the ever-present judgement of their betters, %name% toils with a fervour that threatens to break apart their fragile frame. | The resignation to their fate is clear in how %name% carries themself. Aware of their nature within the Legion\'s endless campaign, they seemingly await their destruction to return them to the earth, were they so lucky. | Having spent little time in their station, the almost eager demeanour of %name% is likely to be short lived. With the weight of the Legion\'s endless orders upon their hollow shoulders, one must wonder how long they\'ll last before crumbling into dust...}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				-3,
				7
			],
			Bravery = [ //not needed except for resisting charm and sleep
				0,
				0
			],
			Stamina = [ //not needed except for equipment weight
				0,
				5
			],
			MeleeSkill = [
				-2,
				1
			],
			RangedSkill = [
				4,
				8
			],
			MeleeDefense = [
				-1,
				2
			],
			RangedDefense = [
				0,
				2
			],
			Initiative = [
				-4,
				3
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		if (this.m.IsNew) {
			::Legends.Traits.grant(this, ::Legends.Trait.LegendFleshless);
		}

		local actor = this.getContainer().getActor();
		actor.m.ExcludedInjuries = ::Legends.Legion.ExcludedInjures;
		actor.getFlags().add("legion_can_command");  //justfies if this background is subject to the Legion command skill
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
			[1, "weapons/ancient/broken_ancient_sword"],
			[1, "weapons/ancient/falx"],
			[1, "weapons/ancient/ancient_spear"],
			[1, "weapons/legend_dilapitated_sling"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			if (this.Math.rand(1, 100) <= 66)
				items.equip(this.new("scripts/items/shields/ancient/auxiliary_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.tattered_sackcloth],
			[2, ::Legends.Armor.Standard.leather_wraps],
			[3, ::Legends.Armor.Standard.indebted_armor_rags],
			[2, ::Legends.Armor.Ancient.ancient_ripped_cloth],
			[3, ::Legends.Armor.None]
		]));

		items.equip(::Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Ancient.ancient_household_helmet],
			[2, ::Legends.Helmet.None]
		]));
	}
});
