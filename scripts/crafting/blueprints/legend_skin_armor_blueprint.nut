this.legend_skin_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSkinArmor);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Skinghoul Armor";
	}
});
