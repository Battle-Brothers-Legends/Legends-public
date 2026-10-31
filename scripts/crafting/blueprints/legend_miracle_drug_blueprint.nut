this.legend_miracle_drug_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendMiracleDrug);
		this.blueprint.create();
	}
});
