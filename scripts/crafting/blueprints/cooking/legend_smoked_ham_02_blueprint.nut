this.legend_smoked_ham_02_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSmokedHam02);
		this.legend_food_blueprint.create();
	}
});
