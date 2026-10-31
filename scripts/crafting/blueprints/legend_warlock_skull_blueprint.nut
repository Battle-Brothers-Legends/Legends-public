this.legend_warlock_skull_blueprint <- this.inherit("scripts/crafting/legend_warlock_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendWarlockSkull);
		this.legend_warlock_blueprint.create();
		this.m.PreviewCraftable.m.Name = "Warlock Skull Faceplate";
	}
});
