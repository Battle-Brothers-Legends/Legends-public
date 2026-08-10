::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		::Legends.Backgrounds.onCreate(::Legends.Background.AssassinSouthern);
		this.m.Name = "Hashassin";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.BackgroundDescription = "An assassin has to be quick on %their% feet and skilled with the use of weapons.";
		this.m.GoodEnding = "%name% the assassin departed the %companyname% with a large chest of gold and traveled far away. From what rumors you\'ve heard, %they% built a castle in the mountains east of the southern kingdoms. You\'re not sure if it\'s true, but there\'s been a steady increase in dead viziers and lords alike as of late.";
		this.m.BadEnding = "%name% disappeared not long after your retirement from the %companyname%. The assassin presumably does not want to be found and there\'s no telling where %they% is. In moments of honesty, you tell others you wished you never hired %them% at all. You just can\'t shake the terror that it is you %they% is stalking and hunting, and you spend many nights with one eye open, looking for the %person% in black with the crooked dagger.";
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.LegendFearNobles),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
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
		this.m.Ethnicity = 1;
		this.m.Level = this.Math.rand(2, 5);
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Outlaw;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.DaggerTree,
				::Const.Perks.CleaverTree,
				::Const.Perks.BowTree,
				::Const.Perks.ThrowingTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.ClothArmorTree
			],
			Traits = [
				::Const.Perks.CalmTree,
				::Const.Perks.FitTree,
				::Const.Perks.AgileTree,
				::Const.Perks.ViciousTree
			],
			Enemy = [
				::Const.Perks.CivilizationTree
			],
			Class = [],
			Profession = [],
			Magic = [
				::Const.Perks.AssassinMagicTree
			]
		}
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		_gender ? this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernFemale, Faces = ::Const.Faces.SouthernFemale, Hairs = ::Const.Hair.SouthernFemale, HairColors =::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Bodies = ::Const.Bodies.SouthernSkinny, Faces = ::Const.Faces.SouthernMale, Hairs = ::Const.Hair.SouthernMale, HairColors = ::Const.HairColors.SouthernYoung, Beards = ::Const.Beards.Southern}, 90);
	}

	o.getTooltip = function () {
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=%positive%]+10%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	o.onBuildDescription <- function ()	{
		return "{You wouldn\'t think it at first, but %name% is like any other %person%. Ordinary. Just an ordinary %person%. | %name% looks almost like the mold of every %person% you\'ve ever met put together. %They% has a face you\'d never remember. | %name% has a gentle smile and demeanor. %They% talks to all others as equals, weighing the opinions of wealthy and poor seemingly to measure %themselves% between them. | %name% offers nothing with which to garner a second look. %They% is wholly simple, and wholly a %person% meant to be a part of this world.} {Of course, this is by design. %They% is an assassin sent by a guild of trained killers. A scroll %they% carries suggests, without threat, that you take %them% under your employ. | This unassuming existence is a trained face for a %person% who is, in actuality, a trained assassin carrying a one-of-a-kind Qatal dagger from %their% guild. | A bland face has a murderous past, though, for the %person% carries a Qatal dagger given only to the best killers of one of the South\'s guild of assassins. | But the \'familiar stranger\' face is a put on, intended to hide the fact that she is a %person% from a guild of assassins sent out for reasons you may never know.} {%name% could be standing right next to you, yet feel as though %they're% disappeared into a crowd of two. | Despite knowing you\'ve never met the %person% until now, you can\'t help but feel you\'ve seen %name% somewhere before. | You naturally feel at ease around %name%, which almost feels like a setup in and of itself, so in turn you force yourself to stay alert around %them% instead.}";
	}

	o.onChangeAttributes = function ()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.AssassinSouthern);
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
			[1, ::Legends.Armor.Southern.thick_nomad_robe],
			[1, ::Legends.Armor.Southern.assassin_robe]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Southern.assassin_head_wrap]
		]))
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}
});
