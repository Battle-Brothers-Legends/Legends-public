this.legend_yummy_sausages_01_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendYummySausages01);
		this.legend_food_blueprint.create();
	}
});
