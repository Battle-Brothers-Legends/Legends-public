this.legend_ai_buff_howl <- this.inherit("scripts/ai/tactical/behavior", {
	m = {
		PossibleSkills = [
			::Legends.Actives.getID(::Legends.Active.LegendWerewolfHowl),
			::Legends.Actives.getID(::Legends.Active.LegendWhiteWolfHowl)
		],
		Skill = null
	},
	function create()
	{
		this.m.ID = ::Const.AI.Behavior.ID.Howl;
		this.m.Order = ::Const.AI.Behavior.Order.Howl;
		this.behavior.create();
	}

	function onEvaluate( _entity )
	{
		this.m.Skill = null;
		local score = this.getProperties().BehaviorMult[this.m.ID];

		if (_entity.getActionPoints() < ::Const.Movement.AutoEndTurnBelowAP)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (_entity.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownOpponent())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		if (!this.getAgent().hasKnownAllies())
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local targets = this.queryTargetsInMeleeRange();

		if (targets.len() != 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		local skills = [];

		foreach( skillID in this.m.PossibleSkills )
		{
			local skill = _entity.getSkills().getSkillByID(skillID);

			if (skill != null && skill.isUsable() && skill.isAffordable())
			{
				skills.push(skill);
			}
		}

		if (skills.len() == 0)
		{
			return ::Const.AI.Behavior.Score.Zero;
		}

		this.m.Skill = skills[::Math.rand(0, skills.len() - 1)];
		local knownAllies = this.getAgent().getKnownAllies();
		local allies = 0;

		foreach( a in knownAllies )
		{
			if (_entity.getTile().getDistanceTo(a.getTile()) <= 6 && a.getFlags().has("werewolf"))
			{
				allies = ++allies;
			}
		}

		if (::Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Other Werewolves in range to howl with: " + allies);
		}

		if (allies >= ::Const.AI.Behavior.HowlMinAlliesInRange)
		{
			local scoreMult = ::Math.minf(1.5, allies / 4.0);
			return ::Const.AI.Behavior.Score.Howl * scoreMult * score;
		}

		return ::Const.AI.Behavior.Score.Zero;
	}

	function onExecute( _entity )
	{
		if (::Const.AI.VerboseMode)
		{
			this.logInfo("* " + _entity.getName() + ": Using Howl!");
		}

		this.m.Skill.use(_entity.getTile());

		if (!_entity.isHiddenToPlayer())
		{
			this.getAgent().declareAction();
		}

		this.m.Skill = null;
		return true;
	}

});

