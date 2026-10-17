this.legend_patient_hunter_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ApBonus = 0
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPatientHunter);
		this.m.Description = "Has gathered %their% strength after carefully weighing %their% options.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%positive%]+" + this.m.ApBonus + "[/color] Action Points until the end of your turn"
			}
		];
		return ret;
	}

	function onUpdate(_properties) {
		_properties.ActionPoints += this.m.ApBonus;
	}

	function onTurnEnd() {
		this.m.ApBonus = ::Math.min(3, this.getContainer().getActor().getActionPoints());
		if (this.m.ApBonus == 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + ::Math.min(3, this.getContainer().getActor().getActionPoints()) + "[/color] " + ::Legends.S.inlineIcon("action_points");
	}
});
