this.hedge_knight_less_flanking_less_zoc <- this.inherit("scripts/ai/tactical/agents/bounty_hunter_melee_agent_less_flanking", {
	m = {},
	function create()
	{
		this.bounty_hunter_melee_agent_less_flanking.create();
		this.m.Properties.EngageFlankingMult = 1.00;
		this.m.Properties.EngageTargetMultipleOpponentsMult = 0.5;
	}
});