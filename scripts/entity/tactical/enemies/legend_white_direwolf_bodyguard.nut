this.legend_white_direwolf_bodyguard <- this.inherit("scripts/entity/tactical/enemies/legend_white_direwolf", {
	m = {},
	function create()
	{
		this.legend_white_direwolf.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_white_direwolf_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

});