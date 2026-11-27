::mods_hookExactClass("skills/injury/broken_leg_injury", function (o) {
	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-40%[/color] Block"
		});
		return this.injury.addTooltipHint(_tooltip);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.Text.inlineIcons(["initiative", "block"]) + ", [color=%positive%]+2[/color] " + ::Legends.Text.inlineIcons("action_points") + " per tile moved";
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.6;
	}
});
