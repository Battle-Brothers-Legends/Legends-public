this.legend_mummy_queen_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.LegendMummyQueen;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.0;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 1.0;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityArmorMult = 0.5;
		this.m.Properties.OverallDefensivenessMult = 1.0;
		this.m.Properties.OverallFormationMult = 0.5;
		this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
		this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
		this.m.Properties.EngageAgainstSpearwallMult = 0.0;
		this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
		this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
		this.m.Properties.EngageLockDownTargetMult = 1.0;

		if(::Legends.isLegendaryDifficulty())
			{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.TargetPriorityHitchanceMult = 1.5;
			this.m.Properties.TargetPriorityHitpointsMult = 0.25;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.5;
			this.m.Properties.TargetPriorityFleeingMult = 3.0;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityArmorMult = 0.5;
			this.m.Properties.OverallDefensivenessMult = 2.0;
			this.m.Properties.OverallFormationMult = 0.3;
			this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
			this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
			this.m.Properties.EngageOnGoodTerrainBonusMult = 2.0;
			this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
			this.m.Properties.EngageAgainstSpearwallMult = 0.0;
			this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.0;
			this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 2.0;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 2.0;
			this.m.Properties.EngageLockDownTargetMult = 1.0;
			}

	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_gash"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_riposte"));
	}

});

