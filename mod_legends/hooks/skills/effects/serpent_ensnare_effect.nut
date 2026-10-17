::mods_hookExactClass("skills/effects/serpent_ensnare_effect", function (o) {
	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Knockback and Grab";
	}

	o.getDescription <- function () {
		return "Entangled by a giant serpent, tighter and tighter with every turn.";
	}

	o.getTooltip = function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]Unable to move[/color]"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]Unable to use skills[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]10[/color] Hitpoints Damage Received every turn"
			}
		]);
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "Unable to move and use skills, [color=%negative%]10[/color] " + ::Legends.S.inlineIcon("damage_received") + " every turn";
	}
});
