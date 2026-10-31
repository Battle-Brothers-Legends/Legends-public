this.legend_lindwurm_scale_armor_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendLindwurmScaleArmor);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Lindwurm Scales";
	}
});
