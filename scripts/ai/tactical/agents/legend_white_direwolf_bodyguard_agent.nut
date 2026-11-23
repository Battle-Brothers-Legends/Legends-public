this.legend_white_direwolf_bodyguard_agent <- this.inherit("scripts/ai/tactical/agents/legend_white_wolf_agent", {
	m = {},
	function create()
	{
		this.legend_white_wolf_agent.create();
	}

	function onAddBehaviors()
	{
		this.legend_white_wolf_agent.onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_protect"));
	}

});

