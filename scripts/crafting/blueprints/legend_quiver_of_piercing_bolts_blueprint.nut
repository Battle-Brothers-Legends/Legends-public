this.legend_quiver_of_piercing_bolts_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendQuiverOfPiercingBolts);
		this.blueprint.create();
	}
});
