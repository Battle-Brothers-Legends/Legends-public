this.legend_small_medicine_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSmallMedicine);
		this.blueprint.create();
	}
});
