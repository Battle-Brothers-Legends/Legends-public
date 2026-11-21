this.legend_mountain_helmet_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendMountainHelmet);
		this.blueprint.create();
		// the craft is the whole helmet: hood, helm, top and vanity in one piece
		this.m.PreviewCraftable = this.createHelmet();
	}

	function createHelmet() {
		return ::Legends.Items.pickHelmet([[1, ::Legends.Helmet.Legendary.legend_mountain_helmet]]);
	}

	function onCraft(_stash) {
		for (local i = 0; i < this.m.Crafts; i++) {
			_stash.add(this.createHelmet());
		}
	}
});
