this.legend_beggar_commander_op_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = ::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBeggarScaling);
		this.m.Name = "Framed Beggar";
		this.m.Icon = "ui/backgrounds/background_18.png";
		this.m.BackgroundDescription = "Beggars aren\'t the most determined persons, and living on the street tends to be detrimental to their health.";
		this.m.GoodEnding = "Having enough of all the fighting, %name% the once-beggar retired from the %companyname%. You know the %person% made a pretty crown in %their% time with the mercenary company, yet the other day you saw %them% out begging again. You asked if %they%\'d wasted all %their% money and %they% laughed. %They% said %they%\'d purchased land and was doing just fine. Then %they% held out %their% little tin and asked for a crown. You gave %them% two.";
		this.m.BadEnding = "The fighting life is a rough one, and %name% the once-beggar saw fit to retire from it before it became a deadly one. Unfortunately, %they% went back to beggaring. Word has it that a nobleman cleaned a city of riff-raff and sent them marching north despite it being winter. Cold and hungry, %name% died on the side of a road, a tin cup frozen to %their% finger.";
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
		this.m.BackgroundType = this.Const.BackgroundType.Lowborn;
		this.m.AlignmentMin = this.Const.LegendMod.Alignment.Dreaded;
		this.m.AlignmentMax = this.Const.LegendMod.Alignment.Saintly;
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
				::Legends.Perk.LegendFavouredEnemyBeast,
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
				::Legends.Perk.LegendFavouredEnemyUndead,
				::Legends.Perk.LegendFavouredEnemyGreenskin,
				::Legends.Perk.LegendFavouredEnemyCivilization,
				::Legends.Perk.LegendFavouredEnemyOutlaw
			],
			[
				::Legends.Perk.HeadHunter,
				::Legends.Perk.Berserk,
				::Legends.Perk.Nimble,
				::Legends.Perk.BattleForged,
				::Legends.Perk.LegendFavouredEnemySwordmaster,
			],
			[
				::Legends.Perk.Fearsome,
				::Legends.Perk.Duelist,
				::Legends.Perk.KillingFrenzy,
				::Legends.Perk.Indomitable,
				::Legends.Perk.LegendFavouredEnemyOccult,
			],
			[],
			[],
			[],
			[]
		];
	}

	function setGender( _gender = -1 ) {
		if (_gender == -1) _gender = this.setCommanderGender();
		_gender ? this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale}) : this.setBodyCharacteristics(_gender, {Hairs = ::Const.Hair.UntidyMale, Beards = ::Const.Beards.Untidy});
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
		return ::Legends.Backgrounds.getStats(::Legends.Background.LegendCommanderBeggarScaling);
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

