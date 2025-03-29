::mods_hookExactClass("ai/tactical/agents/orc_young_agent", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Properties.EngageRangeIdeal = 1;
	}

	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
	}
});
