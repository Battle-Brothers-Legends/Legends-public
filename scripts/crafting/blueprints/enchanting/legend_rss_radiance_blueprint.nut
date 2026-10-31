this.legend_rss_radiance_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRssRadiance);
		this.legend_rune.create();
	}
});
