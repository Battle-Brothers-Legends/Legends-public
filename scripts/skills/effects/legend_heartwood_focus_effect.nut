this.legend_heartwood_focus_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendHeartwoodFocus);
		this.m.Description = "This character has imbibed Greenwood Sap, achieving perfect focus, as if time itself has stood still. They can use all skills at half their normal Action Point cost.";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getIconDisabled() {
		return "TODO";
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
});
