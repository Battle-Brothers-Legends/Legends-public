this.legend_catapult_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Idle;
		this.m.Properties.OverallMagnetismMult = 10.0;
		this.m.Properties.OverallDefensivenessMult = 20.0;
		this.m.Properties.OverallFormationMult = 10.0;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 1.0;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.0;
		this.m.Properties.IsRangedUnit = true;
		this.m.Properties.TargetPriorityHitchanceMult = 0.6;
		this.m.Properties.TargetPriorityHitpointsMult = 0.2;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.2;
		this.m.Properties.TargetPriorityFleeingMult = 0.5;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.5;
		this.m.Properties.OverallDefensivenessMult = 1.1;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.OverallHideMult = 0.75;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.35;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.5;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));

	}

	function onUpdate()
	{
	}

});

