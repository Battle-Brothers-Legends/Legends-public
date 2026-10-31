this.legend_unhold_fur_cloak_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendUnholdFurCloak);
		this.blueprint.create();
	}
});
