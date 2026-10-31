this.legend_hexen_ichor_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHexenIchorPotion);
		this.blueprint.create();
	}
});
