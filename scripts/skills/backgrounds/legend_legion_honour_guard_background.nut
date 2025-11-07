this.legend_legion_honour_guard_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_honour_guard"; //I don't care who they send, im not spelling it 'honor'.
		this.m.Name = "Honour Guard";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "A veteran of hundreds of battles, the honour guard is rewarded for their prowess with ever increasing danger.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0;
		this.m.Excluded = ::Legends.Legion.excludedTraits();

		this.m.ExcludedTalents = [
			// this.Const.Attributes.RangedSkill,
			//this.Const.Attributes.Hitpoints,
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
		this.m.Level = this.Math.rand(2, 4);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		// this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.13, //plains
				0.08, //swamp
				0.09, //hills
				0.11, //forest
				0.11, //forest
				0.11, //forest_leaves
				0.11, //autumn_forest
				0.06, //mountains
				0.0, // ?
				0.13, //farmland
				0.10, //snow
				0.11, //badlands
				0.11, //highlands
				0.11, //stepps
				0.0, //ocean
				0.13, //desert
				0.13 //oasis
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
				this.Const.Perks.CleaverTree,
				this.Const.Perks.OneHandedTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.LongswordClassTree,
				this.Const.Perks.ScytheClassTree
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

	function onBuildDescription()
	{
		return "{Decades of campaigning and violence have only cemented %name%'s reputation in the Legion as an avatar of war. Their very presence instils confidence in their troop's fighting odds. | Some %name% are born to grant others death. %name% answered this calling alongside his duty to the Emperor, and has carved a path through their many enemies, with little sign of stopping. | %name%'s war never ended. Found amongst a battlefield surrounded by felled foes, they were only too eager to take up arms again in service of the Emperor and his Legion. | %name% sought the Legion out on their own, having felt the call to serve the Emperor through honourable combat. Offered a prestigious position as one of the Legion's best, they stand as both shield and sword against the Empire's many enemies. | Few can compare to %name%'s martial prowess and imposing presence, even in death. Quickly proving their knack for violence, they secured a place in the Legion's honour guard.} {When the lines break, it inevitably falls to this honour guard to hold the line and salvage the day. Unmatched in close combat, they can be trusted to make any enemy pay in rivers of blood. | Perfectly suited to breaking enemy lines and reforming allied ones, this honour guard stands stalwart as a decisive actor on the battlefield. Enemies and allies alike fear their skill of arms. | When the day seems lost, it falls to an honour guard to turn the tide and achieve glory for the Empire. Masterfully applied violence and a feverish loyalty to the mission bolster the Legion's capabilities on and off the battlefield. | The perfect weapon in the Legion, this honour guard is the solution to throw at almost any problem that stands against the Emperor's will. Single-minded in violence, the Empire's enemies tremble at the very sight of this paragon of imperial martial excellence. | Violence made art. Killing made a science. This honour guard is no stranger to war, and can be relied upon to demonstrate the ancient mastery of imperial war to those in the Legion, and those who dare oppose it.} {Cold, reserved and unmistakably absent-minded in camp, %name%'s mind clearly lives on the battlefield. The lulls between battle seem only to send this agent of war into a placated stasis, awaiting the next call to action... | Death comes easy for some. %name% appears aware of their undeath, occasionally spotted admiring their skeletal form. Despite what some might consider horrific, they relish the opportunity to relive the art of killing. Again, and again, and again. | %name% relishes their new undead station in the Legion, eagerly flexing their status against their inferiors, and often failing to hide their glee for their curse of unlife. At least someone is having fun in death. | Bouts of confused stupors quickly give way to an unquestionable discipline practised and perfected over countless years. Though %name% is sometimes spotted pensive and disturbed by their undead company, the order to form ranks quickly sweeps such self-awareness away... | %name% lived and died and now lives again for the Legion. Eagerly taking up the opportunity to serve the Emperor once more, they vow never to never again fall in battle.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				3,
				6
			],
			Bravery = [ //not needed except for resisting charm and sleep
				10,
				15
			],
			Stamina = [ //not needed except for equipment weight
				20,
				20
			],
			MeleeSkill = [
				5,
				8
			],
			RangedSkill = [
				2,
				4
			],
			MeleeDefense = [
				4,
				7
			],
			RangedDefense = [
				1,
				2
			],
			Initiative = [
				-2,
				1
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
		actor.getFlags().add("legion_can_command"); //justfies if this background is subject to the legion command skill
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
			[1, "weapons/ancient/bladed_pike"],
			[1, "weapons/ancient/warscythe"],
			[1, "weapons/ancient/rhomphaia"],
			[1, "weapons/ancient/ancient_sword"],
			[1, "weapons/ancient/crypt_cleaver"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			items.equip(::Const.World.Common.pickItem([
				[2, "shields/ancient/coffin_shield"],
				[1, "shields/ancient/tower_shield"]
			], "scripts/items/"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			[1, ::Legends.Armor.Ancient.ancient_scale_coat],
			[2, ::Legends.Armor.Ancient.ancient_plate_harness],
			[1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Ancient.ancient_honorguard_helmet],
			[1, ::Legends.Helmet.None]
		]));
	}
});
