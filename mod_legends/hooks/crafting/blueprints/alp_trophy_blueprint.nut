::mods_hookExactClass("crafting/blueprints/alp_trophy_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.AlpTrophy);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
