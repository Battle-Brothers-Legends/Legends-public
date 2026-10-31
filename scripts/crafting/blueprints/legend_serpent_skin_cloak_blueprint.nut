this.legend_serpent_skin_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendSerpentSkinCloak);
		this.blueprint.create();
	}
});
