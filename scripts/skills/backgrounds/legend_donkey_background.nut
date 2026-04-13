this.legend_donkey_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_donkey";
		this.m.Name = "Donkey";
		this.m.Icon = "ui/backgrounds/donkey.png";
		this.m.BackgroundDescription = "Caravan hands are used to long and exhausting travels.";
		this.m.GoodEnding = "%name% the donkey was retired to a lovely paddock and spent the days eating and carousing with other donkeys.";
		this.m.BadEnding = "%name% the donkey was sold to a trader, their caravan was attacked by orcs and the remains of %name% were never found";
		this.m.HiringCost = 5000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Addict),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.LegendAmbitious),
			::Legends.Traits.getID(::Legends.Trait.LegendSeductive),
			::Legends.Traits.getID(::Legends.Trait.LegendGiftOfPeople),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued),
			::Legends.Traits.getID(::Legends.Trait.LegendDeathlySpectre),
			::Legends.Traits.getID(::Legends.Trait.LegendSureshot),
			::Legends.Traits.getID(::Legends.Trait.Superstitious)
		];
		this.m.Faces = this.Const.Faces.Donkey;
		this.m.Hairs = this.Const.Hair.None;
		this.m.HairColors = this.Const.HairColors.None;
		this.m.Bodies = this.Const.Bodies.Donkeys;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Stabled;
		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[4];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[5];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[4];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[5];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill,
			this.Const.Attributes.RangedDefense,
			this.Const.Attributes.MeleeDefense
		];
		this.m.Modifiers.Terrain = [
			0.0, // ?
			0.0, //ocean
			0.025,//plains
			0.01, //swamp
			0.01, //hills
			0.01, //forest
			0.01, //forest
			0.01, //forest_leaves
			0.01, //autumn_forest
			0.01, //mountains
			0.0, // ?
			0.025, //farmland
			0.011, // snow
			0.015, // badlands
			0.015, //highlands
			0.025, //stepps
			0.0, //ocean
			0.01, //desert
			0.025 //oasis
		];
		this.m.CustomPerkTree = [
			[
				this.Legends.Perk.Colossus,
				this.Legends.Perk.NineLives,
				this.Legends.Perk.Pathfinder,
				this.Legends.Perk.Steadfast,
				this.Legends.Perk.BagsAndBelts,
				this.Legends.Perk.Recover
			],
			[
				this.Legends.Perk.Dodge,
				this.Legends.Perk.HoldOut,
				// this.Legends.Perk.LegendComposure,
				this.Legends.Perk.LegendAlert,
				this.Legends.Perk.LegendOnslaught,
				this.Legends.Perk.SteelBrow,
				this.Legends.Perk.LegendRecuperation
			],
			[
				this.Legends.Perk.Anticipation,
				this.Legends.Perk.Rotation,
				this.Legends.Perk.LegendPeaceful,
				this.Legends.Perk.Taunt,
				// this.Legends.Perk.LegendSprint
			],
			[
				this.Legends.Perk.LegendEfficientPacking,
				this.Legends.Perk.LegendAmmoBinding,
				this.Legends.Perk.LegendMedPackages,
				this.Legends.Perk.LegendToolsDrawers
			],
			[
				this.Legends.Perk.LoneWolf,
				this.Legends.Perk.Footwork,
				this.Legends.Perk.LegendLastStand,
				this.Legends.Perk.LegendBlendIn,
				this.Legends.Perk.Underdog
			],
			[
				this.Legends.Perk.Nimble,
				this.Legends.Perk.LegendRebound,
				this.Legends.Perk.LegendPacifist,
				this.Legends.Perk.LegendSkillfulStacking,
				this.Legends.Perk.LegendMuscularity,
			],
			[
				this.Legends.Perk.Fearsome,
				// this.Legends.Perk.Stalwart,
				this.Legends.Perk.LegendAmmoBundles,
				this.Legends.Perk.LegendMedIngredients,
				this.Legends.Perk.LegendToolsSpares,
			],
			[],
			[],
			[],
			[]
		];
	}

	//Default Male
	function setGender(_gender = -1)
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.addBackgroundType(this.Const.BackgroundType.Female);
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		local stashModifier = this.m.Modifiers.Stash + this.getModifier();

		ret.push(
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Donkeys provide [color=%positive%]+" + stashModifier + "[/color] stash space, [color=%positive%]+" + this.m.Modifiers.Ammo + "[/color] maximum ammunition storage, [color=%positive%]+" + this.m.Modifiers.Meds + "[/color] maximum medicine capacity,  [color=%positive%]+" + this.m.Modifiers.ArmorParts + "[/color] maximum armor parts. These can be increased with perks (may take a moment for the increases to register). "
			}
		);
		return ret;
	}

	function onBuildDescription()
	{
		return "{%name% was raised to pull plows on a farm. |  %name% was reared by a traveling merchant. | A donkey's life is tough %name% has been used for many things. | Though the work is dangerous, being a caravan donkey allowed %name% to see the world. | When her former owner died, %name% was put up for sale. | Hardy and resolute, %name% was the pick of the bunch. | Sold from owner to owner %name% has worked for more caravans than most traders.} {But the trader she worked for turned out to be abusive, nary a whip away from being a slave driver. A farmer bought %name% to free her, but eventually the cost got too great and she was sold again. | One day, goods went missing and she was blamed for it, promptly ending her time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued. | Caravans are frequently attacked, and in one battle as the caravan hands fell %name% ran into the night. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a their caravan, it didn\'t take long for %name% to find a new owner. | But war deprived the caravan of stock and soon its driver took to selling the donkeys.  %name% was among the last to be sold. | Sadly, her caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for her life.} {Now %name% is being sold by a farmer for being too stubborn  | A donkey like %name% is no stranger to danger, making her a good fit for any mercenary group. | With her caravan days behind her, working for a sellsword was just another avenue for oats. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just more carrots. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more donkeys like her.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				95,
				125
			],
			Bravery = [
				-5,
				0
			],
			Stamina = [
				50,
				75
			],
			MeleeSkill = [
				-10,
				4
			],
			RangedSkill = [
				-50,
				-50
			],
			MeleeDefense = [
				-7,
				-2
			],
			RangedDefense = [
				-5,
				-1
			],
			Initiative = [
				-15,
				-5
			]
		};
		return c;
	}

	function onUpdate(_properties)
	{
		if (::World.Assets.m.HasVeterinarian > 0)
		{
			_properties.HitpointsMult *= 1.25;
		}
	}

	function getModifier()
	{
		return ::World.Assets.m.HasVeterinarian > 0 ? 12 : 0;
	}

	function onAdded()
	{
		if (this.m.IsNew) {
			this.getContainer().getActor().getFlags().set("donkey", true);
			this.m.Container.add(this.new("scripts/skills/injury_permanent/legend_donkey_injury"));
			::Legends.Traits.grant(this, ::Legends.Trait.LegendDonkeyAppetite);
		}
		if (!this.m.Container.hasActive(::Legends.Active.LegendDonkeyKick))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendDonkeyKick);
		}
		this.character_background.onAdded();
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
