this.legend_horn_plate_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHornPlate);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Kraken Horn Plate";
	}
});
