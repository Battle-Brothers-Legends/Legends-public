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
			::Legends.Traits.getID(::Legends.Trait.IronJaw),
			::Legends.Traits.getID(::Legends.Trait.Tough),
			::Legends.Traits.getID(::Legends.Trait.Strong),
			::Legends.Traits.getID(::Legends.Trait.Cocky),
			::Legends.Traits.getID(::Legends.Trait.Fat),
			::Legends.Traits.getID(::Legends.Trait.Bright),
			::Legends.Traits.getID(::Legends.Trait.Fearless),
			::Legends.Traits.getID(::Legends.Trait.LegendHateNobles),
			::Legends.Traits.getID(::Legends.Trait.Brave),
			::Legends.Traits.getID(::Legends.Trait.Determined),
			::Legends.Traits.getID(::Legends.Trait.Deathwish),
			::Legends.Traits.getID(::Legends.Trait.Greedy),
			::Legends.Traits.getID(::Legends.Trait.Athletic),
			::Legends.Traits.getID(::Legends.Trait.LegendAggressive),
			::Legends.Traits.getID(::Legends.Trait.LegendTalented),
			::Legends.Traits.getID(::Legends.Trait.Disloyal),
			::Legends.Traits.getID(::Legends.Trait.Loyal)
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
				::Legends.Perk.FastAdaption,
				::Legends.Perk.CripplingStrikes,
				::Legends.Perk.Colossus,
				::Legends.Perk.BagsAndBelts,
				::Legends.Perk.NineLives,
				::Legends.Perk.Pathfinder,
				::Legends.Perk.Adrenaline,
				::Legends.Perk.Recover,
				::Legends.Perk.Student
			],
			[
				::Legends.Perk.CoupDeGrace,
				::Legends.Perk.Bullseye,
				::Legends.Perk.Dodge,
				::Legends.Perk.FortifiedMind,
				::Legends.Perk.HoldOut,
				::Legends.Perk.SteelBrow,
				::Legends.Perk.QuickHands,
				::Legends.Perk.Gifted
			],
			[
				::Legends.Perk.Backstabber,
				::Legends.Perk.Anticipation,
				::Legends.Perk.ShieldExpert,
				::Legends.Perk.Brawny,
				::Legends.Perk.LegendOnslaught,
				::Legends.Perk.LegendTacticalManeuvers,
				::Legends.Perk.RallyTheTroops,
				::Legends.Perk.Taunt,
				::Legends.Perk.LegendFavouredEnemyGhoul,
				::Legends.Perk.LegendFavouredEnemyDirewolf,
				::Legends.Perk.LegendFavouredEnemySpider,
				::Legends.Perk.LegendFavouredEnemyCaravan
			],
			[
				::Legends.Perk.SpecMace,
				::Legends.Perk.SpecFlail,
				::Legends.Perk.SpecHammer,
				::Legends.Perk.SpecAxe,
				::Legends.Perk.SpecCleaver,
				::Legends.Perk.SpecSword,
				::Legends.Perk.SpecDagger,
				::Legends.Perk.SpecPolearm,
				::Legends.Perk.SpecSpear,
				::Legends.Perk.SpecCrossbow,
				::Legends.Perk.SpecBow,
				::Legends.Perk.SpecThrowing
			],
			[
				::Legends.Perk.Underdog,
				::Legends.Perk.LoneWolf,
				::Legends.Perk.ReachAdvantage,
				::Legends.Perk.Overwhelm,
				::Legends.Perk.LegendFavouredEnemySkeleton,
				::Legends.Perk.LegendFavouredEnemyZombie,
				::Legends.Perk.LegendFavouredEnemyOrk,
				::Legends.Perk.LegendFavouredEnemyGoblin,
				::Legends.Perk.LegendFavouredEnemyMercenary,
				::Legends.Perk.LegendFavouredEnemyBandit
			],
			[
				::Legends.Perk.HeadHunter,
				::Legends.Perk.Berserk,
				::Legends.Perk.Nimble,
				::Legends.Perk.BattleForged,
				::Legends.Perk.LegendFavouredEnemyLindwurm,
				::Legends.Perk.LegendFavouredEnemySchrat,
				::Legends.Perk.LegendFavouredEnemyUnhold,
				::Legends.Perk.LegendFavouredEnemyNoble,
				::Legends.Perk.LegendFavouredEnemyBarbarian,
				::Legends.Perk.LegendFavouredEnemyArcher,
				::Legends.Perk.LegendFavouredEnemySwordmaster,
				::Legends.Perk.LegendFavouredEnemySoutherner
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.Duelist,
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.Indomitable,
				::Legends.Perk.LegendFavouredEnemyHexen,
				::Legends.Perk.LegendFavouredEnemyAlps,
				::Legends.Perk.LegendFavouredEnemyVampire,
				::Legends.Perk.LegendFavouredEnemyNomad
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

		if(actor.getBaseProperties().Hitpoints < _targetEntity.getBaseProperties().Hitpoints)
		{
			actor.getBaseProperties().Hitpoints += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Hitpoint from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().Bravery < _targetEntity.getBaseProperties().Bravery)
		{
			actor.getBaseProperties().Bravery += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Resolve from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().Stamina < _targetEntity.getBaseProperties().Stamina)
		{
			actor.getBaseProperties().Stamina += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Stamina from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().MeleeSkill < _targetEntity.getBaseProperties().MeleeSkill)
		{
			actor.getBaseProperties().MeleeSkill += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Melee Attack from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().RangedSkill < _targetEntity.getBaseProperties().RangedSkill)
		{
			actor.getBaseProperties().RangedSkill += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Ranged Attack from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().MeleeDefense < _targetEntity.getBaseProperties().MeleeDefense)
		{
			actor.getBaseProperties().MeleeDefense += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Melee Defense from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().RangedDefense < _targetEntity.getBaseProperties().RangedDefense)
		{
			actor.getBaseProperties().RangedDefense += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Ranged Defense from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}
		if(actor.getBaseProperties().Initiative < _targetEntity.getBaseProperties().Initiative)
		{
			actor.getBaseProperties().Initiative += 1;
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " gained 1 Initiative from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
		}

		local target_skills = _targetEntity.getSkills().getSkillsByFunction(function ( skill )
		{
			return skill.isType(::Const.SkillType.Perk);
		});
		local allperks = [];

		for( local i = 0; i != target_skills.len(); i = i )
		{
			local perk = target_skills[i];

			if (!actor.getSkills().hasSkill(perk.getID()) && perk.getID() != ::Legends.Perks.getID(::Legends.Perk.LegendPacifist)) // ensure the whiners don't get pacifist
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
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " learned " + perk.getName() + " from " + this.Const.UI.getColorizedEntityName(_targetEntity) + "!");
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

