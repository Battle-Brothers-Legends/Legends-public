this.legend_summoned_hound_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSummonedHound);
		this.m.Description = "Summoned a hound, and may not summon another this combat.";
		this.m.IsRemovedAfterBattle = true;
	}

	function onCombatFinished() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Already summoned a hound";
	}
});
