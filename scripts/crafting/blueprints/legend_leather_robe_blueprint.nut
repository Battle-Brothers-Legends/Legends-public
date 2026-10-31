this.legend_leather_robe_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLeatherRobe);
		this.blueprint.create();
	}
});
