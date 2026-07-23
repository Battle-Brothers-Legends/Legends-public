this.profession_legend_training <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendTraining);
	}

	function getDynamicTooltip(_def, _active) {
		return [{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]10%[/color] increased personal Training skill."
			}];
	}
});
