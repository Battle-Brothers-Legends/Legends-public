this.legend_heater_shield_blueprint <- this.inherit("scripts/crafting/blueprint", {
	m = {},

	function create() {
		::Legends.Blueprints.onCreate(this, ::Legends.Blueprint.LegendHeaterShield);
		this.blueprint.create();
		this.m.PreviewCraftable.m.Name = "Company Heater Shield";
	}

	function onCraft(_stash) {
		local item = ::new(this.m.ItemScript);
		item.onPaintInCompanyColors();
		_stash.add(item);
	}
});
