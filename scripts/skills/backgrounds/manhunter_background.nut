this.manhunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.manhunter";
		this.m.Name = "Manhunter";
		this.m.Icon = "ui/backgrounds/background_62.png";
		this.m.BackgroundDescription = "Manhunters are used to hunting down people in the rough environment of the south.";
		this.m.GoodEnding = "%name% the manhunter stuck with the %companyname% for a long while after you left it. You haven\'t gotten much word other than %name%\'s found far more income in the world of sellswords than that of hunting down the indebted.";
		this.m.BadEnding = "Upset with how time in the company of the %companyname% has gone, %name% the manhunter deserted and returned south. It\'s hard to say what became of the slaver, but the business of tracking and hunting human prey carries endless dangers. The only news you haveis ancillary to the vocation: that of numerous indebted uprisings with many manhunters being buried alive or fed to a variety of desert-borne creatures.";
		this.m.HiringCost = 120;
		this.m.DailyCost = 18;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.IronLungs),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople)
		];
		this.m.Titles = [
			"the Manhunter",
			"the Mancatcher",
			"the Hunter",
			"the Ruthless",
			"the Bounty Hunter",
			"the Brutal",
			"the Cruel",
			"the Unforgiving",
			"the Merciless",
			"the Tracker",
			"the Catcher",
			"the Heartless",
			"the Swine",
			"the Slaver"
		];
		this.m.Level = this.Math.rand(2, 4);
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.MaceTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.BowTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.ViciousTree,
				this.Const.Perks.DeviousTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.FastTree
			],
			Enemy = [
				this.Const.Perks.NomadsTree,
				this.Const.Perks.SouthernersTree,
				this.Const.Perks.BanditTree,
				this.Const.Perks.BarbarianTree
			],
			Class = [
				this.Const.Perks.BeastClassTree
			],
			Magic = []
		}
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function onBuildDescription()
	{
		return "{The large population of slaves, prisoners, criminals, and indebted servants in the south has produced an economy of sellers, buyers, and, given the flighty nature of the product, hunters. | Southern city states must have enormous reserves of labor to fuel their desert-borne economies. While many are born into working tirelessly for Viziers, some must be coerced into a life of servitude. | The deserts so sparse in natural resources, it is often an ample supply of captured criminals and indebted souls which bolsters the southern economy. And the business of hunting down these eventual servants is a prosperous one. | Southern Viziers are so fearful of rebellions that an entire market of Manhunters has emerged to nip them in the bud.} {%name% entered manhunting with a vengeful attitude: their entire family was massacred in a slave uprising. | %name% was once an ordinary caravan guard but turned to manhunting nomads who kept trying to ambush their convoys. Finding more profit in the human trade, %name%\'s stuck with it ever since. | %name% is a manhunter with a good nose for tracking criminals, deserters, prisoners of war, and more. You sometimes wonder if %name%\'s got a keen sense of smell for fearful sweat. | Once a big game hunter, %name% grew fond of chasing the greatest game of all: man. %name% is an expert tracker with a nose for sniffing out desperation.} {For %name%, the opportunity of working for a mercenary band simply brings in more consistent work than waiting around for some pressed criminal to get antsy about his chains. | %name% is a rugged, shady individual and it is quite possibly just as flighty as those being hunted. | Hunters like %name% carry traits and skills that would be useful in a mercenary band, but to some their past may be an ever present slight. Not all manhunters are seen in good light. | Capturing humans for the purpose of labor is frowned upon by many and catching those seeking their freedom equally so. Manhunters like %name% certainly have useful skills, but may rub some the wrong way. | To no surprise, many see slavers like %name% as opportunistic slugs. If %name% can make it with the company, it may take time to change the minds of some about the past.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				3,
				6
			],
			Bravery = [
				7,
				9
			],
			Stamina = [
				3,
				5
			],
			MeleeSkill = [
				8,
				12
			],
			RangedSkill = [
				7,
				14
			],
			MeleeDefense = [
				4,
				8
			],
			RangedDefense = [
				-1,
				-1
			],
			Initiative = [
				5,
				12
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/battle_whip"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/oriental/saif"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/nomad_robe"],
			[1, "oriental/thick_nomad_robe"]
		]));

		local helm = this.Const.World.Common.pickHelmet([
			[1, "oriental/southern_head_wrap"],
			[1, ""]
		]);
		items.equip(helm);
	}
});

