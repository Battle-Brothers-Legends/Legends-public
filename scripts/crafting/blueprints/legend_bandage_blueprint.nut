this.legend_bandage_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendBandage);
		this.blueprint.create();
	}
});
