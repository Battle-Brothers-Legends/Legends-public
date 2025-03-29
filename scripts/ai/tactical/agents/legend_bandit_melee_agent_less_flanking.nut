this.legend_bandit_melee_agent_less_flanking <- this.inherit("scripts/ai/tactical/agents/bandit_melee_agent", {
	m = {},
	function create()
	{
		this.bandit_melee_agent.create();
		this.m.Properties.EngageFlankingMult = 1.0;
	}
});

