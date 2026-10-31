this.legend_pauldrons_kraken_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendPauldronsKraken);
		this.blueprint.create();
	}
});
