::mods_hookExactClass("skills/effects/web_effect", function (o) {
	o.getDescription <- function () {
		return "A large and sticky web holds this character in place and hampers %their% ability to defend %themselves% and to put real force behind any blows. To break free, the web will have to be cut.";
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
		return "[color=%negative%]-50%[/color] " + ::Legends.Text.inlineIcons(["damage_dealt", "melee_defense", "ranged_defense", "initiative", "block"]) + ", [color=%negative%]+100%[/color]" + ::Legends.Text.inlineIcons("damage_received") + ", from webknechts, unable to move, more likely to get attacked";
	}
});
