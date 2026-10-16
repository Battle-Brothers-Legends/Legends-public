this.legend_levitating_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendLevitating);
		this.m.Description = "This character is hovering just above the ground, able to move freely across all terrain until the end of the turn.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
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

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.LegendFlightMovementAPCost;
		actor.m.FatigueCosts = clone ::Const.LegendFlightMovementFatigueCost;
		actor.m.LevelActionPointCost = 0;
	}

	function removeEffect() {
		local actor = this.getContainer().getActor();
		actor.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		actor.m.FatigueCosts = clone ::Const.DefaultMovementFatigueCost;
		actor.m.LevelActionPointCost = ::Const.Movement.LevelDifferenceActionPointCost;
		this.removeSelf();
	}

	function onTurnEnd() {
		this.removeEffect();
	}

	function onCombatFinished() {
		this.removeEffect();
	}
});
