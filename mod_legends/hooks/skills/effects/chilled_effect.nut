::mods_hookExactClass("skills/effects/chilled_effect", function (o) {
	o.getDescription = function () {
		return "Chilled to the bone by cold, with %their% limbs frozen stiff, it takes a great deal of effort to move in a coordinated fashion.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + (1 + this.m.TurnsLeft) + "[/color] Action Points"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + (10 + 20 * this.m.TurnsLeft) + "[/color] Initiative"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-" + (1 + this.m.TurnsLeft) + "[/color] " + ::Legends.S.inlineIcon("action_points") + ", [color=%negative%]-" + (10 + 20 * this.m.TurnsLeft) + "[/color] " + ::Legends.S.inlineIcon("initiative");
	}
});
