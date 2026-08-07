this.legend_qiyan_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendQiyan);
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
		// this.m.IsGuaranteed = [::Legends.Traits.new(::Legends.Trait.LegendSeductive)]
		this.m.Bodies = this.Const.Bodies.SouthernFemale;
		this.m.Faces = this.Const.Faces.SouthernFemale;
		this.m.Hairs = this.Const.Hair.SouthernFemale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Ethnicity = 1;

		this.m.BackgroundType = this.Const.BackgroundType.Female | this.Const.BackgroundType.Combat | this.Const.BackgroundType.Performing;
		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.DaggerTree,
				::Const.Perks.SwordTree,
				::Const.Perks.ThrowingTree,
			],
			Defense = [
				::Const.Perks.ClothArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [ //lf 5
				::Const.Perks.AgileTree,
				::Const.Perks.InspirationalTree,
				::Const.Perks.FastTree,
				::Const.Perks.IntelligentTree
			],
			Enemy = [],
			Class = [],
			Profession = [],
			Magic = [
				::Const.Perks.BardMagicTree
			]
		}
	}

	function onChangeAttributes()
	{
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendQiyan);
	}

	function onBuildDescription() {
		return "%name% caught your eye during a festival held on a street corner, her singing voice was the most serene thing you had ever heard, {yet the chains of slavemasters rattled and clattered, masking her falsettos. | yet her owners keep her at a distance, despite her delicate demeanour.} After verifying her claims that she stabbed a man twice her size to death in the street only a few weeks ago, you may think that she has what it takes to work in more gainful employment. %name% talks at length about her routine as a slave girl. { She always wore as little clothing as she could get away with and her dances enthralled men and women alike | She would dance for hours in public or private, normally for the wealthiest men in the land } and then she killed them with mundane objects like incense sticks, candles and even her own clothes. This would explain why %name% wears broken shackles and is currently on the run from her employers. {%name% used to be a slave girl, she is very particular on using the past tense when describing her past involving \'the rice and that stupid noble boy\'. | When asked why she dances, she laughs and motions to the flowers and herbs adorning her hair. While you are no expert, you do recognise at least two types that could kill a donkey in just a few bites. } {She is a mysterious character, under whose clothing you can hear the occasional rattle of chains and the flash of a knife. | While having all the hallmarks of a slave and an assassin, she prefers to recite political treatise and poetry, almost word for word, to anyone who will listen. | Either a political captive or perhaps a recently learned woman, she can sit down with anyone and explain how to effectively, silently and efficiently kill any man with nothing but a scrap of metal and the element of surprise. Almost word for word.}";
	}

	function onAdded()
	{
		this.character_background.onAdded();
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local armor = this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Southern.cloth_sash]
		]);
		items.equip(armor);
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Southern.legend_headband_coin],
			[1, ::Legends.Helmet.Southern.legend_headress_coin],
			[1, ::Legends.Helmet.Southern.legend_earings],
			[5, ::Legends.Helmet.Southern.legend_southern_veil],
			[1, ::Legends.Helmet.Southern.legend_southern_cloth_headress]
		]));
	}
});

