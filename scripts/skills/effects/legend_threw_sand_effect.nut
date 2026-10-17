this.legend_threw_sand_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendThrewSand);
		this.m.Description = "Thrown sand from %their% pockets and can't do so again this battle.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Already thrown sand.";
	}
});
