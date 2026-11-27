::mods_hookExactClass("skills/injury/pierced_leg_muscles_injury", function (o) {
	o.onAdded <- function () {
		local properties = this.getContainer().getActor().getCurrentProperties();
		if (::Tactical.isActive() && this.m.IsNew && properties.IsAffectedByInjuries && (!this.m.IsFresh || properties.IsAffectedByFreshInjuries)) {
			::Legends.Effects.grant(this, ::Legends.Effect.LegendImmobilized);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-30%[/color] " + ::Legends.Text.inlineIcons(["melee_defense", "initiative", "block"]);
	}

	o.addTooltipHint <- function (_tooltip) {
		_tooltip.push({
			id = 14,
			type = "text",
			icon = "ui/icons/block.png",
			text = "[color=%negative%]-30%[/color] Block"
		});
		return this.injury.addTooltipHint(_tooltip);
	}	

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties) {
		onUpdate(_properties);
		_properties.BlockMult *= 0.7;
	}
});
