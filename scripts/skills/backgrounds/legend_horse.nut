this.legend_horse <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Variant = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_horse";
		this.m.Name = "Horse";
		this.m.Icon = "ui/backgrounds/donkey.png";
		this.m.BackgroundDescription = "Horses are used to long and exhausting travels.";
		this.m.GoodEnding = "%name% the horse was retired to a lovely paddock and spent the days eating and carousing with other horses.";
		this.m.BadEnding = "%name% the horse was sold to a trader, their caravan was attacked by orcs and the remains of %name% were never found";
		this.m.HiringCost = 10000;
		this.m.DailyCost = 1;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		];
		this.m.Variant = this.Math.rand(1, 7);
		this.m.Faces = this.Const.Faces.Horse;
		this.m.Hairs = this.Const.Hair.None;
		this.m.HairColors = this.Const.HairColors.None;
		this.m.Bodies = this.Const.Bodies.Horses;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn | this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Stabled;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[3];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[4];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[4];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.05,//plains
			0.01, //swamp
			0.01, //hills
			0.01, //forest
			0.01, //forest
			0.01, //forest_leaves
			0.01, //autumn_forest
			0.01, //mountains
			0.0, // ?
			0.05, //farmland
			0.015, // snow
			0.015, // badlands
			0.015, //highlands
			0.05, //stepps
			0.0, //ocean
			0.01, //desert
			0.05 //oasis
		];
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

	function setAppearance(_tag = null)
	{
		local actor = this.getContainer().getActor();

		if (this.m.Faces != null)
		{
			local sprite = actor.getSprite("head");
			sprite.setBrush(this.m.Faces[this.m.Variant]);
			sprite.Color = this.createColor("#fbffff");
			sprite.varyColor(0.05, 0.05, 0.05);
			sprite.varySaturation(0.1);
			local body = actor.getSprite("body");
			body.Color = sprite.Color;
			body.Saturation = sprite.Saturation;
		}

		local body = this.m.Bodies[this.m.Variant];
		actor.getSprite("body").setBrush(body);
		actor.getSprite("injury_body").setBrush(body + "_injured");

		this.onSetAppearance();
	}

	function updateVariant()
	{
		local actor = this.getContainer().getActor();
		local body = this.m.Bodies[this.m.Variant];
		actor.getSprite("body").setBrush(body);
		actor.getSprite("injury_body").setBrush(body + "_injured");
	}



	function onBuildDescription()
	{
		return "{  %name% was raised to pull plows on a farm. |  %name% was reared by a traveling merchant. | A horses's life is tough %name% has been used for many things. | Though the work is dangerous, being a caravan horse allowed %name% to see the world. | When her former owner died, %name% was put up for sale. | Hardy and resolute, %name% was the pick of the bunch. | Sold from owner to owner %name% has worked for more caravans than most traders.} {But the trader she worked for turned out to be abusive, nary a whip away from being a slave driver. A farmer bought %name% to free her, but eventually the cost got too great and she was sold again. | One day, goods went missing and she was blamed for it, promptly ending her time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued. | Caravans are frequently attacked, and in one battle as the caravan hands fell %name% ran into the night. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a their caravan, it didn\'t take long for %name% to find a new owner. | But war deprived the caravan of stock and soon its driver took to selling the donkeys.  %name% was among the last to be sold. | Sadly, her caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for her life.} {Now %name% is being sold by a farmer for being too stubborn  | A horse like %name% is no stranger to danger, making her a good fit for any mercenary group. | With her caravan days behind her, working for a sellsword was just another avenue for oats. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just more carrots. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more horses like her.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				100,
				120
			],
			Bravery = [
				0,
				0
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
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHorseKick);
		::Legends.Traits.grant(this, ::Legends.Trait.LegendHorse);
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Variant);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Variant = _in.readU8();
		this.updateVariant();

	}
});
