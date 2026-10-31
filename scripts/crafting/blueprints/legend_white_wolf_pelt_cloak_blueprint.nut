this.legend_white_wolf_pelt_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendWhiteWolfPeltCloak);
		this.blueprint.create();
	}
});
