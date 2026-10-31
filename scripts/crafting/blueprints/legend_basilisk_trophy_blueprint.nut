this.legend_basilisk_trophy_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendBasiliskTrophy);
		this.blueprint.create();
	}
});
