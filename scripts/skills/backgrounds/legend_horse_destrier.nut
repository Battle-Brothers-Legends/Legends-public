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
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Bleeder),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted)
		];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];

		this.m.CustomPerkTree = [
				[
				::Legends.Perk.Colossus,
				::Legends.Perk.NineLives,
				::Legends.Perk.Steadfast,
				::Legends.Perk.Recover,
				::Legends.Perk.Adrenaline,
				::Legends.Perk.LegendHorseLongeing
			],
			[
				::Legends.Perk.Dodge,
				::Legends.Perk.HoldOut,
				::Legends.Perk.LegendComposure,
				::Legends.Perk.SteelBrow,
				::Legends.Perk.LegendHorseLiberty,
				::Legends.Perk.LegendHorseBitting,
				::Legends.Perk.LegendHorseDesensitization
			],
			[
				::Legends.Perk.Anticipation,
				::Legends.Perk.Steadfast,
				// ::Legends.Perk.LegendSprint,
				::Legends.Perk.LegendOnslaught,
				::Legends.Perk.LegendHorseCollection,
				::Legends.Perk.LegendBackToBasics,
				::Legends.Perk.LegendHorseCharge

			],
			[
				::Legends.Perk.LegendEfficientPacking,
				::Legends.Perk.LegendAmmoBinding,
				::Legends.Perk.LegendMedPackages,
				::Legends.Perk.LegendToolsDrawers,
				::Legends.Perk.LegendHorseImpulsion,
				::Legends.Perk.LegendHippology
			],
			[
				::Legends.Perk.LoneWolf,
				::Legends.Perk.Underdog,
				::Legends.Perk.LegendHorseLegControl,
				::Legends.Perk.LegendHorseLeadChange,
				::Legends.Perk.LegendHorseParthianShot
			],
			[
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendLastStand,
				::Legends.Perk.LegendRebound,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.LegendMuscularity,
				::Legends.Perk.LegendHorsePiaffe,
				::Legends.Perk.LegendHorseTempiChange,
			],
			[
				::Legends.Perk.Stalwart,
				::Legends.Perk.LegendSkillfulStacking,
				::Legends.Perk.LegendAmmoBundles,
				::Legends.Perk.LegendMedIngredients,
				::Legends.Perk.LegendToolsSpares,
				::Legends.Perk.LegendHorseFlyingChange,
				::Legends.Perk.LegendHorsePirouette,
				::Legends.Perk.LegendHorsePassage
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
