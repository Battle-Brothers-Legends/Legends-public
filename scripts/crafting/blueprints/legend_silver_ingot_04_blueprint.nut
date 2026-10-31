this.legend_silver_ingot_04_blueprint <- this.inherit("scripts/crafting/legend_trading_good_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSilverIngot04);
		this.blueprint.create();
	}
});
