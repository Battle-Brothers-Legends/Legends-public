::mods_hookExactClass("crafting/blueprints/lindwurm_shield_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.HyenaFurUpgrade);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Lindwurm Shield";
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
