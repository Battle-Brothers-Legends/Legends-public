this.legend_dried_lamb_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendDriedLamb);
		this.legend_food_blueprint.create();
	}
});
