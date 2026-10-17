this.legend_summoned_bear_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSummonedBear);
		this.m.Description = "Summoned a bear, and may not summon another this combat.";
		this.m.IsRemovedAfterBattle = true;
	}

	function onCombatFinished() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Already summoned a bear";
	}
});
