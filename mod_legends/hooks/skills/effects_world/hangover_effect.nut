::mods_hookExactClass("skills/effects_world/hangover_effect", function (o) {
	local getTooltip = o.getTooltip;
	o.getTooltip = function () {
		local ret = getTooltip();
		ret.push({
			id = 17,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=%negative%]%_healChance%%[/color] chance to remove itself on the start of each new day",
			param = [["_healChance", this.m.HealChance]]
		});

		return ret;
	}

	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-10%[/color] Block"
		});
		return this.injury.addTooltipHint(_tooltip);
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.9;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10%[/color] " + ::Legends.Text.inlineIcons(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "bravery", "block"]);
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-10%[/color] " + ::Legends.Text.inlineIcons(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "initiative", "bravery"]);
	}
});
