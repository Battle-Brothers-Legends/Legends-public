this.legend_rsh_luck_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRshLuck);
		this.legend_rune.create();
	}
});
