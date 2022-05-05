this.legend_puppet_master_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_puppet_master";
		this.m.Name = "Puppet Master";
		this.m.Icon = "ui/backgrounds/background_necromancer.png"; 
		this.m.BackgroundDescription = "Puppet masters are warlocks in training. While they do not understand the raising or preservation of the dead, they do excel at controlling them.";
		this.m.GoodEnding = "%name% continued to look for a cure to their ailments after you left the company. A few years later they would wander into the woods and meet a witch who was more than happy to help at the cost of some protection. %name% and the witch lived out most of their lives away from prying eyes, surrounded by ever shifting rings of undead patrolling the perimeter.";
		this.m.BadEnding = "Seeing their affliction as a permanent problem that wouldn\'t go away, %name% split from the company shortly after your departure. They took a different approach and looked for cures closer to the grave, allowing a puppet of their own correction to bite them. Upon taking their own life shortly after, %name% did not rise as coherent as they intended - instead as a spectator to their own body's actions. They remained trapped and decaying until a mercenary company cut them down outside of a nameless hamlet.";
		this.m.HiringCost = 1200000000000;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.hate_undead",
			"trait.fear_undead",
			"trait.fearless",
			"trait.loyal",
			"trait.brave",
			"trait.spartan",
			"trait.light",
			"trait.greedy"
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

		if (!this.LegendsMod.Configs().LegendMagicEnabled()) //heavy armour, medium armour perks, spells.
		{
				this.m.CustomPerkTree = [
				[
					this.Const.Perks.PerkDefs.NineLives,
					this.Const.Perks.PerkDefs.CripplingStrikes,
					this.Const.Perks.PerkDefs.BagsAndBelts,
					this.Const.Perks.PerkDefs.Student,
					this.Const.Perks.PerkDefs.Recover,
					this.Const.Perks.PerkDefs.LegendBalance,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheSkill,
					this.Const.Perks.PerkDefs.LegendPossession
				],
				[
					this.Const.Perks.PerkDefs.CoupDeGrace,
					this.Const.Perks.PerkDefs.LegendWither,
					this.Const.Perks.PerkDefs.SteelBrow,
					this.Const.Perks.PerkDefs.Gifted,
					this.Const.Perks.PerkDefs.LegendSpecialistShieldSkill,
					this.Const.Perks.PerkDefs.LegendMatchingSet,
					this.Const.Perks.PerkDefs.LegendPrepareBleed,
					this.Const.Perks.PerkDefs.LegendPrepareGraze
				],
				[
					this.Const.Perks.PerkDefs.Backstabber,
					this.Const.Perks.PerkDefs.Debilitate,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan,
					this.Const.Perks.PerkDefs.Brawny,
					this.Const.Perks.PerkDefs.LegendRust,
					this.Const.Perks.PerkDefs.LegendSpecialistScytheDamage,
					this.Const.Perks.PerkDefs.LegendSpecStaffSkill,
					this.Const.Perks.PerkDefs.LegendBloodbath
				],
				[
					this.Const.Perks.PerkDefs.SpecDagger,
					this.Const.Perks.PerkDefs.SpecMace,
					this.Const.Perks.PerkDefs.SpecCleaver,
					this.Const.Perks.PerkDefs.SpecThrowing,
					this.Const.Perks.PerkDefs.LegendMasteryStaves,
					this.Const.Perks.PerkDefs.LegendSpecPoison,
					this.Const.Perks.PerkDefs.LegendLacerate
				],
				[
					this.Const.Perks.PerkDefs.Underdog,
					this.Const.Perks.PerkDefs.LegendLithe,
					this.Const.Perks.PerkDefs.LegendSpecStaffStun,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
					this.Const.Perks.PerkDefs.LegendBlendIn,
					this.Const.Perks.PerkDefs.LegendInsects,
					this.Const.Perks.PerkDefs.LegendSlaughter
				],
				[
					this.Const.Perks.PerkDefs.LegendClarity,
					this.Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
					this.Const.Perks.PerkDefs.Taunt,
					this.Const.Perks.PerkDefs.LegendViolentDecomposition,				
					this.Const.Perks.PerkDefs.LegendSiphon,
					this.Const.Perks.PerkDefs.BattleForged,
					this.Const.Perks.PerkDefs.LegendHidden
				],
				[
					this.Const.Perks.PerkDefs.Fearsome,
					this.Const.Perks.PerkDefs.PerfectFocus,
					this.Const.Perks.PerkDefs.LegendFullForce,
					this.Const.Perks.PerkDefs.BattleFlow,
					this.Const.Perks.PerkDefs.LegendMiasma,
					this.Const.Perks.PerkDefs.MARInTheZone,
					this.Const.Perks.PerkDefs.LegendDeathtouch
				],
				[],
				[],
				[],
				[]
			];

		}
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