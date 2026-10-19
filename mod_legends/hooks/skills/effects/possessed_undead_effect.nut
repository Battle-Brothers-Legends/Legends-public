::mods_hookExactClass("skills/effects/possessed_undead_effect", function (o) {
	o.m.IsControlledByPlayer <- false;

	o.getDescription <- function () {
		return "Possessed and empowered by a master.";
	}

	o.getTooltip <- function (_activeEntity, _stacks = 1) {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Action points set to [color=%positive%]12[/color]"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%positive%]+50[/color] Initiative"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=%positive%]+15[/color] Melee Skill"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%positive%]+10[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%positive%]+10[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=%negative%]-25[/color] Damage received"
			}
		]);
		return tooltip;
	}

	o.setPlayerControlled <- function (_v) {
		this.m.IsControlledByPlayer = _v;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("action_points") + " set to [color=%positive%]12[/color], [color=%positive%]+50[/color] " + ::Legends.S.inlineIcon("initiative") + ", [color=%positive%]+15[/color] " + ::Legends.S.inlineIcon("melee_skill") + ", [color=%positive%]+10[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense"]) + ", [color=%negative%]-25[/color] " + ::Legends.S.inlineIcon("damage_received");
	}
});
