::mods_hookExactClass("skills/perks/perk_bullseye", function(o) {
	o.onAdded <- function()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendMarkTarget) && this.getContainer().getActor().isPlayerControlled())
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMarkTarget);
		}
	}

	o.onRemoved <- function()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMarkTarget);
	}
});