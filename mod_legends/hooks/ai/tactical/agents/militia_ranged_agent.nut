::mods_hookExactClass("ai/tactical/agents/militia_ranged_agent", function(o)
{	
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_disengage"));
	}
});
