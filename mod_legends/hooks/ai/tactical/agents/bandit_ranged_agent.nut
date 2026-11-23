::mods_hookExactClass("ai/tactical/agents/bandit_ranged_agent", function (o) {
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function () {
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/legend_ai_slingstaff_move_into_range"));
	}
});
