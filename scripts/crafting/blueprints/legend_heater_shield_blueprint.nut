this.legend_heater_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {
		PaintInCompanyColors = true
	},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHeaterShield);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Company Heater Shield";
	}
});
