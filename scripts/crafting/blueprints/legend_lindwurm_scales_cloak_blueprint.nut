this.legend_lindwurm_scales_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLindwurmScalesCloak);
		this.blueprint.create();
	}
});
