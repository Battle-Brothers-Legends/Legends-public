this.legend_gold_ingot_02_blueprint <- this.inherit("scripts/crafting/legend_trading_good_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendGoldIngot02);
		this.blueprint.create();
	}
});
