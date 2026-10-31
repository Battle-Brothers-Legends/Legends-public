this.legend_cooking_spices_01_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCookingSpices01);
		this.legend_food_blueprint.create();
	}
});
