this.legend_roots_and_berries_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRootsAndBerries);
		this.legend_food_blueprint.create();
	}
});
