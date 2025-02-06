this.legend_qiyan_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_qiyan";
		this.m.Name = "Qiyan";
		this.m.Icon = "ui/backgrounds/background_qiyan.png";
		this.m.BackgroundDescription = "The qiyan is a slave, seductive and knowledgeable.";
		this.m.GoodEnding = "%name% took what they had learned from their time in the company and headed north with the intention of getting as far away from the south as possible. They found good work and few questions awaiting them at a northern settlement in the tundra where they quickly rose the ranks of the local militia to become captain.";
		this.m.BadEnding = "With the commander gone %name%\'s future was uncertain, but her old masters were not. Manhunters came for %name% a few nights after the commander leaving. Without your guidance the remaining mercenaries did not attempt to stop the manhunters. What became of %name% is a mystery, she was last seen on a slave caravan heading south, but after that is anyone\'s guess.";
		this.m.HiringCost = 500;
		this.m.DailyCost = 10;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Clumsy),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Ailing),
			::Legends.Traits.getID(::Legends.Trait.Asthmatic),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.LegendHeavy),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.LegendSlack),
			::Legends.Traits.getID(::Legends.Trait.Craven)
		];
		this.m.Titles = [
			"the Qiyan"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Fatigue
		];
		// this.m.IsGuaranteed = ["seductive_trait"]
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Ethnicity = 1;

		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Combat | this.Const.BackgroundType.Performing;
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[2];
		this.m.Modifiers.Scout = this.Const.LegendMod.ResourceModifiers.Scout[1];
		this.m.PerkTreeDynamic = {
			Weapon = [
				this.Const.Perks.DaggerTree,
				this.Const.Perks.SwordTree,
				this.Const.Perks.ThrowingTree
			],
			Defense = [
				this.Const.Perks.ClothArmorTree,
				this.Const.Perks.LightArmorTree
			],
			Traits = [ //lf 5
				this.Const.Perks.AgileTree,
				this.Const.Perks.InspirationalTree,
				this.Const.Perks.FastTree,
				this.Const.Perks.IntelligentTree
			],
			Enemy = [],
			Class = [
				this.Const.Perks.KnifeClassTree,
				this.Const.Perks.BardClassTree
			],
			Magic = []
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				3
			],
			Bravery = [
				5,
				10
			],
			Stamina = [
				5,
				8
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-5,
				5
			],
			MeleeDefense = [
				-5,
				10
			],
			RangedDefense = [
				-6,
				4
			],
			Initiative = [
				-5,
				5
			]
		};
		return c;
	}

	function onBuildDescription()
	{
		return "{%name% caught your eye during a festival held on a street corner, her singing voice was the most serene thing you had ever heard yet the chains of slavemasters rattled and clattered, masking her falsettos. | Her owners keep her at a distance, despite the delicate demeanour. | After verifying her claims that she stabbed a man twice her size to death in the street only a few weeks ago, you may think that she has what it takes to work in more gainful employment. } {%name% talks at length about her routine as a slave girl - she always wore as little clothing as she could get away with and her dances enthralled men and women alike. | She would dance for hours in public or private, normally for the wealthiest men in the land. | She also goes into great depth about how she killed each and every one of them with mundane objects like incense sticks, candles and even her own clothes. | This would explain why %name% wears broken shackles and is currently on the run from her employers. } {%name% used to be a slave girl, she is very particular on using the past tense when describing her past involving \'the rice and that stupid noble boy\'. | When asked why she dances, she laughs and motions to the flowers and herbs adorning her hair. | While you are no expert, you do recognise at least two types that could kill a donkey in just a few bites. } {%name% is a mysterious character, under their clothing you can hear the occasional rattle of chains and the flash of a knife. | While all the hallmarks of a slave and assassin, %name% prefers to recite political treatise and poetry, almost word for word, to anyone who will listen. | Either a political captive or perhaps a recently learned woman, %name% can sit down with anyone and explain how to effectively, silently and efficiently kill any man with nothing but a scrap of metal and the element of surprise. | Almost word for word.}"
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local armor = this.Const.World.Common.pickArmor([
			[1, "oriental/cloth_sash"]
		]);
		items.equip(armor);
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ""],
			[1, "legend_headband_coin"],
			[1, "legend_headress_coin"],
			[1, "legend_earings"],
			[5, "legend_southern_veil"],
			[1, "legend_southern_veil_coin"],
			[1, "legend_southern_cloth_headress"]
		]));
	}
});

