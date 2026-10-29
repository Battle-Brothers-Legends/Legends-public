this.perk_legend_dedication <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDedication);
	}

	function getCultistPieces(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		local item = actor.getItems().getItemAtSlot(::Const.ItemSlot.Head);
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

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return ::Math.floor(actor.getCurrentProperties().getBravery() * 0.15);
	}

	function onAfterUpdate(_properties) {
		if (this.getCultistPieces().len() > 0) {
			local resolveBonus = this.getBonus();
			_properties.MeleeDefense += resolveBonus;
			_properties.RangedDefense += resolveBonus;
		}
	}

	function getDynamicTooltip(_actor = null) {
		if (this.getCultistPieces(_actor).len() > 0) {
			local bonus = this.getBonus(_actor);
			return [
				{
					id = 3,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=%positive%]+" + bonus + "[/color] Melee Defense"
				},
				{
					id = 3,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=%positive%]+" + bonus + "[/color] Ranged Defense"
				}
			];
		} else {
			return [];
		}
	}
});
