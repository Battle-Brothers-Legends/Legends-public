::mods_hookExactClass("ai/tactical/agents/bounty_hunter_melee_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.Defend] = 1.0;
			this.m.Properties.TargetPriorityHitchanceMult = 1.5;
			this.m.Properties.TargetPriorityHitpointsMult = 0.3;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.2;
			this.m.Properties.TargetPriorityFleeingMult = 2.5;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 6.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 0.5;
			this.m.Properties.TargetPriorityArmorMult = 0.75;
			this.m.Properties.OverallDefensivenessMult = 0.5;
			this.m.Properties.OverallFormationMult = 1.0;
			this.m.Properties.EngageFlankingMult = 2.5;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.25;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		}
	}
});
