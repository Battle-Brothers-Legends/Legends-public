this.legend_fermented_unhold_heart_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendFermentedUnholdHeart);
		this.legend_food_blueprint.create();
	}
});
