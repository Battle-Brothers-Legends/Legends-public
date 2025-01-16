this.mason_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.mason";
		this.m.Name = "Mason";
		this.m.Icon = "ui/backgrounds/background_17.png";
		this.m.BackgroundDescription = "A good mason is used to physical labor and studying to improve his craft.";
		this.m.GoodEnding = "Masonry has its own call, notably a call perfectly cut stones and impossible towers that defy the eye\'s ability to even shape them against the skies. %name% the mason returned to his old trade and, with all the money he\'d made with the %companyname%, he started a reputable business renowned for its ability to construct stone rooms that held the heat during winters and the cool during summers.";
		this.m.BadEnding = "The %companyname% continued to suffer losses long after you\'d left. More and more of the brothers departed the company, a good lot of them returning to old trades. %name% the mason was no different. Sadly, all the time spent fighting had destroyed any steadiness he had left. With hands that wouldn\'t stop shaking, he could no longer shape stones like he used to. Last you heard, he was hauling rocks as a daytaler instead of shaping them as a mason.";
		this.m.HiringCost = 90;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.BackgroundType = this.Const.BackgroundType.Educated;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.NeutralMax;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Salvage = this.Const.LegendMod.ResourceModifiers.Salvage[2];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.HammerTree,
				this.Const.Perks.MaceTree,
				this.Const.Perks.StaffTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.MediumArmorTree
			],
			Traits = [
				this.Const.Perks.AgileTree,
				this.Const.Perks.LargeTree,
				this.Const.Perks.IntelligentTree,
				this.Const.Perks.FitTree
			],
			Enemy = [],
			Class = [],
			Magic = []
		}
		this.m.Bodies = this.Const.Bodies.Skinny;
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip()
		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color] Experience Gain"
			}
		)
		return ret
	}

	function onBuildDescription()
	{
		return "{Growing up in %townname%, %name% spent his youth poring over construction books with earnest. | Raised by a guild of tradesmen, %name%\'s swift ascent through the field of masonry was of little surprise. | A student of %randomtown%\'s esteemed college, %name% graduated with great expectations, and even greater things yet to build. | With a bricklayer for a father, %name%\'s entrance into masonry was but the smallest of steps. | Amazed by the regal structures of church and state, %name% fell in love with masonry. | When %randomtown% was in dire need of defensive walls, %name% took to masonry like a very fortunately-timed natural.} {Unfortunately, his time as a mason was short-lived. A church he built collapsed and out of its ruins rose a murderous mob looking for revenge. | Five buildings built, five buildings knocked down. Endless wars made the man\'s vocation an impossible one. | Betrayed by a fellow architect, the mason bricked his rival inside the walls of his next project. It wasn\'t long until people started asking questions. | While roofing, the man took a misstep and fell. The ensuing injuries forced him out of his field. | But when a lord demanded he build a horrific dungeon, the mason refused. Now he is banished from ever laying a brick again. | A misplaced blueprint had the mason building the temple of the Davkulians and not the temple of the Davkuliads. Now he says the gods themselves are after him.} {Putting down his hammer and chisel for a hammer and sharpened chisel called a sword, %name% now works in the field of mercenaries. | One day, a poster for a mercenary troop caught his eye. Much like his old buildings, the rest is history. | Years of masonry made the man fit for a life of blood and mud. | %name% finds a flaw in every building he passes. Hopefully he can tune that annoying analysis to the battlefield.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				5,
				7
			],
			Stamina = [
				5,
				5
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

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.MasonTitles[this.Math.rand(0, this.Const.Strings.MasonTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, "linen_tunic"]
		]))
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.05;
	}

});

