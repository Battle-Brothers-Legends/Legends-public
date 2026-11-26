::mods_hookExactClass("skills/injury/bruised_leg_injury", function (o) {
	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-20%[/color] Block"
		});
		return this.injury.addTooltipHint(_tooltip);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-20%[/color] " + ::Legends.Text.inlineIcons(["initiative", "block"]) + ", [color=%positive%]+1[/color] " + ::Legends.Text.inlineIcons("action_points") + " per tile moved";
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.8;
	}
});
