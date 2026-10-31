this.legend_cloak_common_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	
	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCloakCommon);
		this.blueprint.create();
	}
});
