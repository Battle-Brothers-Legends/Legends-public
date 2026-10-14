::mods_hookExactClass("ai/tactical/agents/orc_warrior_agent", function(o) {	
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function () {
		onAddBehaviors();
		this.addBehavior(::new("scripts/ai/tactical/behaviors/ai_charge"));
	}
});
