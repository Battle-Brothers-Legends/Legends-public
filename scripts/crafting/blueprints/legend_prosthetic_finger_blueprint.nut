this.legend_prosthetic_finger_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticFinger);
		this.blueprint.create();
	}
});
