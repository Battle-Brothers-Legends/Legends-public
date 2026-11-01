this.legend_kite_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
		PaintInCompanyColors = true
	},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendKiteShield);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Company Kite Shield";
	}
});
