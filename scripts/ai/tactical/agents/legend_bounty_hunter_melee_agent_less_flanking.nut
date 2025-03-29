this.legend_bounty_hunter_melee_agent_less_flanking <- this.inherit("scripts/ai/tactical/agents/bounty_hunter_melee_agent", {
	m = {},
	function create()
	{
		this.bounty_hunter_melee_agent.create();
		this.m.Properties.EngageFlankingMult = 1.00;
	}
});

