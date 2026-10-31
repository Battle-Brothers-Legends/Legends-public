this.legend_dried_fruits_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendDriedFruits);
		this.legend_food_blueprint.create();
	}
});
