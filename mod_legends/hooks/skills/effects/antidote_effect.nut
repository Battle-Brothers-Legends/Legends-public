::mods_hookExactClass("skills/effects/antidote_effect", function (o) {
	local onAdded = o.onAdded;
	o.onAdded = function () {
		onAdded();
		while (this.getContainer().hasEffect(::Legends.Effect.LegendRedbackSpiderPoison)) {
			::Legends.Effects.remove(this.getContainer(), ::Legends.Effect.LegendRedbackSpiderPoison);
		}
	}

	o.getDescription = function () {
		return "Has taken an antidote.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/immunity.png",
			text = "Immune to Poison"
		});
		return tooltip;
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-50%[/color] " + ::Legends.S.inlineIcon("bravery");
	}
})
