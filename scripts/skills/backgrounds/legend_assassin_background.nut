this.legend_assassin_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_assassin";
		this.m.Name = "Assassin";
		this.m.BackgroundDescription = "This character\'s history is a secret";
		this.m.GoodEnding = "After leaving %companyname%, %name% was never heard from again. %name%\'s calling card has been found near a few accidents, so you believe the assassin is doing well.";
		this.m.BadEnding = "After leaving %companyname%, %name% was never heard from again. There are rumours that a rival assassin was hunting %name%, but no one has heard anything from either of them.";
		this.m.Icon = "ui/backgrounds/background_53.png";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 30;
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
				::Legends.Perk.Adrenaline,
				::Legends.Perk.Recover,
				::Legends.Perk.FastAdaption,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.CripplingStrikes,
				::Legends.Perk.LegendBackToBasics,
				::Legends.Perk.Colossus,
				::Legends.Perk.NineLives,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.LegendAlert
			],
			[
				::Legends.Perk.QuickHands,
				::Legends.Perk.Dodge,
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Bullseye,
				::Legends.Perk.HoldOut,
				::Legends.Perk.LegendChoke,
				// ::Legends.Perk.LegendComposure,
				::Legends.Perk.DevastatingStrikes,
				::Legends.Perk.LegendFavouredEnemyCaravan,
				::Legends.Perk.LegendFavouredEnemyBandit
			],
			[
				::Legends.Perk.Anticipation,
				::Legends.Perk.Rotation,
				::Legends.Perk.LegendFeint,
				::Legends.Perk.Backstabber,
				::Legends.Perk.LegendDebilitate,
				::Legends.Perk.LegendOnslaught,
				::Legends.Perk.LegendGrapple,
				::Legends.Perk.LegendTrueBeliever,
				::Legends.Perk.LegendPrepareBleed,
				::Legends.Perk.LegendEscapeArtist,
				::Legends.Perk.LegendAthlete

			],
			[
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecSword,
				::Legends.Perk.SpecPolearm,
				::Legends.Perk.SpecBow,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.SpecCrossbow,
				::Legends.Perk.LegendSpecUnarmed,
				::Legends.Perk.LegendSpecPoison
			],
			[
				::Legends.Perk.LoneWolf,
				::Legends.Perk.Footwork,
				::Legends.Perk.Overwhelm,
				::Legends.Perk.LegendVengeance,
				::Legends.Perk.LegendLithe,
				::Legends.Perk.LegendPushTheAdvantage,
				::Legends.Perk.LegendBlendIn,
				::Legends.Perk.LegendFavouredEnemyMercenary,
				::Legends.Perk.LegendFavouredEnemyNoble
			],
			[
				::Legends.Perk.Berserk,
				::Legends.Perk.Underdog,
				::Legends.Perk.LegendBalance,
				::Legends.Perk.LegendClarity,
				::Legends.Perk.HeadHunter,
				::Legends.Perk.LegendEvasion,
				::Legends.Perk.LegendCarnage,
				::Legends.Perk.LegendPerfectFit,
				::Legends.Perk.LegendSecondWind
			],
			[
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.Duelist,
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendFreedomOfMovement,
				::Legends.Perk.LegendAssassinate,
				::Legends.Perk.LegendFavouredEnemySwordmaster,
				::Legends.Perk.LegendUnarmedTraining
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



	function onBuildDescription()
	{
		return "{This is your commander, when they die the company ends. This character has no history, any attempt to force discussion on it will only result in silence or lies.  }";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				5
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				10,
				10
			],
			MeleeDefense = [
				5,
				5
			],
			RangedDefense = [
				5,
				5
			],
			Initiative = [
				20,
				20
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
		local actor = this.getContainer().getActor();
		//this.m.Container.add(this.new("scripts/skills/perks/perk_legend_hidden"));
		::Legends.Traits.grant(this, ::Legends.Trait.Quick);
		//this.m.Container.add(this.new("scripts/skills/traits/loyal_trait"));
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.Initiative] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local stash = this.World.Assets.getStash();
		stash.removeByID("supplies.ground_grains");
		stash.removeByID("supplies.ground_grains");
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/rondel_dagger"));
		items.equip(this.Const.World.Common.pickArmor([
			[1, "thick_dark_tunic"]
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

});

