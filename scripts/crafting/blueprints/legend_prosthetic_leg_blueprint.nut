this.legend_prosthetic_leg_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticLeg);
		this.blueprint.create();
	}
});
