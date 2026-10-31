this.legend_tabard_noble_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendTabardNoble);
		this.blueprint.create();
	}
});
