this.legend_huge_quiver_of_bolts_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHugeQuiverOfBolts);
		this.blueprint.create();
	}
});
