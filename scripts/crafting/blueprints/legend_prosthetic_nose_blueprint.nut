this.legend_prosthetic_nose_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticNose);
		this.blueprint.create();
	}
});
