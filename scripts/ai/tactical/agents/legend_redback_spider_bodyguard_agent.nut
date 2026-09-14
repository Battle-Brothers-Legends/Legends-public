this.legend_redback_spider_bodyguard_agent <- this.inherit("scripts/ai/tactical/agents/legend_redback_spider_agent", {
	m = {},
	function create()
	{
		this.legend_redback_spider_agent.create();
	}

	function onAddBehaviors()
	{
		this.legend_redback_spider_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
	}

});

