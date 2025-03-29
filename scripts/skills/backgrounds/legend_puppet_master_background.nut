this.legend_puppet_master_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_puppet_master";
		this.m.Name = "Puppet Master";
		this.m.Icon = "ui/backgrounds/background_necromancer.png"; //—
		this.m.BackgroundDescription = "Puppet masters are warlocks in training. While they do not understand the raising or preservation of the dead, they do excel at controlling them.";
		this.m.GoodEnding = "%name% continued to practice their control over immortal objects for some time after mastering the basics from their time with the company. Given time they slowly strayed further and further from mortal company and surrounded themselves with marionettes of their own making — it didn\'t take long for them to muster a court of silent friends and comrades that agreed with their every word and whim. %name% had found a place where they could belong, even if the road to get here was paved with darker intentions.";
		this.m.BadEnding = "%name% gradually detached from reality as their powers grew, forming their own as the world around them fell apart. Living or dead — it no longer mattered to him. %name% left quietly one night with a small group of his puppets, only to realise that when you are cold and alone, a brutal overseer has few friends when he needs them most.";
		this.m.HiringCost = 1200000000000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			::Legends.Traits.getID(::Legends.Trait.HateUndead),
			::Legends.Traits.getID(::Legends.Trait.FearUndead),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.Loyal),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Spartan),
			::Legends.Traits.getID(::Legends.Trait.LegendLight),
			::Legends.Traits.getID(::Legends.Trait.Greedy)
		];
		this.m.Titles = [
			"the Hidden Hand",
			"the Schemer",
			"the Director",
			"the Overseer"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Bravery
		];
		this.m.Ethnicity = this.Math.rand(1, 2); //is southern
		if (this.m.Ethnicity == 1)
		{
			this.m.Bodies = this.Const.Bodies.SouthernMuscular;
			this.m.Faces = this.Const.Faces.SouthernMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.Southern;
		}
		else
		{
			this.m.Bodies = this.Const.Bodies.AfricanMale;
			this.m.Faces = this.Const.Faces.AfricanMale;
			this.m.Hairs = this.Const.Hair.SouthernMale;
			this.m.HairColors = this.Const.HairColors.African;
		}
		this.m.Beards = this.Const.Beards.Southern;
		this.m.BeardChance = 90;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
		//---
		this.m.BackgroundType = this.Const.BackgroundType.Untalented | this.Const.BackgroundType.Outlaw;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Merciless;
		this.m.Modifiers.Terrain = [
				0.0, // ?
				0.0, //ocean
				0.0,//plains
				0.0, //swamp
				0.0, //hills
				0.0, //forest
				0.0, //forest
				0.0, //forest_leaves
				0.0, //autumn_forest
				0.0, //mountains
				0.0, // ?
				0.0, //farmland
				0.0, // snow
				0.0, // badlands
				0.0, //highlands
				0.0, //stepps
				0.0, //ocean
				0.0, //desert
				0.0 //oasis
			];

		this.m.CustomPerkTree = [
			[
				::Legends.Perk.NineLives,
				::Legends.Perk.CripplingStrikes,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.Student,
				::Legends.Perk.Recover,
				::Legends.Perk.LegendBalance,
				::Legends.Perk.LegendSpecialistReaper,
				::Legends.Perk.LegendPossession
			],
			[
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.LegendWither,
				::Legends.Perk.SteelBrow,
				::Legends.Perk.Gifted,
				::Legends.Perk.LegendSpecialistShieldSkill,
				::Legends.Perk.LegendPerfectFit,
			],
			[
				::Legends.Perk.Backstabber,
				::Legends.Perk.LegendDebilitate,
				::Legends.Perk.LegendFavouredEnemyCaravan,
				::Legends.Perk.Brawny,
				::Legends.Perk.LegendRust,
				::Legends.Perk.LegendSpecialistSelfdefense,
				::Legends.Perk.LegendBloodbath
			],
			[
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecMace,
				::Legends.Perk.SpecCleaver,
				::Legends.Perk.SpecThrowing,
				::Legends.Perk.LegendMasteryStaves,
				::Legends.Perk.LegendSpecPoison,
				::Legends.Perk.LegendLacerate
			],
			[
				::Legends.Perk.Underdog,
				::Legends.Perk.LegendLithe,
				::Legends.Perk.LegendSpecStaffStun,
				::Legends.Perk.LegendFavouredEnemyGhoul,
				::Legends.Perk.LegendBlendIn,
				::Legends.Perk.LegendInsects,
				::Legends.Perk.LegendCarnage
			],
			[
				::Legends.Perk.LegendClarity,
				::Legends.Perk.LegendFavouredEnemyAlps,
				::Legends.Perk.Taunt,
				::Legends.Perk.LegendViolentDecomposition,
				::Legends.Perk.LegendSiphon,
				::Legends.Perk.BattleForged
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.LegendPerfectFocus,
				::Legends.Perk.LegendFullForce,
				::Legends.Perk.BattleFlow,
				::Legends.Perk.LegendMiasma,
				::Legends.Perk.LegendInTheZone,
				::Legends.Perk.LegendDeathtouch
			],
			[],
			[],
			[],
			[]
		];
	}

	function onBuildDescription()
	{
		return "{Chronically lazy, %name% was the son of a noble that had little interest in fencing, archery or diplomacy. They instead perferred to watch people move around like little ants from up high and command them as if they were the gilder themselves. | When a political rival ousted their father from power, %name% was forced into exile. | %name% was born a titan of a baby, already outmatching his siblings in strength and size. His natural gifts were never put to much use however. | %name% never had much disipline as a child, they would frequently cause mischief around their father\'s' estate. They discovered their dark gifts on accident while poking a living corpse trapped in the arches of the watermill, and the rest just fell into place. | %name% never understood why everyone was running around and so angry all the time. To them life is about relaxation and enjoying things, even if that involves having a small army of shuffling corpses to bring you drinks and clear the weeds from the herb garden. | %name% discovered their gifts early into their development. At first it was an accident involving a stray dog, but that experience quickly grew into an art form for %name% until they were exiled for their interests. | %name% was a child without a purpose. Born into nobility they spent their days as a child crushing ants and poking dead animals in the courtyard. Nothing interested %name% until they met an old man performing macabre tricks for the royal court...} {%name% always considered the old master to be their true father. With the death of the master the lowly pupil feels like a dark light has been extinguished from the world. Is it truely worth going on anymore?}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				5
			],
			Bravery = [
				-15,
				-10
			],
			Stamina = [
				10,
				10
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				10,
				10
			],
			MeleeDefense = [
				-5,
				0
			],
			RangedDefense = [
				-5,
				0
			],
			Initiative = [
				5,
				5
			]
		};
		return c;
	}


	function onAddEquipment()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.RangedSkill] = 2;
		this.getContainer().getActor().fillTalentValues(1, true);
		local items = this.getContainer().getActor().getItems();
		//items
		items.equip(this.Const.World.Common.pickHelmet([
			[3, "dark_southern_helmet_00"],
			[2, "dark_cowl"],
			[1, ""],
			[4, "witchhunter_hat"]
		]));

		items.equip(this.Const.World.Common.pickArmor([
			[1, "ragged_dark_surcoat"],
			[1, "dark_southern_armor_00"]
		]));

		items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
	}
});
