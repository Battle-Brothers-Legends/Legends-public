this.legend_rss_durability_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRssDurability);
		this.legend_rune.create();
	}
});
