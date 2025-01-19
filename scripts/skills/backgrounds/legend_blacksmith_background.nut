this.legend_blacksmith_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_blacksmith";
		this.m.Name = "Blacksmith";
		this.m.Icon = "ui/backgrounds/blacksmith.png";
		this.m.BackgroundDescription = "Blacksmiths tend to be strong and are skilled at repairing equipment.";
		this.m.GoodEnding = "Perhaps one of the strongest men you\'ve ever met, %name% the blacksmith was a vital asset in the %companyname%, repairing both their own equipment and that of their comrades with practiced hands. With plenty of crowns stored, he retired from fighting and blacksmithing both. Last you heard he was living out their years comfortably on the coast.";
		this.m.BadEnding = "%name% the blacksmith was a strong and capable sellsword in the %companyname%. He held out until the bitter end, sticking with the company as it lurched from one disaster to the next. Perhaps, had he been born in a different time he would have gone on to do great things, making legendary weapons for regal kings. Instead, many wars, invasions, and plagues spreading across the land ultimately ensured %name% and many other talented men went to total waste.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 23;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),

		];
		this.m.Titles = [
			"Iron-arm",
			"the Blacksmith",
			"the Bladesmith",
			"the Armorer",
			"the Hammer",
			"the Burly",
			"the Smith",
			"the Metalsmith"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.BackgroundType = this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Noble;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[3];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[3];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[3];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[3];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.HammerClassTree,
				this.Const.Perks.RepairClassTree
			],
			Magic = []
		}
	}

	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
 			//Female
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.m.Name = "Farrier";
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.Icon = "ui/backgrounds/blacksmith.png"; //keep the same otherwise people will get confused.
		this.m.BackgroundDescription = "Everyone needs shoes — and the same applies to four legs, not just two.";
		this.m.GoodEnding = "Perhaps one of the strongest men you\'ve ever met, %name% the blacksmith was a vital asset in the %companyname%, repairing both their own equipment and that of their comrades with practiced hands. With plenty of crowns stored, he retired from fighting and blacksmithing both. Last you heard he was living out their years comfortably on the coast.";
		this.m.BadEnding = "%name% the blacksmith was a strong and capable sellsword in the %companyname%. He held out until the bitter end, sticking with the company as it lurched from one disaster to the next. Perhaps, had he been born in a different time he would have gone on to do great things, making legendary weapons for regal kings. Instead, many wars, invasions, and plagues spreading across the land ultimately ensured %name% and many other talented men went to total waste.";
	}

	function onBuildDescription()
	{
		return "{Most every town has a resident blacksmith, | The local blacksmith is always an important person in the village, | Key to the success of any town is the skills of its resident blacksmith,} {%name% needed to repair tools of every kind and the equipment of the local militia. | Vital to the maintenance of sword and plow alike. | relied upon by the whole village for tools of every sort, from horseshoes to axes.} {%name%, learning from %their% father, was the resident blacksmith of %townname%. | Understanding this, %name% took up an apprenticeship in %randomtown% and, once having mastered the craft, settled down as the blacksmith of %townname%. | The son of one such blacksmith, %name% was forced into the profession by %their% overzealous father, though %they% cared little for it. | Hastily trained during a greenskin incursion, %name% eventually settled down as one such blacksmith, in %townname%. | %name% was one such blacksmith.}{Unfortunately, %name%\'s partner was killed in a freak accident. Unable to remain in %townname% any longer, %name% sold all they had and left, wandering aimlessly. Eventually they found %themselves% in the company of sellswords, where %their% strong arms and hammer accustomed hands drew great interest. | Feeling %their% years wear away, %name% was overcome by restlessness, and they decided to set out as a mercenary, where %their% strong arms could be of different use. | After many years %name% was nearly killed by greenskin raiders, escaping only by blind chance. Thoroughly shaken, %name% quit %their% job at the village, determined to learn all they could of warfare and battlecraft so that greenskins would never menace them again.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				9
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				15,
				20
			],
			MeleeSkill = [
				5,
				8
			],
			RangedSkill = [
				-10,
				-10
			],
			MeleeDefense = [
				0,
				3
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/legend_hammer"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "legend_blacksmith_apron"]
		]));
	}
})
