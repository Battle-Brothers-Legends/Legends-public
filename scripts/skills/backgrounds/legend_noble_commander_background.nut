this.legend_noble_commander_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderNoble);
		this.m.Name = "Noble Usurper";
		this.m.Icon = "ui/backgrounds/noble_02.png";
		this.m.BackgroundDescription = "A noble with a birthright claim to authority";
		this.m.GoodEnding = "Adventurousness never leaves the soul of a %person% like %name%. {Instead of returning to the armed services, %they% left the %companyname% and headed east in search of rare beasts. Word has it %they% returned to town with the head of what looked like a giant lizard, but you don\'t believe such fantastical tripe. | %They% departed the %companyname% and ventured west, sailing across the oceans to unseen lands. There\'s no telling where %they% is these days, but you\'ve little doubt that %they%\'ll be coming back with stories to tell. | %They% retired from the %companyname% and, instead of returning to %their% noble family, headed south. Word has it %they% fought in a great noble civil war, killed an orc warlord, climbed the highest mountain in the land, and is currently writing an epic about %their% travels. | The noble%person% left the %companyname% and, preferring the life of adventure to noble boredom, %they% headed north. Word has it that %they're% currently marching a troop of explorers to the furthest reaches of the world.}";
		this.m.BadEnding = "%name% departed the %companyname% and continued %their% adventuring elsewhere. {%They% headed east, hoping to discover the source of the greenskins, but the noble%person% has not been heard from since. | %They% headed north into the snowy wastes. Word has it %they% was seen a week ago, marching south this time, looking rather pale and shuffling moreso than walking. | %They% headed south into brutal marshlands. Word has it that a mysterious flame appeared in the fog and %they% walked toward it. The men who saw this said %they% disappeared into the mist and never returned. | %They% headed west and sailed the open sea. Despite having no experience at sea, %they% saw fit to make %themselves% captain of the boat. They say pieces of %their% ship and dead sailors kept washing ashore for weeks.}";
		this.m.HiringCost = 25000;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Weasel),
			::Legends.Traits.getID(::Legends.Trait.FearBeasts),
			::Legends.Traits.getID(::Legends.Trait.Clubfooted),
			::Legends.Traits.getID(::Legends.Trait.Irrational),
			::Legends.Traits.getID(::Legends.Trait.Hesitant),
			::Legends.Traits.getID(::Legends.Trait.Drunkard),
			::Legends.Traits.getID(::Legends.Trait.Fainthearted),
			::Legends.Traits.getID(::Legends.Trait.Craven),
			::Legends.Traits.getID(::Legends.Trait.Dastard),
			::Legends.Traits.getID(::Legends.Trait.Fragile),
			::Legends.Traits.getID(::Legends.Trait.Insecure),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.LegendDoubleTongued)
		];
		

		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Notorious;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Level = 2;
		this.m.BackgroundType = this.Const.BackgroundType.Combat | this.Const.BackgroundType.Noble | this.Const.BackgroundType.Untalented;

		this.m.Modifiers.Ammo = this.Const.LegendMod.ResourceModifiers.Ammo[1];
		this.m.Modifiers.ArmorParts = this.Const.LegendMod.ResourceModifiers.ArmorParts[1];
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[1];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[1];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[1];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[1];
		this.m.Modifiers.ToolConsumption = this.Const.LegendMod.ResourceModifiers.ToolConsumption[1];
		this.m.Modifiers.Training = this.Const.LegendMod.ResourceModifiers.Training[1];
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
			0.025, //steppes
			0.0, //ocean
			0.0, //desert
			0.0 //oasis
		];
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.DaggerTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.SwordTree,
				::Const.Perks.MaceTree,
				::Const.Perks.CrossbowTree
			],
			Defense = [
				::Const.Perks.MediumArmorTree
			],
			Traits = [
				::Const.Perks.IntelligentTree,
				::Const.Perks.ViciousTree,
				::Const.Perks.CalmTree,
				::Const.Perks.TrainedTree,
				::Const.Perks.FitTree,
				::Const.Perks.InspirationalTree
			],
			Enemy = [
				::Const.Perks.OutlawTree,
				::Const.Perks.CivilizationTree
			],
			Class = [],
			Profession = [
				::Const.Perks.BarterProfessionTree
			],
			Magic = [
				::Const.Perks.CaptainMagicTree
			]
		}
	}

	function setGender(_gender = -1) {
		if (_gender == -1) _gender = this.setCommanderGender();
		_gender ? this.setBodyCharacteristics(_gender, {HairColors = ::Const.HairColors.Young}) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.TidyMale, HairColors = ::Const.HairColors.Young});
	}

	function onBuildDescription() {
		if (this.isBackgroundType(this.Const.BackgroundType.Female)) {
			return "{A viscountess of the realm | As the third in the line of succession | A young and brash noble | A skilled swordsman}, %name%\'s life at court {had grown stale for her | was not exciting enough for her with endless studying of court etiquette and family lineage | felt like wasting the best time of her life | was not half as exciting to her as the tales of adventures, battles, fearsome beasts to vanquish and fair maidens to conquer}. {Wearing the family crest proudly | At the encouragement of her brother | To the frustration of her mother | Finally making a decision to change things}, %name% rode out to {prove herself | make a name for herself | earn glory on the battlefield | test her skills in battle} and {live life to its fullest as she imagined it from behind the castle walls | see all the wonders and exotic places of the world | earn her place in the world | be knighted for her valor | become famous and loved in all the known world | become infamous and feared in all the known world}.";
		} else {
			return "{A viscount of the realm | As the third in the line of succession | A young and brash noble | A skilled swordsman}, %name%\'s life at court {had grown stale for him | was not exciting enough for him with endless studying of court etiquette and family lineage | felt like wasting the best time of his life | was not half as exciting to him as the tales of adventures, battles, fearsome beasts to vanquish and fair maidens to conquer}. {Wearing the family crest proudly | At the encouragement of his brother | To the frustration of his mother | Finally making a decision to change things}, %name% rode out to {prove himself | make a name for himself | earn glory on the battlefield | test his skills in battle} and {live life to its fullest as he imagined it from behind the castle walls | see all the wonders and exotic places of the world | earn his place in the world | be knighted for his valor | become famous and loved in all the known world | become infamous and feared in all the known world}.";
		}
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendCommanderNoble);
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		//this.m.Container.add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		//this.m.Container.add(this.new("scripts/skills/perks/perk_fortified_mind"));

		if (this.isBackgroundType(this.Const.BackgroundType.Female))
		{
			actor.setName(this.Const.Strings.LadyNames[this.Math.rand(0, this.Const.Strings.LadyNames.len() - 1)]);
		}
		else
		{
			actor.setName(this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Bravery] = 3;
		talents[this.Const.Attributes.MeleeSkill] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.noble_tunic]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.Standard.legend_noble_hat],
			[1, ::Legends.Helmet.Standard.legend_noble_crown],
			[1, ::Legends.Helmet.Standard.legend_noble_floppy_hat],
			[1, ::Legends.Helmet.Standard.legend_noble_hood]
		]));
		items.equip(this.new("scripts/items/weapons/ancient/broken_bladed_pike"));
	}
});
