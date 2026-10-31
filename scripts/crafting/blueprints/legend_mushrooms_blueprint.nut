this.legend_mushrooms_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendMushrooms);
		this.blueprint.create();
	}
});
