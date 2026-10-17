this.legend_enraged_hyena_grip_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendEnragedHyenaGrip);
		this.m.Description = "This hyena has locked onto its prey with a powerful bite, holding them firmly in its jaws.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can be removed by attacking the hyena or by disengaging"
			}
		];
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Is currently holding an enemy.";
	}
});
