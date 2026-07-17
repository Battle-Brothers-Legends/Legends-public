this.profession_legend_skillful_stacking <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendSkillfulStacking);
	}

	function onAdded() {
		this.legend_profession_skill.onAdded();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::Legends.Stash.resize();
	}

	function onRemoved() {
		this.legend_profession_skill.onRemoved();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::Legends.Stash.resize();
	}
});
