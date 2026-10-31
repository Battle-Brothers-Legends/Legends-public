this.legend_oblivion_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendOblivionPotion);
		this.blueprint.create();
	}
});
