this.legend_yummy_sausages_02_blueprint <- this.inherit("scripts/crafting/legend_food_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendYummySausages02);
		this.legend_food_blueprint.create();
	}
});
