this.legend_warlock_hood_blueprint <- this.inherit("scripts/crafting/legend_warlock_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendWarlockHood);
		this.legend_warlock_blueprint.create();
	}
});
