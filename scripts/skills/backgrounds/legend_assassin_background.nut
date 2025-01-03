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
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_beasts",
			"trait.hate_undead",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.clubfooted",
			"trait.fat",
			"trait.tiny",
			"trait.gluttonous",
			"trait.pessimist",
			"trait.optimist",
			"trait.short_sighted",
			"trait.dexterous",
			"trait.insecure",
			"trait.hesitant",
			"trait.asthmatic",
			"trait.greedy",
			"trait.fragile",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.bright",
			"trait.cocky",
			"trait.dastard",
			"trait.drunkard",
			"trait.disloyal",
			"trait.loyal",
			"trait.dumb",
			"trait.legend_pragmatic",
			"trait.legend_predictable"
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
				this.Const.Perks.PerkDefs.Adrenaline,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.FastAdaption,
				this.Const.Perks.PerkDefs.BagsAndBelts,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.CripplingStrikes,
				this.Const.Perks.PerkDefs.LegendBackToBasics,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.LegendAlert
			],
			[
				this.Const.Perks.PerkDefs.QuickHands,
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.CoupDeGrace,
				this.Const.Perks.PerkDefs.Bullseye,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendChoke,
				// this.Const.Perks.PerkDefs.LegendComposure,
				this.Const.Perks.PerkDefs.DevastatingStrikes,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyBandit
			],
			[
				this.Const.Perks.PerkDefs.Anticipation,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.LegendFeint,
				this.Const.Perks.PerkDefs.Backstabber,
				this.Const.Perks.PerkDefs.LegendDebilitate,
				this.Const.Perks.PerkDefs.LegendOnslaught,
				this.Const.Perks.PerkDefs.LegendGrapple,
				this.Const.Perks.PerkDefs.LegendTrueBeliever,
				this.Const.Perks.PerkDefs.LegendPrepareBleed,
				this.Const.Perks.PerkDefs.LegendEscapeArtist,
				this.Const.Perks.PerkDefs.LegendAthlete

			],
			[
				this.Const.Perks.PerkDefs.SpecDagger,
				this.Const.Perks.PerkDefs.SpecSword,
				this.Const.Perks.PerkDefs.SpecPolearm,
				this.Const.Perks.PerkDefs.SpecBow,
				this.Const.Perks.PerkDefs.SpecThrowing,
				this.Const.Perks.PerkDefs.SpecCrossbow,
				this.Const.Perks.PerkDefs.LegendSpecFists,
				this.Const.Perks.PerkDefs.LegendSpecPoison
			],
			[
				this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.Footwork,
				this.Const.Perks.PerkDefs.Overwhelm,
				this.Const.Perks.PerkDefs.LegendVengeance,
				this.Const.Perks.PerkDefs.LegendLithe,
				this.Const.Perks.PerkDefs.LegendPushTheAdvantage,
				this.Const.Perks.PerkDefs.LegendBlendIn,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyMercenary,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyNoble
			],
			[
				this.Const.Perks.PerkDefs.Berserk,
				this.Const.Perks.PerkDefs.Underdog,
				this.Const.Perks.PerkDefs.LegendBalance,
				this.Const.Perks.PerkDefs.LegendClarity,
				this.Const.Perks.PerkDefs.HeadHunter,
				this.Const.Perks.PerkDefs.LegendEvasion,
				this.Const.Perks.PerkDefs.LegendCarnage,
				this.Const.Perks.PerkDefs.LegendPerfectFit,
				this.Const.Perks.PerkDefs.LegendSecondWind
			],
			[
				this.Const.Perks.PerkDefs.KillingFrenzy,
				this.Const.Perks.PerkDefs.Duelist,
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.LegendFreedomOfMovement,
				this.Const.Perks.PerkDefs.LegendAssassinate,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster
				this.Const.Perks.PerkDefs.LegendUnarmedTraining
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
		this.m.Container.add(this.new("scripts/skills/traits/quick_trait"));
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

