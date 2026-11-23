::mods_hookExactClass("entity/world/settlements/situations/disbanded_troops_situation", function(o) {
	local onAdded = o.onAdded;
	o.onAdded = function(_settlement) {
		if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue()) {
			_settlement.setResources(_settlement.getResources() + _settlement.getResources() * 0.035);
		}
		onAdded(_settlement);
	}

	o.onUpdateDraftList = function(_draftList) {
		local add = @(_bg, _amount) array(_amount).apply(@(_) _draftList.push(_bg));

		add("militia_background", 9);
		add("retired_soldier_background", 8);
		add("squire_background", 5);
		add("sellsword_background", 3);
		add("hedge_knight_background", 3);
		add("legend_noble_2h", 2);
		add("legend_noble_ranged", 2);
		add("legend_noble_shield", 2);
		add("legend_master_archer_background", 2);

		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled") {
			add("legend_shieldmaiden_background", 3);
		}
		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			add("legend_man_at_arms_background", 6);
		}
	}
});
