this.legend_levitating_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLevitating);
		this.m.Description = "This character is hovering just above the ground, able to move freely across all terrain until the end of the turn.";
		this.m.Icon = "ui/perks/levitate.png";
		this.m.IconMini = "perk_37_mini";
		this.m.Overlay = "perk_37";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = ::Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function onTurnEnd()
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = ::Const.Movement.LevelDifferenceActionPointCost;
		this.removeSelf();
	}

	function onCombatFinished()
	{
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = ::Const.Movement.LevelDifferenceActionPointCost;
		this.removeSelf();
	}

});
