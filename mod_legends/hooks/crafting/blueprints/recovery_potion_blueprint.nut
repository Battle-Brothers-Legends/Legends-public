::mods_hookExactClass("crafting/blueprints/recovery_potion_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.RecoveryPotion);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
