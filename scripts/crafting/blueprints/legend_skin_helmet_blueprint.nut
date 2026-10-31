this.legend_skin_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSkinHelmet);
		this.blueprint.create();
	}
});
