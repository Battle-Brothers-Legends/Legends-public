::mods_hookExactClass("ai/tactical/agents/militia_melee_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Properties.TargetPriorityFleeingMult = 0.8;
		this.m.Properties.TargetPriorityFinishOpponentMult = 5.0;
		this.m.Properties.OverallDefensivenessMult = 9.0;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.25;

		if (::Legends.isLegendaryDifficulty())
		{
			this.m.Properties.TargetPriorityHitchanceMult = 0.9;
			this.m.Properties.TargetPriorityHitpointsMult = 0.5;
			this.m.Properties.TargetPriorityRandomMult = 0.0;
			this.m.Properties.TargetPriorityDamageMult = 0.5;
			this.m.Properties.TargetPriorityFleeingMult = 1.5;
			this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
			this.m.Properties.TargetPriorityFinishOpponentMult = 4.0;
			this.m.Properties.TargetPriorityCounterSkillsMult = 1.5;
			this.m.Properties.TargetPriorityArmorMult = 0.6;
			this.m.Properties.OverallDefensivenessMult = 4.0;
			this.m.Properties.OverallFormationMult = 1.5;
			this.m.Properties.EngageTargetMultipleOpponentsMult = 1.5;
			this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.5;
		}
	}

	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
	}
});
