this.legend_vala_currently_chanting_effect <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendValaCurrentlyChanting);
		this.m.Order = ::Const.SkillOrder.VeryLast + 6;
	}

	function isHidden() {
		return false;
	}

	function getTooltip() {
		if (!this.isHidden()) {
			return [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 10,
					type = "text",
					icon = "ui/icons/special.png",
					text = "This character is currently chanting."
				}
			];
		} else {
			return;
		}
	}

	function onRemoved() {
		local ChantDisharmony = ::Legends.Perks.get(this.getContainer().getActor(), ::Legends.Perk.LegendValaChantDisharmony);
		local ChantFury = ::Legends.Perks.get(this.getContainer().getActor(), ::Legends.Perk.LegendValaChantFury);

		if (ChantDisharmony != null) {
			ChantDisharmony.resetChant();
		}
		if (ChantFury != null) {
			ChantFury.resetChant();
		}
	}

	function onUpdate(_properties) {
		_properties.TargetAttractionMult *= 1.33;
	}

	function onCombatFinished() {
		this.removeSelf();
	}
});
