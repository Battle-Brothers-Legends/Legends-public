this.legend_happy_powder_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHappyPowder);
		this.blueprint.create();
	}
});
