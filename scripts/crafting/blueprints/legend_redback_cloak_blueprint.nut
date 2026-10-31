this.legend_redback_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRedbackCloak);
		this.blueprint.create();
	}
});
