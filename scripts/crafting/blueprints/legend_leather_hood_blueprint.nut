this.legend_leather_hood_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLeatherHood);
		this.blueprint.create();
	}
});
