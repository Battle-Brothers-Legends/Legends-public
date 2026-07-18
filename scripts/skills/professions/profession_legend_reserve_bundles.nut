this.profession_legend_reserve_bundles <- this.inherit("scripts/skills/legend_profession_skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendReserveBundles);
	}

	function onAdded() {
		this.legend_profession_skill.onAdded();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateAmmoModifier();
	}

	function onRemoved() {
		this.legend_profession_skill.onRemoved();
		if (::World.State.getPlayer() == null) {
			return;
		}
		::World.State.getPlayer().calculateAmmoModifier();
	}
});
