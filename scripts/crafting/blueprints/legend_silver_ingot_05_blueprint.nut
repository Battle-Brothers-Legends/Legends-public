this.legend_silver_ingot_05_blueprint <- this.inherit("scripts/crafting/legend_trading_good_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSilverIngot05);
		this.blueprint.create();
	}
});
