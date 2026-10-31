this.legend_snake_oil_16_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSnakeOil16);
		this.blueprint.create();
	}
});
