::mods_hookExactClass("skills/effects/goblin_poison_effect", function (o) {
	o.getDescription = function () {
		return "Poison running through %their% veins makes %their% vision blurred, %their% speech slurred and it takes a great deal of effort for %them% to move in a coordinated fashion.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]-" + this.m.TurnsLeft + "[/color] Action Points"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=%negative%]-" + this.m.TurnsLeft + "[/color] Vision"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-" + 10 * this.m.TurnsLeft + "[/color] Initiative"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (this.m.TurnsLeft * _stacks) + "[/color] " + ::Legends.S.inlineIcon("action_points") + ::Legends.S.inlineIcon("vision") + ", [color=%negative%]-" + (10 * this.m.TurnsLeft * _stacks) + "[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
