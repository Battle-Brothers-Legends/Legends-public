::mods_hookExactClass("crafting/blueprints/heavy_wardog_armor_upgrade_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.HeavyWardogArmorUpgrade);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
