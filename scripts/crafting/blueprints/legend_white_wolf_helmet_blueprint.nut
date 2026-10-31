this.legend_white_wolf_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendWhiteWolfHelmet);
		this.blueprint.create();
	}
});
