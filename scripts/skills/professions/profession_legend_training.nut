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
				text = "[color=%positive%]10%[/color] increased personal Training skill."
			}];
	}

	function onUpdate(_properties){
		_properties.Modifiers.Training += 0.1;
	}
});
