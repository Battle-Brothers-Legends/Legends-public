this.legend_lonewolf_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_lonewolf";
		this.m.Name = "Lone Wolf";
		this.m.Icon = "ui/backgrounds/background_lone_wolf.png";
		this.m.BackgroundDescription = "You\'ve come this far. Is it worth it? What are a few more heads on the pile in the pursuit of satisfaction?";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 0;
		this.m.DailyCost = 0; //Avatar
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.LegendFrail)
		];
		this.m.Titles = [ //More
			"the Lone Wolf",
			"the Wolf",
			"the Hyena",
			"the Hound",
			"Steelwielder",
			"the Slayer",
			"the Jouster",
			"the Giant",
			"the Mountain",
			"Butcher of %townname%",
			"the Defiler",
			"the Knightslayer",
			"the Hedge Knight"
		];

		this.m.Ethnicity = this.Math.rand(0, 2);
		if (this.m.Ethnicity == 0)
		{
			this.m.Bodies = this.Const.Bodies.Muscular;		
			this.m.Faces = this.Const.Faces.AllWhiteMale;
			this.m.Hairs = this.Const.Hair.CommonMale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Beards = this.Const.Beards.All;
			this.m.BeardChance = 60;
		}	
		else if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.Gladiator;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2)
		{
			this.m.Bodies = this.Const.Bodies.AfricanGladiator;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Beards = this.Const.Beards.Southern;
			this.m.BeardChance = 60;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}

		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[3];
		
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.FlailTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.FistsTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.TrainedTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.MartyrTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree
			],
			Class = [],
			Magic = [
				this.Const.Perks.ImmortalMagicTree
			]
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Ethnicity = this.Math.rand(0, 2);
		if (this.m.Ethnicity == 0)
		{
			this.m.Faces = this.Const.Faces.AllWhiteFemale;
			this.m.Hairs = this.Const.Hair.AllFemale;
			this.m.HairColors = this.Const.HairColors.All;
			this.m.Bodies = this.Const.Bodies.AllFemale;
			this.m.Names = this.Const.Strings.CharacterNamesFemale;
		}	
		else if (this.m.Ethnicity == 1)
		{
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Young;
			this.m.Bodies = this.Const.Bodies.SouthernFemaleMuscular;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}
		else if (this.m.Ethnicity == 2)
		{
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Bodies = this.Const.Bodies.AfricanFemaleMuscular;
			this.m.Names = this.Const.Strings.SouthernNames;
			this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "{You\'ve come so far that you forgot where you came from and how it all started. Distant memories of gold grew into fame. But what point is fame and gold to those who are mortal? If you want to create a legacy you\'ll need to prove yourself first - but years spent alone training for battles that never came will make it hard for anyone to notice you outside of a tournament.}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				12,
				16
			],
			Bravery = [
				8,
				12
			],
			Stamina = [
				12,
				18
			],
			MeleeSkill = [
				10,
				14
			],
			RangedSkill = [
				10,
				16
			],
			MeleeDefense = [
				6,
				9 // nice
			],
			RangedDefense = [
				6,
				7
			],
			Initiative = [
				5,
				15
			]
		};
		return c;
	}


	function onAddEquipment() //chooses a weapon through starting event
	{
		// local items = this.getContainer().getActor().getItems();
		// local helm = this.getContainer().getActor().getItems();
		// // local r;

		// // r = this.Math.rand(0, 5);

		// // if (r == 0)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/legend_longsword"));
		// // }
		// // else if (r == 1)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/longsword"));
		// // }
		// // else if (r == 2)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/legend_infantry_axe"));
		// // }
		// // else if (r == 3)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/pike"));
		// // }
		// // else if (r == 4)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/warbrand"));
		// // }
		// // else if (r == 5)
		// // {
		// // 	items.equip(this.new("scripts/items/weapons/goedendag"));
		// // }

		// items.equip(this.Const.World.Common.pickArmor([
		// 	// [1, "mail_hauberk"],
		// 	// [1, "basic_mail_shirt"],
		// 	// [1, "scale_armor"],
		// 	// [1, "reinforced_mail_hauberk"],
		// 	[1, ""]
		// ]));

		// local helm = [
		// 	// [1, "nasal_helmet"],
		// 	// [1, "nasal_helmet_with_mail"],
		// 	// [1, "mail_coif"],
		// 	// [1, "bascinet_with_mail"],
		// 	[1, ""]
		// ];

		// // if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		// // {
		// // 	helm.push([1, "theamson_barbute_helmet"])
		// // }

		// // items.equip(this.Const.World.Common.pickHelmet(helm));
	}
});

