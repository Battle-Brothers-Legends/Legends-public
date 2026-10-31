this.legend_heartwood_sap_flask_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHeartwoodSapFlask);
		this.blueprint.create();
	}
});
