this.legend_pack_large_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendPackLarge);
		this.blueprint.create();
	}
});
