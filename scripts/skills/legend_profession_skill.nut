this.legend_profession_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function onAdded() {
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()));
	}

	function onRemoved() {
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()));
	}

	function onDeath(_fatalityType) {
		::Legends.Professions.setProfessionEffect(::Legends.Professions.findById(this.getID()));
	}
});
