::mods_hookExactClass("skills/perks/perk_pathfinder", function(o) {
	o.onAdded <- function ()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendClimb))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendClimb);
		}
	}

	o.onUpdate <- function( _properties ) {
		local actor = this.getContainer().getActor();
		if (!actor.getSkills().hasSkill("injury.maimed_foot")) {
			actor.m.ActionPointCosts = ::Const.PathfinderMovementAPCost; // pathfinder counters 1 extra AP cost from maimed foot in the injury
		}
		actor.m.FatigueCosts = clone ::Const.PathfinderMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	o.onRemoved <- function ()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendClimb);
	}
});