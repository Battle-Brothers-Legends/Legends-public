this.legend_youngblood_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_youngblood";
		this.m.Name = "Youngblood";
		this.m.Icon = "ui/backgrounds/background_youngblood.png";
		this.m.BackgroundDescription = "Youngbloods are students who have yet to prove themselves as capable witchhunters.";
		this.m.GoodEnding = "The time %name% spent in %companyname% was not something they were prepared for - for years they had learnt about the hidden horrors of the world in great detail, but seeing them come off the page and jump at them firsthand was an entirely new experience. Regardless, %they% thrived in their new practical studies and made a name for themselves, eventually retiring to a nameless hamlet of only a dozen people where they would take the occasional small contract to keep their skills sharp.";
		this.m.BadEnding = "%name% was a quick learner, but the divergence from theroy to practice posed great difficulty. Although they did not now it, %they% struggled keeping pace with %companyname% and left shortly after you did. On their first night they found shelter from the elements in what they thought was an old cave - only to find out too late that it was a safe haven for hemovores.";
		this.m.HiringCost = 95;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.FearGreenskins),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Drunkard)
		];
		this.m.Titles = [
			"the Learner",
			"Alp Slayer",
			"Hagbane",
			"the Fang Collector",
			"the Student",
			"the Young",
			"the Kid",
			"the Bright"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 2);

		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Educated;
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[1];
		this.m.Modifiers.Crafting = this.Const.LegendMod.ResourceModifiers.Crafting[1];
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Fletching = this.Const.LegendMod.ResourceModifiers.Fletching[1];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0, //plains
				0.015, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];

		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.VampireTree,
				this.Const.Perks.HexenTree,
				this.Const.Perks.AlpTree
			],
			Class = [
				this.Const.Perks.FaithClassTree,
				this.Const.Perks.ChefClassTree
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
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleMuscular;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve at morale checks against fear, panic or mind control effects and can craft wooden stakes for use against vampires"
			}
		);
		ret.push(
			{
				id = 14,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Experience Gain"
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		return "{%name% has always been a strange child, | %name% has had an odd upbringing, | %name% is a curious sort,} {so young but equally unswayed by the advances of either sex. | quiet and calculating, they often react indifferantly to the pulls of glory and gold. | often forgoing the basic needs of most mercenaries almost as a form of penance.} {A few years ago, %they% shadowed two older witchhunters who taught them how to hunt a variety of horrors. | Picked up from %townname% at a young age, %they% had a differant childhood to most. Other children heard about the horrors that would come for them while they sleep, %name% was told how to kill them. | When %randomtown% was sacked by the undead, %name% stood proud and using a sling managed to kill a dozen of the dead by sitting on a rooftop for several nights. | Led into the woods by %their% parents to die, %name% stumbled into an altercation involving a beasthunter and a witch, which started their reputation as a hag slayer. | At a yound age, %they% left home in the middle of the night to live in the woods, shortly after they were picked up by a hunting party of witchhunters who used them as bait for a witch. %name% never felt so alive.} {Unfortunately, %their% tutorship was cut short when an unknown force destroyed the order they had been training under. While not a fully fledged witchhunter, %they% can still become one of the best - given time. | Being suddenly awoken from a hard day of study and training by a raging fire, %name% fled the order\'s stronghold with a few other students - who were gradually picked off in the wilderness. | %name% was almost killed during the siege on the order\'s stronghold, narrowly escaping from the burning fire and crumbling towers.'}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				4,
				4
			],
			Bravery = [
				10,
				15
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				3,
				3
			],
			RangedSkill = [
				5,
				10
			],
			MeleeDefense = [
				0,
				4
			],
			RangedDefense = [
				0,
				4
			],
			Initiative = [
				5,
				8
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/legend_wooden_stake"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[2, "ragged_surcoat"],
			[2, "padded_leather"],
			[1, "leather_tunic"],
			[1, "padded_surcoat"],
			[1, "gambeson"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "full_aketon_cap"],
			[1, "aketon_cap"],
			[1, "open_leather_cap"],
			[2, ""]
		]))
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.05;
		_properties.MoraleCheckBravery[1] += 10;
	}

});
