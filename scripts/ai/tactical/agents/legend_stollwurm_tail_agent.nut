this.legend_stollwurm_tail_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.LegendStollwurm;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.25;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 0.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.25;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 0.0;
		this.m.Properties.OverallFormationMult = 0.75;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		this.m.Properties.EngageLockDownTargetMult = 2.0;
		this.m.Properties.PreferCarefulEngage = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_move_tail"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_move_tentacle"));
		this.getBehavior(this.Const.AI.Behavior.ID.Swing).m.MinTargets = 1;
		this.getBehavior(this.Const.AI.Behavior.ID.Thresh).m.MinTargets = 3;
	}

});

