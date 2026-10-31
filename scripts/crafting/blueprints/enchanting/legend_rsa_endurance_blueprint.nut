this.legend_rsa_endurance_blueprint <- this.inherit("scripts/crafting/legend_rune", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRsaEndurance);
		this.legend_rune.create();
	}
});
