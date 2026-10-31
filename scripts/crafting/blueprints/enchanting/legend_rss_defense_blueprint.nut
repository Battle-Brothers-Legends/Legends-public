this.legend_rss_defense_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRssDefense);
		this.legend_rune.create();
	}
});
