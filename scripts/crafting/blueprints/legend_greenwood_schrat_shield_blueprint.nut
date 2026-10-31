this.legend_greenwood_schrat_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendGreenwoodSchratShield);
		this.blueprint.create();
	}
});
