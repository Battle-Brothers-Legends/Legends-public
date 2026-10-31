this.legend_hexen_leader_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHexenLeaderCloak);
		this.blueprint.create();
	}
});
