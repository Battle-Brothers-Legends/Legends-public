this.legend_constrained_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendConstrained);
		this.m.Description = "This character is constrained and has trouble moving!";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 3,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Use [color=%negative%]5[/color] more Fatigue per tile traveled"
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Use [color=%negative%]2[/color] more Action Points per tile traveled"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.MovementFatigueCostAdditional += 5;
		_properties.MovementAPCostAdditional += 2;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+2[/color] " + ::Legends.S.inlineIcon("action_points") + " and [color=%positive%]+5[/color] " + ::Legends.S.inlineIcon("fatigue") + " per tile traveled";
	}
});
