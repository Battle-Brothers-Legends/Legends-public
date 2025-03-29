this.legend_basilisk_drone_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create(); 
		this.m.ID = this.Const.AI.Agent.ID.BasiliskDrone;
		this.m.Properties.TargetPriorityHitchanceMult = 0.4;
		this.m.Properties.TargetPriorityHitpointsMult = 0.2;
		this.m.Properties.TargetPriorityRandomMult = 0.5;
		this.m.Properties.TargetPriorityDamageMult = 2.25;
		this.m.Properties.TargetPriorityFleeingMult = 1.0;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishOpponentMult = 1.8;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 2.0;
		this.m.Properties.OverallFormationMult = 0.1;
		this.m.Properties.EngageFlankingMult = 3.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 2.5;
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
	}

	function onUpdate()
	{
		if (this.getActor().getHitpointsPct() < 1.0 && this.Math.rand(1, 100) <= 25)
		{
			this.m.Properties.EngageAgainstSpearwallMult = 0.5;
		}
		else
		{
			this.m.Properties.EngageAgainstSpearwallMult = 0.2;
		}
	}

});

