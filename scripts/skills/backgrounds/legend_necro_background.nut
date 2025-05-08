this.legend_necro_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_necro";
		this.m.Icon = "ui/backgrounds/warlock_02.png";
		local r = this.Math.rand(0, 3);


		this.m.Name = "Warlock";


		this.m.HiringCost = 20000;
		this.m.DailyCost = 50;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.Brute),
			::Legends.Traits.getID(::Legends.Trait.Dexterous),
			::Legends.Traits.getID(::Legends.Trait.EagleEyes),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Huge),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Quick),
			::Legends.Traits.getID(::Legends.Trait.Swift),
			::Legends.Traits.getID(::Legends.Trait.SureFooting),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
		];
		this.m.Titles = [
			"the Sickening",
			"the Wretched",
			"the Widow Taunter",
			"the Fleshturner",
			"The Corpse Dancer",
			"the Puppeteer"
		];
		this.m.Faces = this.Const.Faces.Necromancer;
		this.m.Hairs = this.Const.Hair.Vampire;
		this.m.HairColors = this.Const.HairColors.Zombie;
		this.m.Beards = this.Const.Beards.Raider;

		this.m.Level = 1;

		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Meds = this.Const.LegendMod.ResourceModifiers.Meds[3];
		this.m.Modifiers.Stash = this.Const.LegendMod.ResourceModifiers.Stash[1];
		this.m.Modifiers.Healing = this.Const.LegendMod.ResourceModifiers.Healing[2];
		this.m.Modifiers.Injury = this.Const.LegendMod.ResourceModifiers.Injury[2];
		this.m.Modifiers.MedConsumption = this.Const.LegendMod.ResourceModifiers.MedConsumption[3];
		this.m.CustomPerkTree = [
			[
				::Legends.Perk.LegendSiphon,
				::Legends.Perk.NineLives,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.Student,
				::Legends.Perk.Recover,
				::Legends.Perk.LegendWither,
				::Legends.Perk.LegendSpawnZombieLow,
				::Legends.Perk.LegendSpawnSkeletonLow,
				::Legends.Perk.LegendSpecialistReaper
			],
			[
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.FortifiedMind,
				::Legends.Perk.HoldOut,
				::Legends.Perk.Gifted,
				::Legends.Perk.LegendRust,
				::Legends.Perk.LegendBloodbath,
				::Legends.Perk.LegendMedPackages
			],
			[
				::Legends.Perk.Backstabber,
				::Legends.Perk.LegendDebilitate,
				::Legends.Perk.LegendDeathtouch,
				::Legends.Perk.LegendLookout,
				::Legends.Perk.LegendSpecialistSelfdefense,
				::Legends.Perk.LegendExtendendAura
			],
			[
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecMace,
				::Legends.Perk.SpecCleaver,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.LegendMasteryStaves,
				::Legends.Perk.LegendSpecPoison,
				::Legends.Perk.LegendSpawnZombieMed,
				::Legends.Perk.LegendSpawnSkeletonMed

			],
			[
				::Legends.Perk.LoneWolf,
				::Legends.Perk.LegendLithe,
				::Legends.Perk.LegendBlendIn,
				::Legends.Perk.LegendReclamation,
				::Legends.Perk.LegendFavouredEnemyGhoul,
				::Legends.Perk.LegendSpecStaffStun,
				::Legends.Perk.LegendMedIngredients,
				::Legends.Perk.LegendConservation
			],
			[
				::Legends.Perk.LegendClarity,
				::Legends.Perk.LegendInsects,
				::Legends.Perk.LegendFavouredEnemyHexen,
				::Legends.Perk.LegendFavouredEnemyAlps,
				::Legends.Perk.LegendChanneledPower,
				::Legends.Perk.LegendPossession
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.LegendGruesomeFeast,
				::Legends.Perk.LegendPerfectFocus,
				::Legends.Perk.LegendBalance,
				::Legends.Perk.LegendMiasma,
				::Legends.Perk.LegendDarkflight,
				::Legends.Perk.LegendViolentDecomposition,
				::Legends.Perk.LegendSpawnZombieHigh,
				::Legends.Perk.LegendSpawnSkeletonHigh
			],
			[],
			[],
			[],
			[]
		];
	}



	function onBuildDescription()
	{
		return "{Clothed in strange black robes, %name% appears to be more of an ambassador of the dark than a man of flesh and blood. | A curious fellow, %name% carries a slumped posture, as if he is weighted by otherworldly knowledge. | %name%\'s face is hidden well inside the dark of his cowl, a crescent of yellow teeth the only notion that a man dwells within. | Not much is known about %name%, but strange rumors of sorcery and dark arts follow him. | Wherever animals mysteriously begin to die, %name% makes an appearance. | The brooches on %name%\'s cloak seem to swirl and dance like midnight in a jug. | %name%\'s hands are rare to see, only coming out as if to portray the feelings of his face which lies hidden deep in his hood. | %name%\'s eyes could be mistaken for a cat\'s one day and for a blind man\'s the next.} {Little is known about whence he came. | From where he hails is but a mystery to most. | Some say he traveled deep into the northern foothills, returning with unspoken knowledge. | Ostensibly, the dark arts are his heritage, or so he puts on. | The man\'s past is kept from all. Maybe it\'s just uninteresting, or maybe just the opposite. | One rumor of the man says he traveled the land as a magician. | Rumors of magic surround the man, though some incredulous cynics are hardly impressed. | One rumor is that he was a conman, and another is that he\'s a sorcerer. You\'re not sure which you prefer. | With rumors of dark arts being practiced once more, the man\'s magical proclamation just might be true. | Some say he eats toads for breakfast and black cats for dinner.} {You ask %name% a lot of questions, but through some handwaves and nods, you realize you have forgotten his answers. Or did you ask the questions at all? | %name% produces a dove from his sleeve. An old trick that fancies no one - until it turns in the air, returning to him as a crow. | %name% has shown the ability to shoot smoke from his mouth. It\'s not fire, but it\'s close, and has people talking in hushed tones. | %name% floats a gold coin into the air. An amazing display that leaves the man too tired to attempt it again. | Predictions of the weather are common, but %name% is unusually accurate with his own. | %name% asks to read your palms. You decline. His presence alone is as close as you\'re willing to go. | %name% suggests that the stars are a roadmap to another world. He seems to know a lot about the heavens above. | %name% suggests that the heavens above are in fact just endless streams of beings, continuing on for eons. What a jest! | %name% points to one star in the sky and seems to suggest that is where he came from. You don\'t ask for a clarification on the matter.}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				15,
				20
			],
			Bravery = [
				-10,
				-5
			],
			Stamina = [
				5,
				5
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				-5,
				-5
			],
			RangedDefense = [
				-10,
				-5
			],
			Initiative = [
				10,
				10
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.Hitpoints] = 3;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		items.equip(this.Const.World.Common.pickHelmet([
			[1, ::Legends.Helmet.None],
			[1, ::Legends.Helmet.Standard.dark_cowl],
			[1, ::Legends.Helmet.Standard.witchhunter_hat]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[1, ::Legends.Armor.Standard.thick_dark_tunic]
		]));
		items.equip(this.new("scripts/items/weapons/legend_grisly_scythe"));
		local stash = this.World.Assets.getStash()
	}
});
