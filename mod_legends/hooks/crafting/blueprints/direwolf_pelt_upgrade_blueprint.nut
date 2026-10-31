::mods_hookExactClass("crafting/blueprints/direwolf_pelt_upgrade_blueprint", function(o)
{
	o.create = function () {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.DirewolfPeltUpgrade);
		this.blueprint.create();
	}

	o.onCraft = function (_stash) {
		this.blueprint.onCraft(_stash);
	}
});
