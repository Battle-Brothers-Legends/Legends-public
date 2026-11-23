::mods_hookExactClass("ai/tactical/agents/orc_berserker_agent", function (o) {
	local onAddBehaviors = o.onAddBehaviors;
	o.onAddBehaviors = function () {
		onAddBehaviors();
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_adrenaline"));
	}
});
