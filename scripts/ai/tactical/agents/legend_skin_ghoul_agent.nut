this.legend_skin_ghoul_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.LegendSkinGhoul;
		this.m.Properties.TargetPriorityHitchanceMult = 0.7;
		this.m.Properties.TargetPriorityHitpointsMult = 1.0;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 1.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 4.5;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.3;
		this.m.Properties.TargetPriorityMoraleMult = 0.4;
		this.m.Properties.TargetPriorityBraveryMult = 0.4;
		this.m.Properties.OverallDefensivenessMult = 2.0;
		this.m.Properties.OverallFormationMult = 2.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.25;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.75;
		this.m.Properties.EngageFlankingMult = 1.5;
		this.m.Properties.PreferCarefulEngage = true;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_roam"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_gruesome_feast"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swallow_whole"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
	}

	function onUpdate()
	{
		this.m.Properties.OverallDefensivenessMult = 2.0 - (this.m.Actor.getSize() - 1) * 0.5;
		local ghouls = 0;
		local nonGhouls = 0;

		foreach( ally in this.m.KnownAllies )
		{
			if (ally.getFlags().has("ghoul"))
			{
				ghouls = ++ghouls;
			}
			else
			{
				nonGhouls = ++nonGhouls;
			}
		}

		local strategy = this.Tactical.Entities.getStrategy(this.getActor().getFaction());

		if (!strategy.getStats().IsEngaged && this.m.Actor.getAttackedCount() == 0 && this.Time.getRound() <= 3 && ghouls < nonGhouls)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.0;
			this.m.Properties.PreferWait = true;
		}
		else
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 1.0;
			this.m.Properties.PreferWait = false;
		}
	}

});

