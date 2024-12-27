this.nomad_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.nomad";
		this.m.Name = "Nomad";
		this.m.Icon = "ui/backgrounds/background_63.png";
		this.m.BackgroundDescription = "Any nomad that survived out in the desert will have some expertise in fighting.";
		this.m.GoodEnding = "The nomad %name% left the %companyname% a few months after yourself. %they% apparently traveled south and now leads what they\'re calling the \'City on Legs,\' a huge band of peoples that roam the deserts. It is apparently so rich and successful a society that the Viziers worry their own people will flock to it.";
		this.m.BadEnding = "You learned that %name% the nomad departed the company with the hope of finding new plains to roam. Apparently, %they% got the idea in %their% head that %they% would travel far to the north and land cozily with the barbarians there. To %their% credit, the barbarians and nomads share a similar lifestyle, culture, language, religion, laws, struggles, conflicts, and general appearances aside. The nomad was butchered almost instantly upon entrance to a barbarian encampment and %their% remains eaten in a warrior ritual.";
		this.m.HiringCost = 200;
		this.m.DailyCost = 28;
		this.m.Excluded = [
			"trait.superstitious",
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
		this.m.Titles = [
			"the Desert Raider",
			"of the Desert",
			"Son of the Desert",
			"the Desert Scourge",
			"the Scorpion",
			"the Nomad",
			"Redsands",
			"the Hyena",
			"the Hawk",
			"the Serpent",
			"the Free",
			"the Wanderer",
			"the Waylayer"
		];
		this.m.Ethnicity = this.Math.rand(1, 2);
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernMuscular;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
		}
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.Level = this.Math.rand(2, 4);
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Ranger | this.Const.BackgroundType.ExpertHunter;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.1,//plains
				0.0, //swamp
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
				0.1, //stepps
				0.0, //ocean
				0.1, //desert
				0.1 //oasis
			];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.BowTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.SlingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.DeviousTree
			],
			Enemy = [
				this.Const.Perks.SouthernersTree,
				this.Const.Perks.DirewolfTree,
				this.Const.Perks.ArcherTree
			],
			Class = [],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		if (this.m.Ethnicity == 1)
		{
			this.m.Faces = this.Const.Faces.SouthernFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.Young;
			this.m.Bodies = this.Const.Bodies.SouthernFemaleMuscular;
		}
		else
		{
			this.m.Faces = this.Const.Faces.AfricanFemale;
			this.m.Hairs = this.Const.Hair.SouthernFemale;
			this.m.HairColors = this.Const.HairColors.African;
			this.m.Bodies = this.Const.Bodies.AfricanFemaleMuscular;
		}

		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "{Like many southerners, %name% is someone who grew up in the desert, roaming the dunes and waylaying caravans and lost travelers alike. | Born into one of the South\'s many desert tribes, %name% learned the ways of the sands before they learned anything else. | Nomads pepper the southern deserts and it is in one of these roaming bands that %name% was born. | True nomads are a rare find in the cities of the south and %name% is no different. | You rarely see a nomad outside their element in the dunes of the southern sands, but %name% stands, darkly tanned and gritting %themself% again.} {However, nomadic politics are a mite complicated. Some event, which the nomad-turned-sellsword refuses to explain, ushered %them% into the cities looking for work. | A rule of %their% tribe is that every third son must travel out to see the world and, if they so wish, return. So, here %name% stands. | Accused of sexual impropriety with a woman not formally gifted to %them%, %name% was faced with execution or exile from the tribe. Their breathing and standing before you hints at which of the two they chose. | Having murdered one of their fellow tribesman over a gambling debt, the nomad was exiled from %their% tribe. | But a disastrous ambush, which they were responsible for planning, saw %them% voted out of their particular tribe. | But the nomad wished to see more of the world, to see %themself% as more than what %they% could muster within the confines of their tribe, and so they left and ventured to the cities for adventurous work.} {The nomad stands before you every bit of their upbringing: darkly toned, eyes black, hands sanded down. If they\'s not a warrior already, they presumably could be trained into one with time. | As a man of the unbearable sands of the south, it\'s no surprise that the nomad is physically ready to take on the tasks of sellswording. Whether the skills are there is another matter entirely. | Men who venture the desert wastes are a hardy lot and %name% is no different. | Nomads such as %name% earn most of their combat experience ambushing caravans. It could be of use in a mercenary band, though frontline work is a fair bit different than waylaying poor merchants. | %name% is every bit of the South as you expect: worn down by the sands, yet standing with the constitution of a man ready to take on the day and all those to come. | %name% is unlikely to be a trained and skilled fighter quite yet, but as a man of the southern wastes there is little doubt that they has the heart and spirit of a warrior.}";
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
				0,
				0
			],
			Bravery = [
				0,
				-3
			],
			Stamina = [
				2,
				0
			],
			MeleeSkill = [
				12,
				10
			],
			RangedSkill = [
				5,
				0
			],
			MeleeDefense = [
				6,
				5
			],
			RangedDefense = [
				6,
				5
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		this.m.Container.add(this.new("scripts/skills/perks/perk_legend_throw_sand"));
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/nomad_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/militia_spear"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/oriental/southern_light_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/nomad_robe"],
			[1, "oriental/thick_nomad_robe"],
			[1, "oriental/stitched_nomad_armor"],
			[1, "oriental/leather_nomad_robe"]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, "oriental/nomad_head_wrap"],
			[1, "oriental/nomad_leather_cap"],
			[1, "oriental/nomad_light_helmet"]
		]);
		items.equip(helm);
	}

});

