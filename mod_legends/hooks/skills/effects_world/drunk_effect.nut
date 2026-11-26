::mods_hookExactClass("skills/effects_world/drunk_effect", function (o) {
	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
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

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.Text.inlineIcons(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "block"]) + ", [color=%positive%]+25%[/color] " + ::Legends.Text.inlineIcons("bravery");
	}
});
