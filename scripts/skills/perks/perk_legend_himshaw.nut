this.perk_legend_himshaw <- this.inherit("scripts/skills/skill", {
	m = {
		RepairedAfterCombatToday = false
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHimshaw);
	}

	function onCombatFinished()	{
		if (!this.m.RepairedAfterCombatToday && repair(0.2)) {
			this.m.RepairedAfterCombatToday = true;
		}
	}

	function repair(_toRepair) {
		local actor = this.getContainer().getActor();
		local repaired = false;
		foreach(item in [actor.getItems().getItemAtSlot(::Const.ItemSlot.Head), actor.getItems().getItemAtSlot(::Const.ItemSlot.Body)]) {
			if (item) {
				local missing = item.getArmorMax() - item.getArmor();
            	local added = ::Math.min(missing, ::Math.max(0, ::Math.floor(item.getArmorMax() * _toRepair)));
				if (added > 0) {
					item.setArmor(item.getArmor() + added);
					repaired = true;
				}
			}
		}

		return repaired;
	}

	function onNewDay()	{
		repair(0.1);
		this.m.RepairedAfterCombatToday = false;
	}

});
