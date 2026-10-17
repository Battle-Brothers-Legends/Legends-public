this.legend_inspired_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false,
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendInspired);
		this.m.Description = "Inspired by hearing just the right words, ready to go to their limits and beyond.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Action Point increased by [color=%positive%]4[/color]"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		_properties.ActionPoints += 4;
	}

	function applyEffect() {
		if (!this.m.IsApplied) {
			local actor = this.getContainer().getActor();
			actor.setActionPoints(::Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			this.m.IsApplied = true;
		}
	}

	function onTurnStart() {
		this.applyEffect();
	}

	function onResumeTurn() {
		this.applyEffect();
	}

	function onTurnEnd() {
		this.removeSelf();
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+4[/color] " + ::Legends.S.inlineIcon("action_points");
	}
});
