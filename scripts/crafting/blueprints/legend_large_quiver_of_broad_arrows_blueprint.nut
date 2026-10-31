this.legend_large_quiver_of_broad_arrows_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLargeQuiverOfBroadArrows);
		this.blueprint.create();
	}
});
