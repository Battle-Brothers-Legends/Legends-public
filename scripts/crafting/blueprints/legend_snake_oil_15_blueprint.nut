this.legend_snake_oil_15_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSnakeOil15);
		this.blueprint.create();
	}
});
