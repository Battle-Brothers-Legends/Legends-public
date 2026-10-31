this.legend_bone_platings_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendBonePlatingsUpgrade);
		this.blueprint.create();
	}
});
