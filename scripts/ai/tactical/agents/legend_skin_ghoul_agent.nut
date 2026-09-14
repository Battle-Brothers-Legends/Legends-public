this.legend_skin_ghoul_agent <- this.inherit("scripts/ai/tactical/agents/ghoul_agent", {
	m = {},
	function create() {
		this.ghoul_agent.create();
		this.m.ID = this.Const.AI.Agent.ID.LegendSkinGhoul;
		this.m.Properties.TargetPriorityHittingAlliesMult = 3.0;
		this.m.Properties.EngageRangeMax = 2;
	}

	function onAddBehaviors() {
		this.ghoul_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.getBehavior(this.Const.AI.Behavior.ID.Swing).m.MinTargets = 1;
	}
});

