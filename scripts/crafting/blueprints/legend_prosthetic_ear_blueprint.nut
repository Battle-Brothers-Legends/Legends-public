this.legend_prosthetic_ear_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticEar);
		this.blueprint.create();
	}
});
