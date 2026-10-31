this.legend_sack_hood_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSackHood);
		this.blueprint.create();
	}
});
