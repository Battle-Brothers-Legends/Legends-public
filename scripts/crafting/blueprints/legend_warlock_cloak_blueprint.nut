this.legend_warlock_cloak_blueprint <- this.inherit("scripts/crafting/legend_warlock_blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendWarlockCloak);
		this.legend_warlock_blueprint.create();
		this.m.PreviewCraftable.m.Name = "Warlock Cloak";
	}
});
