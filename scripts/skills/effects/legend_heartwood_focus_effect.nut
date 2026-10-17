this.legend_heartwood_focus_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHeartwoodFocus);
		this.m.Description = "Imbibed Greenwood Sap, achieving perfect focus, as if time itself has stood still.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "Action Point costs halved"
			}
		]);
		return tooltip;
	}

	function onUpdate(_properties) {
		if (!this.isGarbage()) {
			_properties.IsSkillUseHalfCost = true;
		}
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("action_points") + " costs halved";
	}
});
