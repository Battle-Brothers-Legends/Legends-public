this.legend_profession_skill <- this.inherit("scripts/skills/skill", {
	m = {},

	function onAdded() {
		::Legends.Professions.setProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}

	function onRemoved() {
		::Legends.Professions.setProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}

	function onDeath(_fatalityType) {
		::Legends.Professions.setProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}
});
