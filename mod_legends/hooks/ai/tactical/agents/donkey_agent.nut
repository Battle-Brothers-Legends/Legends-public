::mods_hookExactClass("ai/tactical/agents/donkey_agent", function(o)
{	
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Properties.OverallDefensivenessMult = 20.0;
		this.m.Properties.OverallFormationMult = 10.0;
	}

	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function ()
	{
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend"));
	}
});
