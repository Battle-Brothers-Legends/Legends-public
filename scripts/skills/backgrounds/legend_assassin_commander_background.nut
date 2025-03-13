this.legend_assassin_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_assassin";
		this.m.Name = "Assassin";
		this.m.BackgroundDescription = "This character\'s history is a secret";
		this.m.GoodEnding = "After leaving %companyname%, %name% was never heard from again. %name%\'s calling card has been found near a few accidents, so you believe the assassin is doing well.";
		this.m.BadEnding = "After leaving %companyname%, %name% was never heard from again. There are rumours that a rival assassin was hunting %name%, but no one has heard anything from either of them.";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.HiringCost = 9999999;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Teamplayer),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.Paranoid),
			::Legends.Traits.getID(::Legends.Trait.NightBlind),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.LegendFearDark),
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
			::Legends.Traits.getID(::Legends.Trait.LegendPredictable)
		];
		this.m.Titles = [
			"the Assassin",
			"the Silent",
			"the Rogue",
			"the Sly"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Tidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;

		this.m.Level = 3;
		this.m.BackgroundType = this.Const.BackgroundType.Outlaw | this.Const.BackgroundType.Combat | this.Const.BackgroundType.Untalented;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[3];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.Pathfinder,
				::Legends.Perk.CripplingStrikes,
				::Legends.Perk.Adrenaline,
				::Legends.Perk.Recover,
				::Legends.Perk.FastAdaption,
				::Legends.Perk.LegendBackToBasics,
				::Legends.Perk.Colossus,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.LegendKnifeplay,
				::Legends.Perk.LegendAlert
			],
			[
				::Legends.Perk.Backstabber,
				::Legends.Perk.LegendAthlete,
				::Legends.Perk.DevastatingStrikes,
				::Legends.Perk.QuickHands,
				::Legends.Perk.Dodge,
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Bullseye,
				::Legends.Perk.HoldOut,
				::Legends.Perk.LegendOpportunist,
				::Legends.Perk.LegendFavouredEnemyCaravan
			],
			[
				::Legends.Perk.LegendBoondockBlade,
				::Legends.Perk.LegendHairSplitter,
				::Legends.Perk.LegendEscapeArtist,
				::Legends.Perk.LegendTrueBeliever,
				::Legends.Perk.Anticipation,
				::Legends.Perk.Rotation,
				::Legends.Perk.LegendFeint,
				::Legends.Perk.LegendDebilitate,
				::Legends.Perk.LegendOnslaught,
				::Legends.Perk.LegendPrepared,
				::Legends.Perk.LegendFavouredEnemyBandit
			],
			[
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecSword,
				::Legends.Perk.SpecPolearm,
				::Legends.Perk.SpecBow,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.SpecCrossbow,
				::Legends.Perk.LegendSpecPoison,
				::Legends.Perk.LegendLurker,
				::Legends.Perk.LegendFavouredEnemyMercenary
			],
			[
				::Legends.Perk.LegendPushTheAdvantage,
				::Legends.Perk.LegendDoubleStrike,
				::Legends.Perk.LegendEvasion,
				::Legends.Perk.LegendHeightenedReflexes,
				::Legends.Perk.LoneWolf,
				::Legends.Perk.Overwhelm,
				::Legends.Perk.LegendVengeance,
				::Legends.Perk.LegendLithe,
				::Legends.Perk.LegendFavouredEnemyNoble
			],
			[
				::Legends.Perk.LegendLeap,
				::Legends.Perk.LegendWindReader,
				::Legends.Perk.Berserk,
				::Legends.Perk.LegendBalance,
				::Legends.Perk.LegendClarity,
				::Legends.Perk.HeadHunter,
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendPerfectFit,
				::Legends.Perk.LegendNightRaider,
				::Legends.Perk.LegendSecondWind
			],
			[
				::Legends.Perk.LegendTumble,
				::Legends.Perk.LegendCloseCombatArcher,
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.Duelist,
				::Legends.Perk.LegendRebound,
				::Legends.Perk.BattleFlow,
				::Legends.Perk.LegendPerfectFocus,
				::Legends.Perk.LegendFreedomOfMovement,
				::Legends.Perk.LegendAssassinate,
				::Legends.Perk.LegendFavouredEnemySwordmaster
			]
		];
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;
		this.m.Faces = this.Const.Faces.PrettyFemale;
		this.m.Hairs = this.Const.Hair.AllFemale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push(
			{
				id = 11,
				type = "text",
				icon = "ui/icons/chance_to_hit_head.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Chance To Hit Head"
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		return "{As far as everyone is concerned, you have no history — any attempt to force discussion on it will only result in silence or lies.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				15,
				15
			],
			RangedSkill = [
				4,
				8
			],
			MeleeDefense = [
				8,
				12
			],
			RangedDefense = [
				8,
				12
			],
			Initiative = [
				15,
				15
			]
		};
		return c;
	}


	function onSetAppearance()
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

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	function onAdded()
	{
		this.character_background.onAdded();
		::Legends.Traits.grant(this, ::Legends.Trait.LegendAggressive);
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.RangedSkill] = 1;
		talents[this.Const.Attributes.Initiative] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);

		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/dagger"));
		items.addToBag(this.new("scripts/items/weapons/legend_slingshot"));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"],
			[1, "ragged_dark_surcoat"]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, "hood"]
		]));
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

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.HitChance[this.Const.BodyPart.Head] += 15; //normal buff is +10
	}

});

