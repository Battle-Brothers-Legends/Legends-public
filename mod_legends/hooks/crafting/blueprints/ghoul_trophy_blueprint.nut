::mods_hookExactClass("crafting/blueprints/ghoul_trophy_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.GhoulTrophy);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
