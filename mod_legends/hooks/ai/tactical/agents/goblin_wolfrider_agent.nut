::mods_hookExactClass("ai/tactical/agents/goblin_wolfrider_agent", function(o)
{	
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_throw_net"));
	}
});
