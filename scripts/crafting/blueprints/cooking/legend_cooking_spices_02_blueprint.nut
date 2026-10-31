this.legend_cooking_spices_02_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCookingSpices02);
		this.legend_food_blueprint.create();
	}
});
