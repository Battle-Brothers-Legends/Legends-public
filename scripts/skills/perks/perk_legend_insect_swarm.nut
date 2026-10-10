this.perk_legend_insect_swarm <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendInsectSwarm);
	}

	function onAdded() {
		if (!this.m.Container.hasActive(::Legends.Active.Insects)) {
			::Legends.Actives.grant(this, ::Legends.Active.Insects);
		}
	}
	function onRemoved() {
		::Legends.Actives.remove(this, ::Legends.Active.Insects);
	}
});
