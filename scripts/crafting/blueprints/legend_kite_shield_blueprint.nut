this.legend_kite_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendKiteShield);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Company Kite Shield";
	}

	function onCraft(_stash) {
		local item = this.new("scripts/items/shields/kite_shield");
		item.onPaintInCompanyColors();
		_stash.add(item);
	}
});
