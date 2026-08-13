this.profession_legend_gathering <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendGathering);
	}

	function getDynamicTooltip(_def, _active) {
		return [{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png"
				text = "[color=%positive%]10%[/color] increased personal Gathering skill."
			}];
	}

	function onUpdate(_properties){
		_properties.Modifiers.Gathering += 0.1;
	}
});
