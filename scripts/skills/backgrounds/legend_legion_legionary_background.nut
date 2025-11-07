this.legend_legion_legionary_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_legion_legionary";
		this.m.Name = "Legionary";
		this.m.Icon = "ui/backgrounds/background_puppet.png"; //to do
		this.m.BackgroundDescription = "The backbone of the Empire, the Legionary has seen horrors far and wide — and now travels those lands as one.";
		// this.m.GoodEnding = ""; //to do
		// this.m.BadEnding = ""; //to do
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
		this.m.Level = this.Math.rand(2, 3);
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		// this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.10, //plains
				0.05, //swamp
				0.06, //hills
				0.08, //forest
				0.08, //forest
				0.08, //forest_leaves
				0.08, //autumn_forest
				0.03, //mountains
				0.0, // ?
				0.10, //farmland
				0.07, //snow
				0.08, //badlands
				0.08, //highlands
				0.08, //stepps
				0.0, //ocean
				0.10, //desert
				0.10 //oasis
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
				this.Const.Perks.HeavyArmorTree,
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.SpearfisherClassTree,
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
		return "{Hailing from a long line of soldiers, %name% joined the Legion eager to serve the Emperor through force of arms. | With few prospects in civilian life, %name% turned to a career in the military as a rank and file soldier. After falling into the Legion, they have dedicated their new life to perfecting their martial skills in hopes of one day finding peace. | Having signed a short military contract to pay off debts, %name% found their service extended indefinitely upon being drafted into the Legion. While they still hope to one day complete their contract, for now- duty calls. | With a choice between punishment in a penal colony, or a shorter sentence in the Legion, %name% figured the latter would be safer and better for their personal growth. Wrong on both counts and bound by eternal service, the Legion is the only place they have left. | Found amongst an old battlefield by the Legion, %name% was all too eager to link up with their new unit upon hearing their mission. With new companions and a purpose renewed, they promise a strong presence in the ranks.} {Confidently filling the ranks of the fighting Legion, this legionary is well versed in formation fighting and sustained combat- through years of training, they're well equipped to deliver death to the Emperor's foes. | Killing men is this legionary's speciality, able to maintain pike ranks with relentless discipline and lead charges in shield formation. With men needing killing more than ever, the front might just be this legionary's best chance at it. | Between battles, the endless apparatus of the Legion is maintained by its many skilled troops. This legionary in particular assists in the logistics and camp works before whetting their blade on the Emperor's foes. | When orders are given, you need strong and devoted men to obey them. This legionary follows the call of duty without question, and is invaluable in any formation, whether protecting their comrades or slaying the enemy.} {Stoic and reserved, %name% dedicates what's left of their humanity to quiet reflection, and is often seen reflecting on the minutia of their daily observations. Whether they're still lucid enough to understand or appreciate them is another matter. | %name% brings a loud and haughty personality to the ranks that betrays a deep satisfaction in their station. While simple to some, they enjoy the honest routine that comes from their position. | Thriving on a diet of violence and honourable service, %name% relishes each encounter with the enemy as a fresh opportunity to see their foes vanquished and the Empire's glory bolstered. | %name% avoids their fellow soldiers when they can, muttering nonsense about the dead not staying dead. While peculiar at times, they remain a strong and loyal soldier to the Emperor. | Between the cynical mockery of their station and cheek often bordering on insubordinate, %name% is as devoted to the Emperor as they come, and is ready to lay down their life for their mission when the time comes.}";
	}

	function onChangeAttributes() //uses Character_background.nut template (Skeleton)
	{
		local c = {
			Hitpoints = [
				1,
				3
			],
			Bravery = [ //not needed except for resisting charm and sleep
				5,
				10
			],
			Stamina = [ //not needed except for equipment weight
				15,
				15
			],
			MeleeSkill = [
				2,
				5
			],
			RangedSkill = [
				5,
				9
			],
			MeleeDefense = [
				2,
				4
			],
			RangedDefense = [
				3,
				6
			],
			Initiative = [
				10,
				10
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
		actor.getFlags().add("legion_can_command");  //justfies if this background is subject to the legion command skill
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
			[1, "weapons/ancient/ancient_spear"],
			[1, "weapons/ancient/ancient_sword"],
			[1, "weapons/ancient/broken_ancient_sword"]
		], "scripts/items/"));

		if (items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null) {
			items.equip(::Const.World.Common.pickItem([
				[2, "shields/ancient/coffin_shield"],
				[1, "shields/ancient/tower_shield"]
			], "scripts/items/"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, ::Legends.Armor.Ancient.ancient_scale_harness],
			[2, ::Legends.Armor.Ancient.ancient_breastplate],
			[2, ::Legends.Armor.Ancient.ancient_mail],
			[1, ::Legends.Armor.Ancient.ancient_double_layer_mail]
			// [1, ::Legends.Armor.Ancient.ancient_plated_scale_hauberk],
			// [1, ::Legends.Armor.Ancient.ancient_scale_coat],
			// [1, ::Legends.Armor.Ancient.ancient_plate_harness],
			// [1, ::Legends.Armor.Ancient.ancient_plated_mail_hauberk]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, ::Legends.Helmet.Ancient.ancient_honorguard_helmet],
			[1, ::Legends.Helmet.None]
		]));
	}
});
