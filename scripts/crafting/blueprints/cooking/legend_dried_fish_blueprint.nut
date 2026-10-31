this.legend_dried_fish_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendDriedFish);
		this.legend_food_blueprint.create();
	}
});
