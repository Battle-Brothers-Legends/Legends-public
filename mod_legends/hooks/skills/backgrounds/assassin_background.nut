::mods_hookExactClass("skills/backgrounds/assassin_background", function(o)
{
	o.m.Tattoo <- 0;
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.assassin";
		this.m.Name = "Assassin";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.BackgroundDescription = "The same as any other mercenary, a skilled assassin can be hired for a good sum of crowns.";
		this.m.GoodEnding = "%name% joined the company in place of the bastard nobleman %they% had come to kill. So strange was this agreement that you kept your eye on the assassin for many days. But all %they% did was fight for the %companyname%, and fight well. Last you heard, the assassin departed the company and has not been seen or heard from since. You checked in on the bastard nobleman himself to see if perhaps the assassin had finished the job, but the man was alive and well. A peculiar run in, in the end.";
		this.m.BadEnding = "%name% joined the company in place of the bastard nobleman %they% had come to kill. So strange was this agreement that you kept your eye on the assassin for many days. But all %they% did was fight for the %companyname%, and fight well. Last you heard, the assassin departed the company not long after your hurried retirement. You decided to check in on %their% target the bastard nobleman only to find out that %they% had been slain by an unseen assassin. It appears %name% finished the job in the end.";
		this.m.HiringCost = 2000;
		this.m.DailyCost = 25;
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
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Pessimist),
			::Legends.Traits.getID(::Legends.Trait.Optimist),
			::Legends.Traits.getID(::Legends.Trait.ShortSighted),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Hesistant),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Fainthearthed),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Dumb),
			::Legends.Traits.getID(::Legends.Trait.LegendPragmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable)
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"the Assassin",
			"the Silent",
			"the Rogue",
			"the Sly"
		];

		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.Level = this.Math.rand(2, 5);
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Combat | this.Const.BackgroundType.Ranger;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.DaggerTree,
				this.Const.Perks.PolearmTree,
				this.Const.Perks.CrossbowTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.LightArmorTree,
				this.Const.Perks.ClothArmorTree
			],
			Traits = [
				this.Const.Perks.FitTree,
				this.Const.Perks.CalmTree,
				this.Const.Perks.AgileTree,
				this.Const.Perks.ViciousTree
			],
			Enemy = [
				this.Const.Perks.SwordmastersTree,
				this.Const.Perks.NoblesTree,
				this.Const.Perks.MercenaryTree
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

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.FemaleSkinny;
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
		return "{%name% likes %their% hoods and loose robes, as %they% walks you can make out a barely audible jingle under %their% coat. | %name% occasionally ducks into alleyways, bushes and dark doorways to exchange items with another figure in a flurry of hands as a predator would stash a fresh kill.} {Although shockingly average, %they% is much quieter than the other recruits you have had the displeasure of meeting. | %name% naturally gravitates to dark corners as rats would to grain and insists that %they% is very famous in certain circles, however %they% quickly changes the subject when you ask %them% for details.} {%They% is often lost in the maddening throng of the towns and hamlets dotted around the countryside - never have you met such an average looking mercenary who also doesn’t hesitate to slit the throat of the nearest man if it would so benefit %them%, even if %they% does grumble when travelling during daylight.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				-3,
				-0
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
				10,
				12
			],
			RangedSkill = [
				5,
				5
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				20,
				30
			]
		};
		return c;
	}

	o.onSetAppearance <- function ()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
		this.m.Tattoo = this.Math.rand(0, 1);
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(this.m.Tattoo == 0 ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
	}

	o.updateAppearance <- function ()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	o.onAdded <- function ()
	{
		this.character_background.onAdded();
		::Legends.Traits.grant(this, ::Legends.Trait.Quick);
	}

	o.onAddEquipment = function ()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.Initiative] = 2;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"]
		]))
	}

	o.onSerialize <- function ( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	o.onDeserialize <- function ( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

	o.onUpdate <- function ( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 10;
	}

});
