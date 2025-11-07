this.legend_horse_rouncey <- this.inherit("scripts/skills/backgrounds/legend_horse", {
	m = {},
	function create()
	{
		this.legend_horse.create();
		this.m.ID = "background.legend_horse_rouncey";
		this.m.Name = "Rouncey";
		this.m.Icon = "ui/backgrounds/legend_horse.png";
		this.m.BackgroundDescription = "Rounceys are primarily packhorses used to long and exhausting travels, though they are able to be trained for battle";
		this.m.GoodEnding = "%name% the horse was retired to a lovely paddock and spent the days eating and carousing with other horses.";
		this.m.BadEnding = "%name% the horse was sold to a trader, their caravan was attacked by orcs and the remains of %name% were never found";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic)
		];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[3];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[4];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[4];

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
		return "{%name% was raised to pull plows on a farm. |  %name% was reared by a traveling merchant. | A workhorse's life is tough %name% has been used for many things. | Though the work is dangerous, being a packhorse for a caravan allowed %name% to see the world. | When her former owner died, %name% was put up for sale. | Sold from owner to owner %name% has worked for more caravans than most traders. s| But the trader she worked for turned out to be abusive, nary a whip away from being a slave driver. A farmer bought %name% to free her, but eventually the cost got too great and she was sold again. | One day, goods went missing and she was blamed for it, promptly ending her time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued. | Caravans are frequently attacked, and in one battle as the caravan hands fell %name% ran into the night. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a their caravan, it didn\'t take long for %name% to find a new owner. | But war deprived the caravan of stock and soon its driver took to selling the animals.  %name% was among the last to be sold. | Sadly, her caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for her life. | Now %name% is being sold by a farmer too deep in debt | With her caravan days behind her, working for a sellsword was just another avenue for oats. |  Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				100,
				120
			],
			Bravery = [
				-10,
				-10
			],
			Stamina = [
				40,
				50
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				-20,
				-20
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
				-10,
				-10
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);

	}

});
