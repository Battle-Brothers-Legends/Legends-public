this.legend_cloak_heavy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	
	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCloakHeavy);
		this.blueprint.create();
	}
});
