this.legend_horserider <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_horserider";
		this.m.Name = "Horse Rider";
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
			::Legends.Traits.getID(::Legends.Trait.Asthmatic)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.None;
		this.m.HairColors = this.Const.HairColors.None;
		this.m.Beards = null;

		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Stabled;
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
				::Legends.Perk.Pathfinder,
				::Legends.Perk.Steadfast,
				::Legends.Perk.Recover
			],
			[
				::Legends.Perk.Dodge,
				::Legends.Perk.HoldOut,
				::Legends.Perk.LegendComposure,
				::Legends.Perk.SteelBrow
			],
			[
				::Legends.Perk.Anticipation,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.Taunt,
				// ::Legends.Perk.LegendSprint
			],
			[
				::Legends.Perk.LegendEfficientPacking,
				::Legends.Perk.LegendAmmoBinding,
				::Legends.Perk.LegendMedPackages,
				::Legends.Perk.LegendToolsDrawers

			],
			[
				::Legends.Perk.LoneWolf,
				::Legends.Perk.LegendBattleheart
			],
			[
				::Legends.Perk.Nimble,
				::Legends.Perk.LegendLastStand,
				::Legends.Perk.LegendRebound,
				::Legends.Perk.LegendMuscularity
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.Stalwart,
				::Legends.Perk.LegendSkillfulStacking,
				::Legends.Perk.LegendAmmoBundles,
				::Legends.Perk.LegendMedIngredients,
				::Legends.Perk.LegendToolsSpares
			],
			[],
			[],
			[],
			[]
		];
	}



	function onBuildDescription()
	{
		return "{  %name% was raised to pull plows on a farm. |  %name% was reared by a traveling merchant. | A donkey's life is tough %name% has been used for many things. | Though the work is dangerous, being a caravan donkey allowed %name% to see the world. | When her former owner died, %name% was put up for sale. | Hardy and resolute, %name% was the pick of the bunch. | Sold from owner to owner %name% has worked for more caravans than most traders.} {But the trader she worked for turned out to be abusive, nary a whip away from being a slave driver. A farmer bought %name% to free her, but eventually the cost got too great and she was sold again. | One day, goods went missing and she was blamed for it, promptly ending her time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master died on the road and %name% was left tied to a wagon without food until rescued. | Caravans are frequently attacked, and in one battle as the caravan hands fell %name% ran into the night. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a their caravan, it didn\'t take long for %name% to find a new owner. | But war deprived the caravan of stock and soon its driver took to selling the donkeys.  %name% was among the last to be sold. | Sadly, her caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for her life.} {Now %name% is being sold by a farmer for being too stubborn  | A donkey like %name% is no stranger to danger, making her a good fit for any mercenary group. | With her caravan days behind her, working for a sellsword was just another avenue for oats. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just more carrots. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more donkeys like her.}";
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

	function onSetAppearance()
	{

		local actor = this.getContainer().getActor();
		local rider = actor.getRider();
		//actor.copySpritesFrom(rider);

		local Sprites = [
			"body",
			"armor",
			"head",
			"hair",
			"beard",
			"beard_top",
			"injury",
			"arms_icon",
			"shield_icon",
			"shield",
			"armor_upgrade_front",
			"armor_upgrade_back",
			"accessory",
			"quiver",
			"helmet",
			"helmet_damage",
			"body_blood"
		];
		foreach(s in Sprites)
		{
			if (!rider.hasSprite(s))
			{
				continue
			}
			local brush = rider.getSprite(s).getBrush();
			if (brush == null)
			{
				continue
			}
			if (!actor.hasSprite(s))
			{
				actor.addSprite(s)
			}
			actor.getSprite(s).setBrush(brush.Name)
		}

		local offset = this.createVec(-20, 0);
		foreach(s in Sprites)
		{
			actor.setSpriteOffset(s, offset);
		}

		offset = this.createVec(10,0);
		local variant = this.Math.rand(0, 7);
		local horse = actor.addSprite("horse_body");
		horse.setBrush(actor.getHorse().getSprite("body").getBrush().Name);
		horse.varySaturation(0.15);
		horse.varyColor(0.07, 0.07, 0.07);
		local horse_head = actor.addSprite("horse_head");
		horse.setBrush(actor.getHorse().getSprite("head").getBrush().Name);
		local horse_injury = actor.addSprite("injury_horse_body");
		horse.setBrush(actor.getHorse().getSprite("head").getBrush().Name);
		local offset = this.createVec(10, 0);
		actor.setSpriteOffset("horse_body", offset);
		actor.setSpriteOffset("horse_head", offset);
		actor.setSpriteOffset("injury_horse_body", offset);
	}


	function onAdded()
	{
		this.character_background.onAdded();
		::Legends.Actives.grant(this, ::Legends.Active.LegendHorseKick);
		//this.m.Container.add(this.new("scripts/skills/traits/legend_horse_trait")); //commenting this lets our player horserider use items lol
	}


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 3;
		talents[this.Const.Attributes.Fatigue] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/armor/noble_tunic"));
		items.equip(this.new("scripts/items/weapons/pike"));
	}

});
