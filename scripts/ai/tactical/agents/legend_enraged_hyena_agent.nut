this.legend_enraged_hyena_agent <- this.inherit("scripts/ai/tactical/agents/hyena_agent", {
	m = {
	},

	function create() {
		this.hyena_agent.create();
		this.m.ID = ::Const.AI.Agent.ID.LegendEnragedHyena;
	}

	function onAddBehaviors() {
		this.hyena_agent.onAddBehaviors();

		// local behavior = this.new("scripts/ai/tactical/behaviors/ai_always_use");
		// behavior.m.PossibleSkills.push(::Legends.Actives.getID(::Legends.Active.LegendEnragedHyenaBite));
		// this.addBehavior(behavior);
	}

	// TODO Build score for bite targets

});
