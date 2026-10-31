this.legend_redback_poison_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRedbackPoison);
		this.blueprint.create();
	}
});
