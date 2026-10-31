this.legend_bandage_tunic_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendBandageTunic);
		this.blueprint.create();
	}
});
