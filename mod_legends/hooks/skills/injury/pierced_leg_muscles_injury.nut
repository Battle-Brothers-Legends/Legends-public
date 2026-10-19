::mods_hookExactClass("skills/injury/pierced_leg_muscles_injury", function (o) {
	o.onAdded <- function () {
		local properties = this.getContainer().getActor().getCurrentProperties();
		if (this.m.IsNew && properties.IsAffectedByInjuries && (!this.m.IsFresh || properties.IsAffectedByFreshInjuries)) {
			::Legends.Effects.grant(this, ::Legends.Effect.LegendImmobilized);
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-30%[/color] " + ::Legends.S.inlineIcon(["melee_defense", "initiative"]);
	}
});
