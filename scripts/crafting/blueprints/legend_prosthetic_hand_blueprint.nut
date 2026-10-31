this.legend_prosthetic_hand_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticHand);
		this.blueprint.create();
	}
});
