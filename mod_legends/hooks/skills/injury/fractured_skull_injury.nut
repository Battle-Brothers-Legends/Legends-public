::mods_hookExactClass("skills/injury/fractured_skull_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.Text.inlineIcons(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "block"]) + ", [color=%negative%]-2[/color] " + ::Legends.Text.inlineIcons("vision");
	}

	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-50%[/color] Block"
		});
		return this.injury.addTooltipHint(_tooltip);
	}	

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.5;
	}
});
