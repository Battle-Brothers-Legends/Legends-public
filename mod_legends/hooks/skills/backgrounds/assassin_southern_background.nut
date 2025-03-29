::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.assassin_southern";
		this.m.Name = "Hashassin";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.BackgroundDescription = "An assassin has to be quick on his feet and skilled with the use of weapons.";
		this.m.GoodEnding = "%name% the assassin departed the %companyname% with a large chest of gold and traveled far away. From what rumors you\'ve heard, he built a castle in the mountains east of the southern kingdoms. You\'re not sure if it\'s true, but there\'s been a steady increase in dead viziers and lords alike as of late.";
		this.m.BadEnding = "%name% disappeared not long after your retirement from the %companyname%. The assassin presumably does not want to be found and there\'s no telling where he is. In moments of honesty, you tell others you wished you never hired him at all. You just can\'t shake the terror that it is you he is stalking and hunting, and you spend many nights with one eye open, looking for the man in black with the crooked dagger.";
		this.m.HiringCost = 800;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Superstitious),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.LegendFearDark),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Bloodthirsty),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue
		];
		this.m.Titles = [
			"the Shadow",
			"the Assassin",
			"the Insidious",
			"the Backstabber",
			"the Unseen",
			"the Murderer",
			"the Dagger",
			"the Elusive"
		];
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.SouthernYoung;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Level = this.Math.rand(2, 5);
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.0, //plains
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
			0.02, // badlands
			0.0, //highlands
			0.04, //stepps
			0.0, //ocean
			0.05, //desert
			0.05 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.CleaverTree,
				this.Const.Perks.BowTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.CalmTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.CivilizationTree
			],
			Class = [],
			Magic = [
				this.Const.Perks.AssassinMagicTree
			]
		}
	}

	//Default Male
	o.setGender <- function (_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.GoodEnding = "%name% the assassin departed the %companyname% with a large chest of gold and traveled far away. From what rumors you\'ve heard, she built a castle in the mountains east of the southern kingdoms. You\'re not sure if it\'s true, but there\'s been a steady increase in dead viziers and lords alike as of late.";
		this.m.BadEnding = "%name% disappeared not long after your retirement from the %companyname%. The assassin presumably does not want to be found and there\'s no telling where she is. In moments of honesty, you tell others you wished you never hired her at all. You just can\'t shake the terror that it is you she is stalking and hunting, and you spend many nights with one eye open, looking for the woman in black with the crooked dagger.";
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);

	}

	o.getTooltip = function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()
	{
		if(this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			return "{You wouldn\'t think it at first, but %name% is like any other woman. Ordinary. Just an ordinary woman. | %name% looks almost like the mold of every woman you\'ve ever met put together. She has a face you\'d never remember. | %name% has a gentle smile and demeanor. She talks to all others as equals, weighing the opinions of wealthy and poor seemingly to measure herself between them. | %name% offers nothing with which to garner a second look. She is wholly simple, and wholly a woman meant to be a part of this world.} {Of course, this is by design. She is an assassin sent by a guild of trained killers. A scroll she carries suggests, without threat, that you take her under your employ. | This unassuming existence is a trained face for a woman who is, in actuality, a trained assassin carrying a one-of-a-kind Qatal dagger from her guild. | A bland face has a murderous past, though, for the woman carries a Qatal dagger given only to the best killers of one of the South\'s guild of assassins. | But the \'familiar stranger\' face is a put on, intended to hide the fact that she is a woman from a guild of assassins sent out for reasons you may never know.} {%name% could be standing right next to you, yet feel as though she\'s disappeared into a crowd of two. | Despite knowing you\'ve never met the woman until now, you can\'t help but feel you\'ve seen %name% somewhere before. | You naturally feel at ease around %name%, which almost feels like a setup in and of itself, so in turn you force yourself to stay alert around her instead.}";
		}
		else
		{
			return "{You wouldn\'t think it at first, but %name% like any other man. Ordinary. Just an ordinary man. | %name% looks almost like the mold of every man you\'ve ever met put together. He has a face you\'d never remember. | %name% has a gentle smile and demeanor. He talks to all others as equals, weighing the opinions of wealthy and poor seemingly to measure himself between them. | %name% offers nothing with which to garner a second look. He is wholly simple, and wholly a man meant to be a part of this world.} {Of course, this is by design. He is an assassin sent by a guild of trained killers. A scroll he carries suggests, without threat, that you take him under your employ. | This unassuming existence is a trained face for a man who is, in actuality, a trained assassin carrying a one-of-a-kind Qatal dagger from his guild. | A bland face has a murderous past, though, for the man carries a Qatal dagger given only to the best killers of one of the South\'s guild of assassins. | But the \'familiar stranger\' face is a put on, intended to hide the fact that he is a man from a guild of assassins sent out for reasons you may never know.} {%name% could be standing right next to you, yet feel as though he\'s disappeared into a crowd of two. | Despite knowing you\'ve never met the man until now, you can\'t help but feel you\'ve seen %name% somewhere before. | You naturally feel at ease around %name%, which almost feels like a setup in and of itself, so in turn you force yourself to stay alert around him instead.}";
		}

	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-5,
				-5
			],
			Bravery = [
				10,
				10
			],
			Stamina = [
				-5,
				-5
			],
			MeleeSkill = [
				6,
				8
			],
			RangedSkill = [
				10,
				14
			],
			MeleeDefense = [
				3,
				5
			],
			RangedDefense = [
				2,
				5
			],
			Initiative = [
				20,
				30
			]
		};
		return c;
	}

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/tools/smoke_bomb_item"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/tools/daze_bomb_item"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, "oriental/thick_nomad_robe"],
			[1, "oriental/assassin_robe"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "oriental/assassin_head_wrap"]
		]))
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}
});
