::mods_hookExactClass("skills/injury/injured_knee_cap_injury", function (o) {
	o.onAdded <- function () {
		local properties = this.getContainer().getActor().getCurrentProperties();
		if (this.m.IsNew && properties.IsAffectedByInjuries && (!this.m.IsFresh || properties.IsAffectedByFreshInjuries)) {
			::Legends.Effects.grant(this, ::Legends.Effect.LegendImmobilized);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-40%[/color] " + ::Legends.Text.inlineIcons("initiative") + ", [color=%positive%]+2[/color] " + ::Legends.Text.inlineIcons("action_points") + " per tile moved";
	}
});
