::mods_hookExactClass("skills/perks/perk_bullseye", function(o) {
	o.onAdded <- function()
	{
		if (!this.getContainer().hasActive(::Legends.Active.LegendMarkTarget) && this.getContainer().getActor().isPlayerControlled())
		{
			this.getContainer().add(this.new("scripts/skills/actives/legend_mark_target_skill"));
		}
	}

	o.onRemoved <- function()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMarkTarget);
	}
});