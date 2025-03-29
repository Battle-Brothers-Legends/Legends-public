::mods_hookExactClass("ai/tactical/agents/military_melee_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		if(::Legends.isLegendaryDifficulty())
		{
			this.m.Properties.TargetPriorityHitchanceMult = 0.9;
			this.m.Properties.TargetPriorityHitpointsMult = 0.8;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.35;
			this.m.Properties.TargetPriorityFleeingMult = 0.5;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 5.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 1.5;
			this.m.Properties.TargetPriorityArmorMult = 0.6;
			this.m.Properties.OverallDefensivenessMult = 2.5;
			this.m.Properties.OverallFormationMult = 3.5;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 0.25;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 2.0;
		}
	}

	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_boost_stamina"));
	}
});
