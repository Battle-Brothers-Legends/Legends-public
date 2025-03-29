this.legend_redback_spider_bodyguard <- this.inherit("scripts/entity/tactical/enemies/legend_redback_spider", {
	m = {},
	function create()
	{
		this.legend_redback_spider.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_redback_spider_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

});