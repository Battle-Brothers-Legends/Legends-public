::mods_hookExactClass("skills/effects/distracted_effect", function (o) {
	o.getDescription = function () {
		return "Slowed and distracted, having a harder time landing clean strikes after being on the receiving end of a dirty trick.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-35%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-35%[/color] Initiative"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/block.png",
				text = "[color=%negative%]-35%[/color] Block"
			}
		]);
		return tooltip;
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.65;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-35%[/color] " + ::Legends.Text.inlineIcons(["damage_dealt", "initiative", "block"]);
	}
});
