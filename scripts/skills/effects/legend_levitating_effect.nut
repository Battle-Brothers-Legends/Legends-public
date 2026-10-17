this.legend_levitating_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		OriginalActionPointCosts = ::Const.DefaultMovementAPCost,
		OriginalFatigueCosts = clone ::Const.DefaultMovementFatigueCost,
		OriginalLevelActionPointCosts = ::Const.Movement.LevelDifferenceActionPointCost
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLevitating);
		this.m.Description = "This character is hovering just above the ground, able to move freely across all terrain until the end of the turn.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Base movement Action Point costs set to [color=%positive%]1[/color]"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "Base movement Fatigue costs set to [color=%positive%]2[/color]"
			}
		]);
		return tooltip;
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		this.m.OriginalActionPointCosts = actor.m.ActionPointCosts;
		this.m.OriginalFatigueCosts = clone actor.m.FatigueCosts;
		this.m.OriginalLevelActionPointCosts = actor.m.LevelActionPointCost;
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = clone ::Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function removeEffect() {
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = this.m.OriginalActionPointCosts;
		actor.m.FatigueCosts = clone this.m.OriginalFatigueCosts;
		actor.m.LevelActionPointCost = this.m.OriginalLevelActionPointCosts;
		this.removeSelf();
	}

	function onTurnEnd() {
		this.removeEffect();
	}

	function onCombatFinished() {
		this.removeEffect();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "Base movement costs set to [color=%positive%]1[/color] " + ::Legends.S.inlineIcon("action_points") + " and [color=%positive%]2[/color] " + ::Legends.S.inlineIcon("fatigue") + " per tile traveled";
	}
});
