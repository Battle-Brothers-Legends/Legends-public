this.legend_berserker_mushrooms_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendBerserkerMushrooms);
		this.blueprint.create();
	}
});
