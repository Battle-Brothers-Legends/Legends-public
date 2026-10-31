::mods_hookExactClass("crafting/blueprints/large_powder_bag_blueprint", function(o) {
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LargePowderBag);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
