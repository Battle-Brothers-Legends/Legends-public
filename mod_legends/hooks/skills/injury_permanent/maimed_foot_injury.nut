this.mods_hookExactClass("skills/injury_permanent/maimed_foot_injury", function (o) {
	o.onUpdate <- function ( _properties ) {
		if (!::Legends.Perks.has(this.getContainer().getActor(), ::Legends.Perk.Pathfinder)) // pathfinder counters extra ap costs here, but doesn't give its regular -AP effect in the hook
			_properties.MovementAPCostAdditional += 1;
		_properties.InitiativeMult *= 0.8;
		_properties.IsContentWithBeingInReserve = true;
	}
});
