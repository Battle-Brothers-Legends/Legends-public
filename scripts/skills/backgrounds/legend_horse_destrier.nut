this.legend_horse_destrier <- this.inherit("scripts/skills/backgrounds/legend_horse", {
	m = {},
	function create()
	{
		this.legend_horse.create();
		this.m.ID = "background.legend_horse_destrier";
		this.m.Name = "Destrier";
		this.m.BackgroundDescription = "Despite being so highly prized by fighting men they are also called Great Horses, not all knights can afford them over courser, and rare indeed is the non-Noble riding one";
		this.m.GoodEnding = "A marvel of a fighting horse, %name% the Destrier was retired to horse breeder, where he was treated lavishly as he helped father the next generation of living engines-of-war";
		this.m.BadEnding = "%name% the horse was sold to a trader, their caravan was attacked by orcs and the remains of %name% were never found";
		this.m.HiringCost = 55000;
		this.m.DailyCost = 1;
		this.m.Excluded = [
			"trait.tiny",
			"trait.clubfooted",
			"trait.bright",
			"trait.weasel",
			"trait.craven",
			"trait.ailing",
			"trait.clumsy",
			"trait.asthmatic",
			"trait.bleeder",
			"trait.fragile",
			"trait.insecure",
			"trait.fainthearted"
		];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];

		this.m.CustomPerkTree = [
				[
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Steadfast,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.Adrenaline,
				this.Const.Perks.PerkDefs.LegendHorseLongeing
			],
			[
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.LegendComposure,
				this.Const.Perks.PerkDefs.SteelBrow,
				this.Const.Perks.PerkDefs.LegendHorseLiberty,
				this.Const.Perks.PerkDefs.LegendHorseBitting,
				this.Const.Perks.PerkDefs.LegendHorseDesensitization
			],
			[
				this.Const.Perks.PerkDefs.Anticipation,
				this.Const.Perks.PerkDefs.Steadfast,
				this.Const.Perks.PerkDefs.LegendSprint,
				this.Const.Perks.PerkDefs.LegendOnslaught,
				this.Const.Perks.PerkDefs.LegendHorseCollection,
				this.Const.Perks.PerkDefs.LegendBackToBasics,
				this.Const.Perks.PerkDefs.LegendHorseCharge

			],
			[
				this.Const.Perks.PerkDefs.LegendEfficientPacking,
				this.Const.Perks.PerkDefs.LegendAmmoBinding,
				this.Const.Perks.PerkDefs.LegendMedPackages,
				this.Const.Perks.PerkDefs.LegendToolsDrawers,
				this.Const.Perks.PerkDefs.LegendHorseImpulsion,
				this.Const.Perks.PerkDefs.LegendHorseHippology
			],
			[
				this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.Underdog,
				this.Const.Perks.PerkDefs.Footwork,
				this.Const.Perks.PerkDefs.LegendHorseLegControl,
				this.Const.Perks.PerkDefs.LegendHorseLeadChange,
				this.Const.Perks.PerkDefs.LegendHorseParthianShot
			],
			[
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.LegendLastStand,
				this.Const.Perks.PerkDefs.LegendRebound,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.LegendMuscularity,
				this.Const.Perks.PerkDefs.LegendHorsePiaffe,
				this.Const.Perks.PerkDefs.LegendHorseTempiChange,
			],
			[
				this.Const.Perks.PerkDefs.Stalwart,
				this.Const.Perks.PerkDefs.LegendSkillfulStacking,
				this.Const.Perks.PerkDefs.LegendAmmoBundles,
				this.Const.Perks.PerkDefs.LegendMedIngredients,
				this.Const.Perks.PerkDefs.LegendToolsSpares,
				this.Const.Perks.PerkDefs.LegendHorseFlyingChange,
				this.Const.Perks.PerkDefs.LegendHorsePirouette,
				this.Const.Perks.PerkDefs.LegendHorsePassage
			],
			[],
			[],
			[],
			[]
		];
	}


	function onBuildDescription()
	{
		return "{%name% was raised to batter men into submission through sheer size and strength. |  %name% was reared by a skilled and rich horse breeder. | A Destrier's life is bloody, and %name% has trampled many men underneath his hooves. | Though the work is dangerous, being the steed of an infamous Robber Knight allowed %name% to see the world, and kill its people. | The size of a wagon and able to carry any man, %name%'s first owner paid a fortune to acquire him. | %name% carried his owner through many a both battle and tourney. | %name% was there when a cavalry charge broke the spine of a rampaging horde of Greenskins. | With an ornery streak a mile wide, %name% has cost many a stableboy their hand. | Rumors have swirled that %name% owner fed him on human flesh, though they never told to the owner's face. | While most horses would never dream of charging into battle and flee at the first sign of danger, not so for %name%. He seems to almost be gleeful when shattering humans beneath his weight. | When an errant lance-stroke hit his owner in the neck and killed him, %name% was taken as loot and put up for sale. | As useful as a Destrier is on the battlefield, they are of no use against an assassin's blade in the night, such as the one that claimed %name%'s prior owner. | Since then, %name% has bucked and trampled many a prospective owner, respecting only the strongest of riders. }";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				125,
				145
			],
			Bravery = [
				10,
				15
			],
			Stamina = [
				55,
				65
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				-20,
				-20
			],
			MeleeDefense = [
				10,
				10
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-5,
				-10
			]
		};
		return c;
	}


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);

	}

});
