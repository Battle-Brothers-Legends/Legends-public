::mods_hookExactClass("ai/tactical/agents/skeleton_melee_agent", function(o)
{	
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_gash")); //mainly for mummies
	}
});
