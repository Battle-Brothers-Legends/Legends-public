this.refugee_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.refugee";
		this.m.Name = "Refugee";
		this.m.Icon = "ui/backgrounds/background_38.png";
		//gender neutral descriptions
		this.m.BackgroundDescription = "Refugees lack the conviction to fight for their homes, but they are used to long and exhausting travel by now.";
		this.m.GoodEnding = "%name% the refugee proved to be a natural fighter, but eventually retired from the %companyname%. Word has it %name% returned home and is using the wealth gained in the company to help rebuild the town.";
		this.m.BadEnding = "With the downfall of the %companyname% written plainly on the wall, %name% the refugee split with the company. Using their remaining scant crowns to purchase a set of shoes and returned to a destroyed home, to try and rebuild it. While walking home, an illiterate wildman murdered %name% and ate the shoes.";
		this.m.HiringCost = 40;
		this.m.DailyCost = 4;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Impatient),
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendNatural)
		];
		this.m.Titles = [
			"the Refugee",
			"the Survivor",
			"Runsfar",
			"the Derelict",
			"the Surbated"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Ethnicity = 0;
			this.m.Faces = this.Const.Faces.AllWhiteMale;
			this.m.Hairs = this.Const.Hair.UntidyMale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Beards = this.Const.Beards.Untidy;
			this.m.Bodies = this.Const.Bodies.Skinny;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Untidy;
		}
		
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Merciless;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Good;
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.StaffTree,
				this.Const.Perks.SlingTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.IndestructibleTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.StaffClassTree
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
		this.m.Beards = null;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}



	function onBuildDescription()
	{
		//gender neutral description
		return "{Catastrophes are cheap. | Disease, the ultimate invisible hand. | Win or lose a war, everything is as it has been.} %name% hails from a tiny village that {is now only remembered by spoken word, a generation away from being forgotten. | was destroyed, to put it succinctly. | now stands as a mere footnote, wasting little of the historian\'s ink. | suffered the world\'s wrath.} But %name% is a survivor. {%name% fled the disaster with only clothes. | With home ablaze, %name% saved what little could be saved, and fled. | After stumbling upon their dead family, %name% gathered what could be saved and ran. | War, famine, disease. It\'s all a blur now.} {%name% is merely anxious to look ahead rather than behind. | %name% carries little more than a sense of steeled determination, but that is something worth having. | A horrific history scars %name%\'s body and glazes their eyes, but the mercenary is easily motivated to never experience that past again. | Whatever befell the %name%\'s town didn\'t get %name% and, judging by the rumors you hear, that\'s saying something. | %name% isn\'t skilled in martial arts, but is damn sure determined to survive. | Whatever vocation %name% had in the past is now lost. Like many others, seeking mercenary work to get by in this increasingly bloody world. | One of many refugees you\'ve seen, this victim has decided to stop running and start fighting.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				2
			],
			RangedDefense = [
				0,
				1
			],
			Initiative = [
				10,
				18
			]
		};
		return c;
	}


	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/legend_staff"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "tattered_sackcloth"],
			[1, "sackcloth"],
			[1, "legend_rabble_tunic"]
		]))
	}
});

