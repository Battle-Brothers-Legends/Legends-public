this.perk_legend_mastery_nets <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryNets);
	}

	function onUpdate(_properties) {
		_properties.IsSpecializedInNets = true;
		local item = getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (item != null && item.isItemType(::Const.Items.ItemType.Net) && (item.getAmmoMax() == 0 || item.getAmmo() > 0)) {
			_properties.MeleeDefense += 10;
		}
	}
});
