this.legend_recovery_potion_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendRecoveryPotion);
		this.blueprint.create();
	}
});
