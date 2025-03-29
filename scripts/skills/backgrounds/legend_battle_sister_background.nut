this.legend_battle_sister_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_battle_sister";
		this.m.Name = "Battle Sister";
		this.m.Icon = "ui/backgrounds/background_26.png";
		this.m.BackgroundDescription = "Battle Sisters are warrior women trained by the inquisition to fight and destroy evil.";
		this.m.GoodEnding = "";
		this.m.BadEnding = "";
		this.m.HiringCost = 160; //currently cannot recruit battle sisters - will update in inq. origin update - Luft
		this.m.DailyCost = 18;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.Craven)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Initiative
		];	
		this.m.Faces = this.Const.Faces.OldFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.m.Level = this.Math.rand(1, 3);
		this.m.BackgroundType = this.Const.BackgroundType.OffendedByViolence | this.Const.BackgroundType.Crusader | this.Const.BackgroundType.Female;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Good;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.FlailTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.ShieldTree,
				this.Const.Perks.HammerTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.MartyrTree,
				this.Const.Perks.TrainedTree,
				this.Const.Perks.IndestructibleTree,
				this.Const.Perks.ViciousTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.SturdyTree
			],
			Enemy = [
				this.Const.Perks.ZombieTree,
				this.Const.Perks.SkeletonTree
			],
			Class = [
				this.Const.Perks.FaithClassTree
			],
			Magic = []
		}
	}



	function onBuildDescription()
	{
		return "{The gods pity men, spurring many, not unlike %name%, to seek their favor. | Illiterate and born to poverty, %name% found refuge in tales of the gods. | Always one to devour books, it wasn\'t long until %name% discovered texts of the gods. | Some say the gods speak to us and, if true, they definitely spoke to %name%. | With new cults springing up in the wilds, %name% returned to the familiarity of the gods. | Raised by their firebrand father, %name% spent much of their early years nursing wounds from good floggings. The gods would approve.} {When war came to the land, the gods told them to take part for greater justice. | As cultists spread their vile word like disease on a rat, %name% saw fit to take up arms and battle the heresy. | Straying from their faith, they committed a horrific crime in %randomtown% - finding company with a man. While flagellating himself nightly, he seeks redemption. | Hearing but a mere rumor of a holy place, the pilgrim took up staff and supplies to seek it out. | Now that war has returned to the land, the gods devotee wished to find out why, through prayer and corporeal means. | A night spent in a cave revealed to the believer that the gods demanded blood. %name% was not one to refuse their beckoning. | After raiders looted the coffers of their church, %name%\'s quest was to refill the pure purses.} {As the laws of the universe bend to a world-consuming war, a thaumaturge like %name% might be useful to have around. | They carry a whip with glass-barbed leather. This is not for your enemies, they state, but for purity. Interesting. | They profess to hate evil, but for a few crowns %name% can be persuaded to make anything \'evil\'. | This chosen one seeks the difficult road, no doubt why they saw fit to join a mercenary band. | If %name% had the power, you believe they\'d purge the entire world. | Talks of the gods might be a tad irksome, but %name%\'s fiery passion lends itself well to the battlefield. | So enamored with the world of the gods, it\'s not much of a surprise that the pilgrim sees the real one filled with enemies.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				7
			],
			Bravery = [
				14,
				18
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				6,
				10
			],
			RangedSkill = [
				-10,
				-5
			],
			MeleeDefense = [
				3,
				5
			],
			RangedDefense = [
				-5,
				0
			],
			Initiative = [
				5,
				10
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		this.updateAppearance();
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getSprite("body");
		local tattoo_body = actor.getSprite("tattoo_body");
		tattoo_body.setBrush("scar_01_" + body.getBrush().Name);
		tattoo_body.Color = body.Color;
		tattoo_body.Saturation = body.Saturation;
		tattoo_body.Visible = true;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.PilgrimTitles[this.Math.rand(0, this.Const.Strings.PilgrimTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = this.Math.rand(0, 3);
		if (r <= 2)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/shields/kite_shield"));
		}

		r = this.Math.rand(0, 5);
		if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/military_pick"));
		}
		else if (r == 5)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "reinforced_mail_hauberk"],
			[1, "worn_mail_shirt"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[2, "hood"],
			[2, "aketon_cap"],
			[1, "mail_coif"],
			[3, ""]
		]));
	}
});

