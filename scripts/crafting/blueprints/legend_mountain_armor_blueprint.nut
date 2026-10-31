this.legend_mountain_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendMountainArmor);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Mountain Armor";
	}
});
