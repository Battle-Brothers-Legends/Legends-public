this.perk_legend_horse_passage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHorsePassage);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.Const.HorsePassageMovementAPCost;
		actor.m.FatigueCosts = clone this.Const.HorsePassageMovementFatigueCost;
	}

});

