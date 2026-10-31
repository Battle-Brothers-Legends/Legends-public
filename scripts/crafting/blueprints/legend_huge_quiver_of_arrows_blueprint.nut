this.legend_huge_quiver_of_arrows_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHugeQuiverOfArrows);
		this.blueprint.create();
	}
});
