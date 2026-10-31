this.legend_prosthetic_foot_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendProstheticFoot);
		this.blueprint.create();
	}
});
