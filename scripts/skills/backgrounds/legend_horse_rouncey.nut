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
			"trait.tiny",
			"trait.clubfooted",
			"trait.bright",
			"trait.asthmatic"
		];
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[3];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[4];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[4];

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
