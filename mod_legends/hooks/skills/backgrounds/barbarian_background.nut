::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o)
{
	o.m.Tattoo <- 0;
	o.create = function ()
	{
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.NeutralMin;
		this.character_background.create();
		this.m.ID = "background.barbarian";
		this.m.Name = "Barbarian";
		this.m.Icon = "ui/backgrounds/background_58.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "%name% the barbarian took all the coin he earned with the company and ventured north. With his money, he gathered a band of warriors and conquered so many tribes that, last you heard, he had been ordained \'king of the north\'.";
		this.m.BadEnding = "With things the way they were, %name% departed. Last you heard he was traveling north. Penniless with little to his name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to his ilk, he\'s either been killed already or captured as a slave.";
		this.m.HiringCost = 300;
		this.m.DailyCost = 30;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.LegendFrail),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive)
		];
		this.m.Titles = this.Const.Strings.BarbarianTitles;
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.Ethnicity = 0;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Notorious;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Druid | this.Const.BackgroundType.ExpertHunter;
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Hunting = this.Const.LegendMod.ResourceModifiers.Hunting[2];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0,//plains
			0.00, //swamp
			0.00, //hills
			0.05, //forest
			0.05, //forest
			0.01, //forest_leaves
			0.01, //autumn_forest
			0.0, //mountains
			0.0, // ?
			0.0, //farmland
			0.05, // snow
			0.00, // badlands
			0.05, //highlands
			0.0, //stepps
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.TwoHandedTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.HammerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree,
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
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "%name% the barbarian took all the coin she earned with the company and ventured north. With her money, she gathered a band of warriors and conquered so many tribes that, last you heard, she had been ordained \'queen of the north\'.";
		this.m.BadEnding = "With things the way they were, %name% departed. Last you heard she was traveling north. Penniless with little to her name but an axe, and not looking anything like the natives or speaking their tongue, you figure the barbarian did not get far. Based upon what you\'ve seen happen to her ilk, she\'s either been killed already or captured as a slave.";

	}


	o.onBuildDescription <- function ()
	{
		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{%name% survived the battle between yourself and her own tribe of warriors. She offered herself to your company or to your sword. Impressed by her bravery, you chose to take her in. A foreign brute, she hardly speaks your native tongue and she is not well liked by the rest of the company. But if anything can bond two people it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
		}
		else
		{
			return "{%name% survived the battle between yourself and his own tribe of warriors. He offered himself to your company or to your sword. Impressed by his bravery, you chose to take him in. A foreign brute, he hardly speaks your native tongue and he is not well liked by the rest of the company. But if anything can bond two men it is fighting beside one another, killing when it counts, and drinking the night away at the tavern.}";
		}
	}

	o.onSetAppearance = function ()
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

	o.updateAppearance = function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
		}
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				5,
				10
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				0,
				3
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

	o.onAddEquipment = function ()
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

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Barbarian.thick_furs_armor],
			[1, ::Legends.Armor.Barbarian.reinforced_animal_hide_armor],
			[1, ::Legends.Armor.Barbarian.hide_and_bone_armor],
			[1, ::Legends.Armor.Barbarian.scrap_metal_armor]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Barbarian.bear_headpiece],
			[1, ::Legends.Helmet.Barbarian.leather_headband],
			[1, ::Legends.Helmet.Barbarian.leather_helmet]
		]))
	}

	o.onSerialize = function ( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	o.onDeserialize = function ( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});
