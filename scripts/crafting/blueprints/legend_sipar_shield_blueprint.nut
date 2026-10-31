this.legend_sipar_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSiparShield);
		this.blueprint.create();
	}
});
