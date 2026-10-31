this.legend_curry_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCurry);
		this.legend_food_blueprint.create();

	}
});
