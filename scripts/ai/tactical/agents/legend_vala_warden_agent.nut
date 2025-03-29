this.legend_vala_warden_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Ghost;

		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Protect] = 1.5;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackBow] = 0.5;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.AttackDefault] = 1.0;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.3;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.2;
		this.m.Properties.TargetPriorityFleeingMult = 0.6;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityFinishTreshhold = 1.2;
		this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
		this.m.Properties.TargetPriorityFinishArmorMult = 1.5;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
		this.m.Properties.TargetPriorityArmorMult = 1.0;
		this.m.Properties.TargetPriorityMoraleMult = 0.0;
		this.m.Properties.TargetPriorityBraveryMult = 0.0;
		this.m.Properties.TargetPriorityAoEMult = 1.0;
		this.m.Properties.OverallMagnetismMult = 1.0;
		this.m.Properties.OverallDefensivenessMult = 1.0;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.OverallHideMult = 0.0;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 0.2;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 1.33;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.75;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.33;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;
		this.m.Properties.EngageFlankingMult = 1.0;
		this.m.Properties.EngageRangeIdeal = 1;
		this.m.Properties.EngageRangeMax = 1;
		this.m.Properties.EngageRangeMin = 1;
		this.m.Properties.EngageTileLimit = 0;
		this.m.Properties.EngageEnemiesInLinePreference = 1;
		this.m.Properties.PreferWait = false;
		this.m.Properties.PreferCarefulEngage = true;
		this.m.Properties.IgnoreTargetValueOnEngage = false;
		this.m.Properties.IsRangedUnit = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/legend_vala_warden_ai_melee_attack"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/legend_vala_warden_ai_ranged_attack"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/legend_vala_warden_ai_protect"));
	}

	function onUpdate()
	{
		this.getStrategy().compileKnownOpponents();
	}
});
