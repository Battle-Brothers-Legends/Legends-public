this.legend_iron_will_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendIronWillPotion);
		this.blueprint.create();
	}
});
