::mods_hookExactClass("ai/tactical/agents/bandit_melee_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		if(::Legends.isLegendaryDifficulty())
			{
			this.m.Properties.TargetPriorityHitchanceMult = 0.9;
			this.m.Properties.TargetPriorityHitpointsMult = 0.7;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.2;
			this.m.Properties.TargetPriorityFleeingMult = 0.5;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 5.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 0.8;
			this.m.Properties.TargetPriorityArmorMult = 0.5;
			this.m.Properties.OverallDefensivenessMult = 1.0;
			this.m.Properties.OverallFormationMult = 1.0;
			this.m.Properties.EngageFlankingMult = 2.5;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 0.25;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		}
	}
});
