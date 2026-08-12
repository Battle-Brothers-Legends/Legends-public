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

		add(::Legends.Background.Deserter, 6);
		add(::Legends.Background.Militia, 9);
		add(::Legends.Background.RetiredSoldier, 8);
		add(::Legends.Background.Squire, 5);
		add(::Legends.Background.Sellsword, 3);
		add(::Legends.Background.HedgeKnight, 3);
		add(::Legends.Background.LegendHouseGuard, 2);
		add(::Legends.Background.LegendArbalester, 2);
		add(::Legends.Background.LegendFootSoldier, 2);
		add(::Legends.Background.LegendMasterArcher, 2);

		if (::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue() > 0) {
			add(::Legends.Background.LegendShieldmaiden, 3);
		}
		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			add(::Legends.Background.LegendManAtArms, 6);
		}
	}
});
