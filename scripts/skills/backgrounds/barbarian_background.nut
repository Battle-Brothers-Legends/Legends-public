this.barbarian_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.barbarian";
		this.m.Name = "Barbarian";
		this.m.Icon = "ui/backgrounds/background_58.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the barbarian took all the coin he earned with the company and ventured north. With his money, he gathered a band of warriors and conquered so many tribes that, last you heard, he had been ordained \'king of the north\'.";
		this.m.BadEnding = "With things the way they were, %name% departed. Last you heard he was traveling north. Penniless with little to his name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to his ilk, he\'s either been killed already or captured as a slave.";
		this.m.HiringCost = 200;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Titles = this.Const.Strings.BarbarianTitles;
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.Body = "bust_naked_body_01";
		this.m.IsFemaleBackground = false;

		if (this.Const.LegendMod.Configs.LegendGenderEnabled())
		{
			local r = this.Math.rand(0, 1);
			if (r == 0)
			{
				this.m.Faces = this.Const.Faces.AllFemale;
				this.m.Hairs = this.Const.Hair.WildMale;
				this.m.HairColors = this.Const.HairColors.All;
				this.m.Beards = null;
				this.m.BeardChance = 0;
				this.m.Body = "bust_naked_body_03";
				this.m.IsFemaleBackground = true;
				this.m.GoodEnding = "%name% the barbarian took all the coin she earned with the company and ventured north. With her money, she gathered a band of warriors and conquered so many tribes that, last you heard, she had been ordained \'queen of the north\'.";
				this.m.BadEnding = "With things the way they were, %name% departed. Last you heard she was traveling north. Penniless with little to her name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to her ilk, she\'s either been killed already or captured as a slave.";
			}
		}

		this.m.Level = this.Math.rand(2, 4);
		this.m.IsCombatBackground = true;
		this.m.IsOutlawBackground = true;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.GreatSwordTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.SturdyTree,
				this.Const.Perks.FitTree
			],
			Enemy = [
				this.Const.Perks.CaravanTree,
				this.Const.Perks.NoblesTree
				],
			Class = [],
			Magic = []
		}
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		if (this.m.IsFemaleBackground == true)
		{
			return "{%name% survived the battle between yourself and her own tribe of warriors. She offered herself to your company or to your sword. Impressed by his bravery, you chose to take her in. A foreign brute, she hardly speaks your native tongue and she is not well liked by the rest of the company. But if anything can bond two people it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
		}
		else
		{
			return "{%name% survived the battle between yourself and his own tribe of warriors. He offered himself to your company or to your sword. Impressed by his bravery, you chose to take him in. A foreign brute, he hardly speaks your native tongue and he is not well liked by the rest of the company. But if anything can bond two men it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
		}
	}

	function onAdded()
	{
		if (this.m.IsNew && this.m.IsFemaleBackground == false)
		{
			this.getContainer().getActor().setName(this.Const.Strings.BarbarianNames[this.Math.rand(0, this.Const.Strings.BarbarianNames.len() - 1)]);
		}
		if (this.m.IsNew && this.m.IsFemaleBackground == true)
		{
			this.getContainer().getActor().setName(this.Const.Strings.CharacterNamesFemaleNorse[this.Math.rand(0, this.Const.Strings.CharacterNamesFemaleNorse.len() - 1)]);
		}

		this.character_background.onAdded();
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Tattoo = tattoos[this.Math.rand(0, tattoos.len() - 1)];
			local tattoo_body = actor.getSprite("tattoo_body");
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_head = actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
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
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				5
			],
			Bravery = [
				10,
				5
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				10,
				5
			],
			RangedSkill = [
				0,
				0
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
				5,
				10
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 3);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/barbarians/thick_furs_armor"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/barbarians/reinforced_animal_hide_armor"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/barbarians/hide_and_bone_armor"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/barbarians/scrap_metal_armor"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/leather_helmet"));
		}
	}

	function onAddLegendEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 3);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		local cloths = [
			[1, "cloth/legend_sackcloth"],
			[1, "cloth/legend_sackcloth_patched"],
			[1, "cloth/legend_sackcloth_tattered"]
		];
		local armor = this.Const.World.Common.pickLegendArmor(cloths)

		if (armor != null)
		{

			local plates = [
				[0, ""],
				[1, "plate/legend_thick_furs_armor"],
				[1, "plate/legend_animal_hide_armor"],
				[1, "plate/legend_hide_and_bone_armor"],
				[1, "plate/legend_reinforced_animal_hide_armor"],
				[1, "plate/legend_scrap_metal_armor"],
				[0, "plate/legend_rugged_scale_armor"],
				[0, "plate/legend_heavy_iron_armor"],
				[0, "plate/legend_thick_plated_barbarian_armor"]
			]
			local plate = this.Const.World.Common.pickLegendArmor(plates)
			if (plate != null)
			{
				armor.setUpgrade(plate)
			}

			items.equip(armor);
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/leather_helmet"));
		}
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});

