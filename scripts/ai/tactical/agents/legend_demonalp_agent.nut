this.legend_demonalp_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {
		PermitedDanger = 3.0
	},
	function create()
	{
		this.agent.create();
		this.m.ID = ::Const.AI.Agent.ID.LegendDemonAlp;
		this.m.Properties.TargetPriorityHitchanceMult = 0.0;
		this.m.Properties.TargetPriorityHitpointsMult = 0.5;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityMoraleMult = 0.25;
		this.m.Properties.TargetPriorityBraveryMult = 0.25;
		this.m.Properties.TargetPriorityHittingAlliesMult = 1.0;
		this.m.Properties.OverallDefensivenessMult = 2.0;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.EngageRangeMin = 7;
		this.m.Properties.EngageRangeMax = 9;
		this.m.Properties.EngageRangeIdeal = 9;
		this.m.Properties.PreferCarefulEngage = true;
		this.m.Properties.PreferWait = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_rotation"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));

		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_sleep"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/legend_ai_alp_realm_of_shadow"));

		local behavior = this.new("scripts/ai/tactical/behaviors/ai_always_use");
		behavior.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendAlpSummonNightmare));
		this.addBehavior(behavior);

		behavior = this.new("scripts/ai/tactical/behaviors/ai_attack_default");
		behavior.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendAlpNightmareManifestation));
		this.addBehavior(behavior);

		behavior = this.new("scripts/ai/tactical/behaviors/ai_engage_ranged");
		behavior.m.PossibleSkills.reverse();
		behavior.m.PossibleSkills.resize(behavior.m.PossibleSkills.len() - 6); // remove the unneeded ones
		behavior.m.PossibleSkills.extend([
			::Legends.Actives.getID(::Legends.Active.LegendAlpRealmOfShadow),
			::Legends.Actives.getID(::Legends.Active.LegendAlpNightmareManifestation)
		]);
		this.addBehavior(behavior);


		//this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_alp_teleport"));
		//this.addBehavior(this.new("scripts/ai/tactical/behaviors/legend_ai_corruption"));
	}

	function onUpdate()
	{
		local b = m.Behaviors[0], myTile = getActor().getTile(), currentDanger = 0.0;
		local skill = ::Legends.Actives.get(getActor(), ::Legends.Active.Nightmare), someoneIsReallyNearMe = false;

		foreach( t in queryPotentialDanger() )
		{
			if (!someoneIsReallyNearMe && t.getTile().getDistanceTo(myTile) <= 2)
				someoneIsReallyNearMe = true;

			local d = b.queryActorTurnsNearTarget(t, myTile, getActor());

			if (d.Turns > 1.0)
				continue;

			currentDanger += 1.0 - d.Turns;
		}

		local dangerLevel = ::Math.maxf(0.0, 1.0 - currentDanger / m.PermitedDanger);

		if (dangerLevel > 0.1)
		{ // not really in danger
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.AttackDefault] = 1.5; // promote the use of "legend_alp_nightmare_manifestation_skill"
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageRanged] = 1.0;
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Miasma] = 1.0;
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Sleep] = 1.0;

			if (someoneIsReallyNearMe && currentDanger <= 0.7) // don't wake them up lol
				skill.m.DoNotUseSkill = true;

			return;
		}

		// considered to be in danger
		m.Properties.BehaviorMult[::Const.AI.Behavior.ID.AttackDefault] = 1.0;
		m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Miasma] = 0.0;
		m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Sleep] = 1.25;

		if (getActor().isEngagedInMelee()) // is highly in danger
		{
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageRanged] = 0.0;
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.Sleep] *= 1.33; // put everyone to sleep
			skill.m.DoNotUseSkill = true;
		}
		else if (dangerLevel > 0.75 && !isAbleToUseSleep())
		{
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageRanged] = 1.33;
		}
		else
		{
			m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageRanged] = 1.1;
		}
	}

	function isAbleToUseSleep()
	{
		local myTile = getActor().getTile(), skill = ::Legends.Actives.get(getActor(), ::Legends.Active.Sleep);
		local targets = getBehavior(::Const.AI.Behavior.ID.Sleep).queryTargetsInMeleeRange(skill.getMinRange(), skill.getMaxRange());

		foreach( t in targets )
		{
			if (skill.onVerifyTarget(myTile, t.getTile()))
	 			return true;
	 	}

		return false;
	}

	function queryPotentialDanger( _includeRanged = false )
	{
		local targets = getKnownOpponents(), potentialDanger = [];

		foreach( t in targets )
		{
			if (t.Actor.isNull() || !t.Actor.isAlive() || !t.Actor.isPlacedOnMap())
				continue;

			if ( // must have combat capability
				t.Actor.getMoraleState() == ::Const.MoraleState.Fleeing
				|| t.Actor.getCurrentProperties().IsStunned
				|| t.Actor.getCurrentProperties().IsRooted
				|| t.Actor.isNonCombatant()
			)
				continue;

			if (!_includeRanged && isRangedUnit(t.Actor)) // use to filter out ranged or not
				continue;

			if ( // is consider as a danger
				t.Actor.getHitpointsPct() < ::Const.AI.Behavior.MinDangerHitpointsPct
				|| t.Actor.getTile().getZoneOfControlCountOtherThan(t.Actor.getAlliedFactions()) >= ::Const.AI.Behavior.IgnoreDangerMinZones
			)
				continue;

			potentialDanger.push(t.Actor.get());
		}

		return potentialDanger;
	}

	function isRangedUnit( _entity )
	{
		if (!(_entity.hasRangedWeapon() || _entity.getAIAgent().getProperties().IsRangedUnit) || _entity.getCurrentProperties().getVision() <= 4)
			return false;

		if (_entity.isPlayerControlled())
			return _entity.getCurrentProperties().getRangedSkill() >= 70;

		return true;
	}

});

