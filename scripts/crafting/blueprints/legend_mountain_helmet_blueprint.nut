this.legend_mountain_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendMountainHelmet);
		this.blueprint.create();
	}
});
