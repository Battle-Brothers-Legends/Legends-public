::mods_hookExactClass("crafting/blueprints/snake_oil_03_blueprint", function (o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.SnakeOil03);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}

	o.isCraftable = function () {
		return this.blueprint.isCraftable();
	}

	o.isQualified = function () {
		return this.blueprint.isQualified();
	}
});
