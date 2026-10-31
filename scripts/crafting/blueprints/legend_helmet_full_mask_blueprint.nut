this.legend_helmet_full_mask_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHelmetFullMask);
		this.blueprint.create();
	}
});
