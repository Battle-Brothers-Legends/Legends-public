this.legend_hexe_leader_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Hexe_leader;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageRanged] = 0.9;
		this.m.Properties.IsRangedUnit = true;
		this.m.Properties.TargetPriorityHitchanceMult = 2.0;
		this.m.Properties.TargetPriorityHitpointsMult = 0.4;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.0;
		this.m.Properties.TargetPriorityFleeingMult = 2.0;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 2.75;
		this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
		this.m.Properties.TargetPriorityArmorMult = 1.0;
		this.m.Properties.TargetPriorityMoraleMult = 0.0;
		this.m.Properties.TargetPriorityBraveryMult = 0.6;
		this.m.Properties.OverallDefensivenessMult = 1.0;
		this.m.Properties.OverallFormationMult = 0.5;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.25;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageRangeMax = 8;
		this.m.Properties.EngageRangeIdeal = 8;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charm"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_hex"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_wither"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_sleep"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_use_potion"));
	}

	function onRoundStarted()
	{
		this.agent.onRoundStarted();

		if (this.Time.getRound() == 1)
		{
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getActor().getFaction());

			foreach( a in allies )
			{
				if (a.getType() != this.Const.EntityType.Hexe && a.getType() != this.Const.EntityType.LegendHexeLeader && !a.isNonCombatant() && !a.getSkills().hasEffect(::Legends.Effect.FakeCharmed) && !a.getSkills().hasEffect(::Legends.Effect.Charmed))
				{
					::Legends.Effects.grant(a, ::Legends.Effect.FakeCharmed);
				}
			}
		}
	}

});

