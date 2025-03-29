::mods_hookExactClass("ai/tactical/agents/military_ranged_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 1.0;
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageMelee] = 0.0;
			this.m.Properties.IsRangedUnit = true;
			this.m.Properties.TargetPriorityHitchanceMult = 1.25;
			this.m.Properties.TargetPriorityHitpointsMult = 0.5;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.3;
			this.m.Properties.TargetPriorityFleeingMult = 1.5;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 5.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 1.5;
			this.m.Properties.TargetPriorityArmorMult = 0.5;
			this.m.Properties.OverallDefensivenessMult = 1.0;
			this.m.Properties.OverallFormationMult = 1.0;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 2.7;
		}
	}
});
