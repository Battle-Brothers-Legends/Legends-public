this.legend_helmet_mask_beak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHelmetMaskBeak);
		this.blueprint.create();
	}
});
