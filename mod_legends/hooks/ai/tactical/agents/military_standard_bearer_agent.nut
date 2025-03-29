::mods_hookExactClass("ai/tactical/agents/military_standard_bearer_agent", function(o)
{	
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_boost_stamina"));
	}
});
