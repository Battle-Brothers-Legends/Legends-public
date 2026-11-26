::mods_hookExactClass("skills/injury/sickness_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.Text.inlineIcons(["health", "fatigue", "melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "bravery", "block"]) + ", [color=%negative%]-2[/color] " + ::Legends.Text.inlineIcons("vision");
	}

	o.addTooltipHint <- function (_tooltip) {
		_tooltip.extend({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-25%[/color] Block"
		});
		return this.injury.addTooltipHint(_tooltip);
	}	

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.75;
	}
});
