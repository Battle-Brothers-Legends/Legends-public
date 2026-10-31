this.legend_smoked_ham_01_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSmokedHam01);
		this.legend_food_blueprint.create();
	}
});
