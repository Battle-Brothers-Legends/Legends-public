this.perk_legend_dedication <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDedication);
	}

	function getCultistPieces() {
		local item = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Head);
		local cultItems = [];
		if (item != null) {
			if (item.isItemType(::Const.Items.ItemType.Cultist)) {
				cultItems.push(item);
			}
			foreach (upgrade in item.m.Upgrades) {
				if (upgrade != null && upgrade.isItemType(::Const.Items.ItemType.Cultist)) {
					cultItems.push(upgrade);
				}
			}
		}
		return cultItems;
	}

	function onAfterUpdate(_properties) {
		if (this.getCultistPieces().len() > 0) {
			local resolveBonus = ::Math.floor(this.getContainer().getActor().getCurrentProperties().getBravery() * 0.15);
			_properties.MeleeDefense += resolveBonus;
			_properties.RangedDefense += resolveBonus;
		}
	}
});
