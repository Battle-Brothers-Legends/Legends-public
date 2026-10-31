this.legend_cheese_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCheese);
		this.legend_food_blueprint.create();
	}
});
