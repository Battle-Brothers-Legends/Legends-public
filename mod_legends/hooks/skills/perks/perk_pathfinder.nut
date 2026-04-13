::mods_hookExactClass("skills/perks/perk_pathfinder", function(o) {
	o.onAdded <- function ()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendClimb))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendClimb);
		}
	}

	o.onRemoved <- function ()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendClimb);
	}
});