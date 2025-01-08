::mods_hookExactClass("ai/tactical/agents/vampire_agent", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		if (::Legends.isLegendaryDifficulty())
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
});
