::mods_hookExactClass("skills/injury_permanent/brain_damage_injury", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "A hard hit to the head shook some things up and didn\'t exactly benefit this character\'s cognitive skills. On the bright side, %they% may now be just too stupid to realize when it\'s time to run.";
	}

	o.addTooltipHint <- function (_tooltip) {
		_tooltip.extend({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gets more irritated while reading"
		});
		return this.injury.addTooltipHint(_tooltip);
	}	

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.Text.inlineIcons(["xp_received", "initiative"]) + ", [color=%negative%]-25%[/color] " + ::Legends.Text.inlineIcons("bravery");
	}
});
