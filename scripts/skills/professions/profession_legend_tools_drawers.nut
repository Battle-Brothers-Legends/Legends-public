this.profession_legend_tools_drawers <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendToolsDrawers);
	}

	function onAdded() {
		this.legend_profession_skill.onAdded();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateArmorPartsModifier();
	}

	function onRemoved() {
		this.legend_profession_skill.onRemoved();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateArmorPartsModifier();
	}
});
