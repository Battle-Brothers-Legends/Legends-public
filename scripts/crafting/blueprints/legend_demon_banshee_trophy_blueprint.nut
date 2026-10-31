this.legend_demon_banshee_trophy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendDemonBansheeTrophy);
		this.blueprint.create();
	}
});
