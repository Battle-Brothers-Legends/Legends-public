this.legend_tower_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
		PaintInCompanyColors = true
	},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendTowerShield);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Company Tower Shield";
	}
});
