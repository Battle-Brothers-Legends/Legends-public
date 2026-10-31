this.legend_redback_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRedbackHelmet);
		this.blueprint.create();
	}
});
