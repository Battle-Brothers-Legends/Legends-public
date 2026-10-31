this.legend_cat_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendCatPotion);
		this.blueprint.create();
	}
});
