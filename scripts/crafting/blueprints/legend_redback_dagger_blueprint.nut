this.legend_redback_dagger_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRedbackDagger);
		this.blueprint.create();
	}
});
