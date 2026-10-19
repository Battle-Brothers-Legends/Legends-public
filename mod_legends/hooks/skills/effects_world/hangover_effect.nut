::mods_hookExactClass("skills/effects_world/hangover_effect", function (o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 17,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%negative%]" + this.m.HealChance + "%[/color] chance to remove itself on the start of each new day"
		});

		return ret;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "bravery"]);
	}
});
