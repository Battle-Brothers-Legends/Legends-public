::mods_hookExactClass("skills/injury_permanent/missing_ear_injury", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10%[/color] " + ::Legends.Text.inlineIcons(["initiative", "block"]);
	}

	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-10%[/color] Block"
		});
		return this.permanent_injury.addTooltipHint(_tooltip);
	}	

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.9;
	}
});
