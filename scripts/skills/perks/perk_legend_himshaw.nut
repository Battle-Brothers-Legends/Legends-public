this.perk_legend_himshaw <- this.inherit("scripts/skills/skill", {
	m = {
		RepairedAfterCombatToday = false
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHimshaw);
	}

	function getBonus(_item, _percentage) {
		if (_item) {
			return ::Math.min((_item.getArmorMax() - _item.getArmor()), ::Math.max(0, ::Math.floor(_item.getArmorMax() * _percentage)));
		} else {
			return 0;
		}
	}

	function repair(_percentage) {
		local actor = this.getContainer().getActor();
		local repaired = false;
		foreach (item in [actor.getItems().getItemAtSlot(::Const.ItemSlot.Head), actor.getItems().getItemAtSlot(::Const.ItemSlot.Body)]) {
			if (item) {
				local added = this.getBonus(item, _percentage);
				if (added > 0) {
					item.setArmor(item.getArmor() + added);
					repaired = true;
				}
			}
		}
		return repaired;
	}

	function onCombatFinished() {
		if (!this.m.RepairedAfterCombatToday && repair(0.2)) {
			this.m.RepairedAfterCombatToday = true;
		}
	}

	function onNewDay() {
		repair(0.1);
		this.m.RepairedAfterCombatToday = false;
	}

	function getDynamicTooltip(_actor = null) {
		local tooltip = [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=%positive%]" + this.getBonus(_actor.getItems().getItemAtSlot(::Const.ItemSlot.Head), 0.1) + "[/color] Head Armor repaired at the start of the next day"
			},
			{
				id = 3,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=%positive%]" + this.getBonus(_actor.getItems().getItemAtSlot(::Const.ItemSlot.Body), 0.1) + "[/color] Body Armor repaired at the start of the next day"
			}
		];
		if (!this.m.RepairedAfterCombatToday) {
			tooltip.extend([
				{
					id = 3,
					type = "text",
					icon = "ui/icons/armor_head.png",
					text = "[color=%positive%]" + this.getBonus(_actor.getItems().getItemAtSlot(::Const.ItemSlot.Head), 0.2) + "[/color] Head Armor repaired at the end of combat"
				},
				{
					id = 3,
					type = "text",
					icon = "ui/icons/armor_body.png",
					text = "[color=%positive%]" + this.getBonus(_actor.getItems().getItemAtSlot(::Const.ItemSlot.Body), 0.2) + "[/color] Body Armor repaired at the end of combat"
				}
			]);
		} else {
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "Already repaired after combat today"
			});
		}
		return tooltip;
	}
});
