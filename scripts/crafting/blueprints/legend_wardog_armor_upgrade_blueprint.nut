this.legend_wardog_armor_upgrade_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendWardogArmorUpgrade);
		this.blueprint.create();
	}
});
