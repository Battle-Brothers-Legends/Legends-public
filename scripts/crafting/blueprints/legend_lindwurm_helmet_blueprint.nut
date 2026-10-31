this.legend_lindwurm_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLindwurmHelmet);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Lindwurm\'s Helmet";
	}
});
