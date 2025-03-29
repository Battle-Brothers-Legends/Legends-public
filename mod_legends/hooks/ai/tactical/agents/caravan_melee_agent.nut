::mods_hookExactClass("ai/tactical/agents/caravan_melee_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 1.5;
		this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 0.5;
		this.m.Properties.TargetPriorityFinishOpponentMult = 5.0;
		this.m.Properties.OverallDefensivenessMult = 1.25;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.5;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 2.0;
			this.m.Properties.TargetPriorityHitchanceMult = 0.9;
			this.m.Properties.TargetPriorityHitpointsMult = 0.6;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.35;
			this.m.Properties.TargetPriorityFleeingMult = 1.25;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 3.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 1.5;
			this.m.Properties.TargetPriorityArmorMult = 0.6;
			this.m.Properties.OverallDefensivenessMult = 20.0;
			this.m.Properties.OverallFormationMult = 2.0;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 5.5;
		}
	}

	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_shieldwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_riposte"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_switchto_ranged"));
	}
});
