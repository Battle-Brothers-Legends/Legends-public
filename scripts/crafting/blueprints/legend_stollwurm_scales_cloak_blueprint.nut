this.legend_stollwurm_scales_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendStollwurmScalesCloak);
		this.blueprint.create();
	}
});
