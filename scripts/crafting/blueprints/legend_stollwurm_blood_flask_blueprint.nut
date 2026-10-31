this.legend_stollwurm_blood_flask_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendStollwurmBloodFlask);
		this.blueprint.create();
	}
});
