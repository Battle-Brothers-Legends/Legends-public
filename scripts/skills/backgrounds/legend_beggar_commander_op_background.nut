this.legend_beggar_commander_op_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.legend_commander_beggar_op";
		this.m.Name = "Framed Beggar";
		this.m.Icon = "ui/backgrounds/background_18.png";
		this.m.BackgroundDescription = "Beggars aren\'t the most determined persons, and living on the street tends to be detrimental to their health.";
		this.m.GoodEnding = "Having enough of all the fighting, %name% the once-beggar retired from the %companyname%. You know the man made a pretty crown in his time with the mercenary company, yet the other day you saw him out begging again. You asked if he\'d wasted all his money and he laughed. He said he\'d purchased land and was doing just fine. Then he held out his little tin and asked for a crown. You gave him two.";
		this.m.BadEnding = "The fighting life is a rough one, and %name% the once-beggar saw fit to retire from it before it became a deadly one. Unfortunately, he went back to beggaring. Word has it that a nobleman cleaned a city of riff-raff and sent them marching north despite it being winter. Cold and hungry, %name% died on the side of a road, a tin cup frozen to his finger.";
		this.m.HiringCost = 30;
		this.m.DailyCost = 0;
		this.m.Excluded = [
			"trait.iron_jaw",
			"trait.tough",
			"trait.strong",
			"trait.cocky",
			"trait.fat",
			"trait.bright",
			"trait.fearless",
			"trait.legend_hate_nobles",
			"trait.brave",
			"trait.determined",
			"trait.deathwish",
			"trait.greedy",
			"trait.athletic",
			"trait.legend_aggressive",
			"trait.legend_natural",
			"trait.disloyal",
			"trait.loyal"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery
		];
		this.m.Titles = [
			"the Desolated"
		];
		this.m.Faces = this.Const.Faces.AllWhiteMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
		this.m.Modifiers.Gathering = this.Const.LegendMod.ResourceModifiers.Gather[2];
		this.m.Modifiers.Barter = this.Const.LegendMod.ResourceModifiers.Barter[3];
		this.m.CustomPerkTree = [
			[
				this.Const.Perks.PerkDefs.FastAdaption,
				this.Const.Perks.PerkDefs.CripplingStrikes,
				this.Const.Perks.PerkDefs.Colossus,
				this.Const.Perks.PerkDefs.BagsAndBelts,
				this.Const.Perks.PerkDefs.NineLives,
				this.Const.Perks.PerkDefs.Pathfinder,
				this.Const.Perks.PerkDefs.Adrenaline,
				this.Const.Perks.PerkDefs.Recover,
				this.Const.Perks.PerkDefs.Student
			],
			[
				this.Const.Perks.PerkDefs.CoupDeGrace,
				this.Const.Perks.PerkDefs.Bullseye,
				this.Const.Perks.PerkDefs.Dodge,
				this.Const.Perks.PerkDefs.FortifiedMind,
				this.Const.Perks.PerkDefs.HoldOut,
				this.Const.Perks.PerkDefs.SteelBrow,
				this.Const.Perks.PerkDefs.QuickHands,
				this.Const.Perks.PerkDefs.Gifted
			],
			[
				this.Const.Perks.PerkDefs.Backstabber,
				this.Const.Perks.PerkDefs.Anticipation,
				this.Const.Perks.PerkDefs.ShieldExpert,
				this.Const.Perks.PerkDefs.Brawny,
				this.Const.Perks.PerkDefs.LegendOnslaught,
				this.Const.Perks.PerkDefs.Rotation,
				this.Const.Perks.PerkDefs.RallyTheTroops,
				this.Const.Perks.PerkDefs.Taunt,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyGhoul,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySpider,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyCaravan
			],
			[
				this.Const.Perks.PerkDefs.SpecMace,
				this.Const.Perks.PerkDefs.SpecFlail,
				this.Const.Perks.PerkDefs.SpecHammer,
				this.Const.Perks.PerkDefs.SpecAxe,
				this.Const.Perks.PerkDefs.SpecCleaver,
				this.Const.Perks.PerkDefs.SpecSword,
				this.Const.Perks.PerkDefs.SpecDagger,
				this.Const.Perks.PerkDefs.SpecPolearm,
				this.Const.Perks.PerkDefs.SpecSpear,
				this.Const.Perks.PerkDefs.SpecCrossbow,
				this.Const.Perks.PerkDefs.SpecBow,
				this.Const.Perks.PerkDefs.SpecThrowing
			],
			[
				this.Const.Perks.PerkDefs.Underdog,
				this.Const.Perks.PerkDefs.LoneWolf,
				this.Const.Perks.PerkDefs.ReachAdvantage,
				this.Const.Perks.PerkDefs.Overwhelm,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySkeleton,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyZombie,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyOrk,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyGoblin,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyMercenary,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyBandit
			],
			[
				this.Const.Perks.PerkDefs.HeadHunter,
				this.Const.Perks.PerkDefs.Berserk,
				this.Const.Perks.PerkDefs.Nimble,
				this.Const.Perks.PerkDefs.BattleForged,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySchrat,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyUnhold,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyNoble,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyArcher,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster,
				this.Const.Perks.PerkDefs.LegendFavouredEnemySoutherner
			],
			[
				this.Const.Perks.PerkDefs.Fearsome,
				this.Const.Perks.PerkDefs.Duelist,
				this.Const.Perks.PerkDefs.KillingFrenzy,
				this.Const.Perks.PerkDefs.Indomitable,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyHexen,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyAlps,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyVampire,
				this.Const.Perks.PerkDefs.LegendFavouredEnemyNomad
			],
			[],
			[],
			[],
			[]
		];
	}

	function setGender( _gender = -1 )
	{
		if (_gender == -1) _gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "Disabled" ? 0 : ::Math.rand(0, 1);

		if (_gender != 1) return;

		this.m.Faces = this.Const.Faces.AllWhiteFemale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = null;
		this.m.BeardChance = 0;
		this.m.Bodies = this.Const.Bodies.AllFemale;
		this.addBackgroundType(this.Const.BackgroundType.Female);
		this.m.GoodEnding = "Having enough of all the fighting, %name% the once-beggar retired from the %companyname%. You know the woman made a pretty crown in her time with the mercenary company, yet the other day you saw her out begging again. You asked if she\'d wasted all her money and she laughed. She said she\'d purchased land and was doing just fine. Then she held out his little tin and asked for a crown. You gave her two.";
		this.m.BadEnding = "The fighting life is a rough one, and %name% the once-beggar saw fit to retire from it before it became a deadly one. Unfortunately, she went back to beggaring. Word has it that a nobleman cleaned a city of riff-raff and sent them marching north despite it being winter. Cold and hungry, %name% died on the side of a road, a tin cup frozen to her finger.";
	}

	function getTooltip()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Can evolve by defeating strong enemies."
		});
		return ret;
	}

	function onBuildDescription()
	{
		return "{Having stolen gold from a dead noble, and being framed for the murder, this beggar is on the run!}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-20,
				-20
			],
			Bravery = [
				-20,
				-15
			],
			Stamina = [
				-20,
				-20
			],
			MeleeSkill = [
				-5,
				-5
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
				-5,
				-5
			],
			Initiative = [
				20,
				20
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();

		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}

		actor.getBaseProperties().Hitpoints += actor.getBaseProperties().Hitpoints < _targetEntity.getBaseProperties().Hitpoints ? 1 : 0;
		actor.getBaseProperties().Bravery += actor.getBaseProperties().Bravery < _targetEntity.getBaseProperties().Bravery ? 1 : 0;
		actor.getBaseProperties().Stamina += actor.getBaseProperties().Stamina < _targetEntity.getBaseProperties().Stamina ? 1 : 0;
		actor.getBaseProperties().MeleeSkill += actor.getBaseProperties().MeleeSkill < _targetEntity.getBaseProperties().MeleeSkill ? 1 : 0;
		actor.getBaseProperties().RangedSkill += actor.getBaseProperties().RangedSkill < _targetEntity.getBaseProperties().RangedSkill ? 1 : 0;
		actor.getBaseProperties().MeleeDefense += actor.getBaseProperties().MeleeDefense < _targetEntity.getBaseProperties().MeleeDefense ? 1 : 0;
		actor.getBaseProperties().RangedDefense += actor.getBaseProperties().RangedDefense < _targetEntity.getBaseProperties().RangedDefense ? 1 : 0;
		actor.getBaseProperties().Initiative += actor.getBaseProperties().Initiative < _targetEntity.getBaseProperties().Initiative ? 1 : 0;
		local target_skills = _targetEntity.getSkills().getSkillsByFunction(function ( skill )
		{
			return skill.isType(::Const.SkillType.Perk);
		});
		local allperks = [];

		for( local i = 0; i != target_skills.len(); i = i )
		{
			local perk = target_skills[i];

			if (!actor.getSkills().hasSkill(perk.getID()))
			{
				allperks.push(perk);
			}

			i = ++i;
		}

		if (allperks.len() == 0)
		{
			return;
		}

		local perk = allperks[this.Math.rand(0, allperks.len() - 1)];
		local name = "";

		foreach( i, v in this.getroottable().Const.Perks.PerkDefObjects )
		{
			if (perk.getID() == v.ID)
			{
				name = v.Script;
				this.Tactical.EventLog.log("The framed beggar learned " + perk.getName() + " from his enemy!");
				if (name == "")
				{
					return;
				}
				local r = this.Math.rand(0, 6);
				actor.getBackground().addPerk(i,r);
				actor.getSkills().add(this.new(name));
				break;
			}
		}

	}

});

