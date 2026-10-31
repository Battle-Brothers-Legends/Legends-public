this.legend_stollwurm_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendStollwurmHelmet);
		this.blueprint.create();
	}
});
