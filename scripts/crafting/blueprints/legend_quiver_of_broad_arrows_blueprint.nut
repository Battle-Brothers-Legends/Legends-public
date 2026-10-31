this.legend_quiver_of_broad_arrows_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendQuiverOfBroadArrows);
		this.blueprint.create();
	}
});
