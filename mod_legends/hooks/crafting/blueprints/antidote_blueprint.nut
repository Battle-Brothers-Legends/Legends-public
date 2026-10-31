::mods_hookExactClass("crafting/blueprints/antidote_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.Antidote);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
