this.perk_legend_horse_movement <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorseMovement);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.HorseMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.HorseMovementFatigueCost;
	}

});

