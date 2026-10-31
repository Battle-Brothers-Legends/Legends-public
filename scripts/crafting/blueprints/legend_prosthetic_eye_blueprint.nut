this.legend_prosthetic_eye_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticEye);
		this.blueprint.create();
	}
});
