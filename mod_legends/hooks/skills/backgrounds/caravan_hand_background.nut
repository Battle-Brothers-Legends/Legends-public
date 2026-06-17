::mods_hookExactClass("skills/backgrounds/caravan_hand_background", function(o)
{
	o.create = function () {
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.CaravanHand);
		this.m.Name = "Caravan Hand";
		this.m.Icon = "ui/backgrounds/background_12.png";
		this.m.BackgroundDescription = "Caravan hands are used to long and exhausting travels.";
		this.m.GoodEnding = "%name% the once-caravan hand retired from fighting. %They% used %their% mercenary money to start a trade-guarding business that specializes in transporting goods through dangerous lands.";
		this.m.BadEnding = "%name% the caravan hand retired back into guarding trade wagons. %They% died when defending against a brigand ambush. They took %their% shirt and left %their% body in a ditch.";
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
				::Const.Perks.SwordTree,
				::Const.Perks.SpearTree,
				::Const.Perks.AxeTree,
				::Const.Perks.ThrowingTree,
				::Const.Perks.ShieldTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.SturdyTree,
				::Const.Perks.OrganisedTree,
				::Const.Perks.FitTree,
				::Const.Perks.LargeTree
			],
			Enemy = [
				::Const.Perks.OutlawTree
			],
			Class = [],
			Profession = [
				::Const.Perks.CaravaneerProfessionTree
			],
			Magic = []
		}
	}

	o.getTooltip = function ()
	{
		return this.character_background.getTooltip();
	}

	o.setGender <- function (_gender = -1) {
		if (_gender == -1) _gender = this.randomizeHumanGender();
		if (_gender != 1) return;

		this.m.Bodies = ::Const.Bodies.FemaleSkinny;
		this.m.Faces = ::Const.Faces.AllWhiteFemale;
		this.m.Hairs = ::Const.Hair.AllFemale;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		
		this.addBackgroundType(::Const.BackgroundType.Female);
	}

	o.onBuildDescription <- function ()	{
		return "{Always the adventurous type, %name% was easily drawn to the life of a caravan hand. | Orphaned by war and pestilence, %name% grew up under the wings of a traveling merchant. | A caravan hand\'s life is tough, but %name% could hardly stand staying in one place for too long. | Though the work is dangerous, being a caravan hand allowed %name% to see the world. | When %their% family and obligations were destroyed by fire, %name% saw no reason not to join a passing caravan. | Hardy and resolute, %name% was the first chosen by a merchant to protect his stock as a caravan hand. | Running away from home, it didn\'t take long for %name% to join and eventually work for a caravan.} {But the trader %they% worked for turned out to be abusive, nary a whip away from being a slave driver. After an intense argument with the man, %name% thought it better to leave before %they% did something awful. | One day, goods went missing and the hand was blamed for it, promptly ending %their% time with the caravan. | But a caravan needs protection for a reason, and an ambush by brigands proved why. %name% barely made it out alive. | Years on the road went without a hitch until a new caravan master refused to pay %name%. With just one hand the caravanner punched her boss and grabbed %their% wages. %They% used both legs to run, though. | Caravans are frequently tense places to be. One fateful evening, in a dispute over gambling debts, %they% stove in the head of another traveler. Fearing retribution, %name% was gone before morning. | Sadly, with the expanding war the caravan\'s profits were marginal. %name% was let go as the merchants retired their wagons. | After seeing the foul work of beasts on a fellow caravan, it didn\'t take long for %name% to figure out %their% wages didn\'t quite meet the level of threats around %them%. | But war deprived the caravan of stock and soon its driver took to selling slaves. Appalled, %name% freed as many as %they% could before leaving for good. | Sadly, %their% caravan began to sell human chattel. While the profits were enormous, it garnered the attention of a local militia - and their pitchforks. One ambush later and %name% was running for %their% life.} {Now uncertain of what to do, %they% seeks any opportunity that might come by. | A %person% like %name% is no stranger to danger, making %them% a good fit for any mercenary group. | With %their% caravan days behind %them%, working as a sellsword was just another avenue for adventure and profit. | In %name%\'s mind, being a mercenary is a lot like being a caravanner. Just better paid. | Well versed to traveling, %name% seems like a natural fit to the tasks already befit for a mercenary. | Years of road travel have molded %name% into quite the durable figure. Any group of mercenaries could use more %people% like her.}";
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
