
this.legend_ironmonger_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_ironmonger";
		this.m.Name = "Ironmonger";
		this.m.Icon = "ui/backgrounds/ironmonger.png";
		this.m.BackgroundDescription = "Ironmongers are stronger than average and good at maintaining equipment.";
		this.m.GoodEnding = "A more reliable sellsword than most, %name%\'s background as an ironmonger helped him to keep the %companyname%\'s equipment functioning. Having saved more than enough crowns, %name% retired and returned to blacksmithing, learning from a true master and becoming a paragon of the craft. Last you heard of him he was living in luxury, making custom weapons and armor for nobles.";
		this.m.BadEnding = "%name% the ironmonger stayed with the %companyname% for some time after your departure, but after a particularly nasty stretch of bad luck he saw the rot for what it was and jumped ship. Bad luck seemed to follow him, however, and he never managed to settle down. He burned through his leftover crowns in a few years. He died in poverty one winter, freezing overnight.";
		this.m.HiringCost = 100;
		this.m.DailyCost = 11;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Fragile)

		];
		this.m.Titles = [
			"the Ironmonger",
			"the Metalsmith",
			"the Farrier",
			"the Scavenger",
			"the Iron-shaper",
			"the Scrounger"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Crusader;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Repair = this.Const.LegendMod.ResourceModifiers.Repair[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.LargeTree,
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

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "A more reliable sellsword than most, %name%\'s background as an ironmonger helped her to keep the %companyname%\'s equipment functioning. Having saved more than enough crowns, %name% retired and returned to blacksmithing, learning from a true master and becoming a paragon of the craft. Last you heard of her she was living in luxury, making custom weapons and armor for nobles.";
		this.m.BadEnding = "%name% the ironmonger stayed with the %companyname% for some time after your departure, but after a particularly nasty stretch of bad luck she saw the rot for what it was and jumped ship. Bad luck seemed to follow her, however, and she never managed to settle down. She burned through her leftover crowns in a few years. She died in poverty one winter, freezing overnight.";

	}

	function onBuildDescription()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{When one needs tools repaired but cannot afford a blacksmith, they seek out their local ironmonger. | A self taught smith working from scrap metal, the ironmonger works mostly with farm tools and horseshoes.} {No ironmonger can compare to the skills of a full fledged blacksmith, but it can be a lucrative profession in smaller villages. | Though lacking the skills of a fully trained blacksmith, ironmongers are vital for some settlements, too small or remote to merit a resident blacksmith.} {%name% was an ironmonger in %townname%. | %name% served for many years as an ironmonger in %townname%. | %name% was an ironmonger, like her father. | Urged by her parents to join the craft, %name% was an ironmonger for many years. | Not to be outdone by her overachieving militia sister, %name% learned to smith and served as the local ironmonger.} {Unfortunately, a trained blacksmith arrived in town, and %name%\'s skills were quickly rendered obsolete. Facing poverty, she left home to join a company of sellswords. | %name%\'s clients eventually dried up, and she was forced to leave home and seek new work. | %name% eventually left home due to a tragedy that she refused to speak of. Face grim, she seeks new employment.}";
		}
		else
		{
			return "{When one needs tools repaired but cannot afford a blacksmith, they seek out their local ironmonger. | A self taught smith working from scrap metal, the ironmonger works mostly with farm tools and horseshoes.} {No ironmonger can compare to the skills of a full fledged blacksmith, but it can be a lucrative profession in smaller villages. | Though lacking the skills of a fully trained blacksmith, ironmongers are vital for some settlements, too small or remote to merit a resident blacksmith.} {%name% was an ironmonger in %townname%. | %name% served for many years as an ironmonger in %townname%. | %name% was an ironmonger, like his father. | Urged by his parents to join the craft, %name% was an ironmonger for many years. | Not to be outdone by his overachieving militia brother, %name% learned to smith and served as the local ironmonger.} {Unfortunately, a trained blacksmith arrived in town, and %name%\'s skills were quickly rendered obsolete. Facing poverty, he left home to join a company of sellswords. | %name%\'s clients eventually dried up, and he was forced to leave home and seek new work. | %name% eventually left home due to a tragedy that he refused to speak of. Face grim, he seeks new employment.}";
		}

	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				5
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				2,
				3
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
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
		items.equip(this.Const.World.Common.pickArmor([
			[1, "apron"],
			[1, "linen_tunic"],
			[1, "leather_tunic"]
			//, [1, "legend_blacksmith_apron"]
		]));
	}

});
