this.legend_porridge_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendPorridge);
		this.legend_food_blueprint.create();
	}
});
