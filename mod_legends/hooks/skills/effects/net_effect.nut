::mods_hookExactClass("skills/effects/net_effect", function (o) {
	o.getDescription <- function () {
		return this.resolveDescription("A large net holds this character in place and hampers their ability to defend %themselves%. To break free, the net will have to be cut.");
	}

	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local tooltip = getTooltip();
		tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-50%[/color] Block"
		});
		return tooltip;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.5;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-45%[/color] " + ::Legends.Text.inlineIcons(["melee_defense", "ranged_defense", "initiative", "block"]) + ", [color=%negative%]-50%[/color] " + ::Legends.Text.inlineIcons("block") + ", unable to move";
	}
});
