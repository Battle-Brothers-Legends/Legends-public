this.legend_cloak_noble_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	
	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCloakNoble);
		this.blueprint.create();
	}
});
