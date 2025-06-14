::mods_hookExactClass("skills/backgrounds/caravan_hand_background", function(o)
{
	o.create = function ()
	{
		this.character_background.create();
		this.m.ID = "background.caravan_hand";
		this.m.Name = "Caravan Hand";
		this.m.Icon = "ui/backgrounds/background_12.png";
		this.m.BackgroundDescription = "Caravan hands are used to long and exhausting travels.";
		this.m.GoodEnding = "%name% the once-caravan hand retired from fighting. He used his mercenary money to start a trade-guarding business that specializes in transporting goods through dangerous lands.";
		this.m.BadEnding = "%name% the caravan hand retired back into guarding trade wagons. He died when defending against an ambush by brigands. They took his shirt and left his body in a ditch.";
		this.m.HiringCost = 75;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tiny),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Gluttonous),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.LegendUnpredictable)
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Chivalrous;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.BackgroundType = this.Const.BackgroundType.Combat;
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[2];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
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
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.SwordTree,
				this.Const.Perks.SpearTree,
				this.Const.Perks.AxeTree,
				this.Const.Perks.ThrowingTree,
				this.Const.Perks.ShieldTree
			],
			Defense = [
				this.Const.Perks.HeavyArmorTree
			],
			Traits = [
				this.Const.Perks.SturdyTree,
				this.Const.Perks.OrganisedTree,
				this.Const.Perks.FitTree,
				this.Const.Perks.LargeTree
			],
			Enemy = [
				this.Const.Perks.OutlandersTree
			],
			Class = [],
			Profession = [],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}


	o.onBuildDescription <- function ()
	{
		return "{Always the adventurous type, %name% was easily drawn to the life of a caravan hand. | Orphaned by war and pestilence, %name% grew up under the wings of a traveling merchant. | A caravan hand\'s life is tough, but %name% could hardly stand staying in one place for too long. | Though the work is dangerous, being a caravan hand allowed %name% to see the world. | When his family and obligations were destroyed by fire, %name% saw no reason not to join a passing caravan. | Hardy and resolute, %name% was the first chosen by a merchant to protect his stock as a caravan hand. | Running away from home, it didn\'t take long for %name% to join and eventually work for a caravan.} {But the trader he worked for turned out to be abusive, nary a whip away from being a slave driver. After an intense argument with the woman, %name% thought it better to leave before he did something awful. | One day, goods went missing and the hand was blamed for it, promptly ending his time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master refused to pay %name%. With just one hand the caravanner punched his boss and grabbed his wages. He used both legs to run, though. | Caravans are frequently tense places to be. One fateful evening, in a dispute over gambling debts, he stove in the head of another traveler. Fearing retribution, %name% was gone before morning. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a fellow caravan, it didn\'t take long for %name% to figure out his wages didn\'t quite meet the level of threats around him. | But war deprived the caravan of stock and soon its driver took to selling slaves. Appalled, %name% freed as many as he could before leaving for good. | Sadly, his caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for his life.} {Now uncertain of what to do, he seeks any opportunity that might come by. | A man like %name% is no stranger to danger, making him a good fit for any mercenary group. | With his caravan days behind him, working as a sellsword was just another avenue for adventure and profit. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just better paid. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more men like him.}";
	}

	o.onChangeAttributes = function ()
	{
		local c = {
			Hitpoints = [
				3,
				5
			],
			Bravery = [
				3,
				3
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				0,
				4
			],
			RangedSkill = [
				2,
				5
			],
			MeleeDefense = [
				1,
				3
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

	o.onAddEquipment = function ()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/dagger"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/bludgeon"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.gambeson],
			[1, ::Legends.Armor.Standard.padded_leather],
			[1, ::Legends.Armor.Standard.thick_tunic],
			[1, ::Legends.Armor.Standard.leather_tunic]
		]));

		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.headscarf],
			[1, ::Legends.Helmet.Standard.open_leather_cap]
		]));
	}

});
