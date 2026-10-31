this.legend_demon_alp_trophy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendDemonAlpTrophy);
		this.blueprint.create();
	}
});
