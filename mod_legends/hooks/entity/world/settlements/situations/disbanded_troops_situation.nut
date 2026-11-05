::mods_hookExactClass("entity/world/settlements/situations/disbanded_troops_situation", function(o) {
	local onAdded = o.onAdded;
	o.onAdded = function(_settlement) {
		_settlement.setResources(_settlement.getResources() * 1.035);
		onAdded(_settlement);
	}

	o.onUpdateDraftList = function(_draftList) {
		::Legends.Array.extend(_draftList, ::Legends.Background.Deserter, 6);
		::Legends.Array.extend(_draftList, ::Legends.Background.Militia, 9);
		::Legends.Array.extend(_draftList, ::Legends.Background.RetiredSoldier, 8);
		::Legends.Array.extend(_draftList, ::Legends.Background.Squire, 5);
		::Legends.Array.extend(_draftList, ::Legends.Background.Sellsword, 3);
		::Legends.Array.extend(_draftList, ::Legends.Background.HedgeKnight, 3);
		::Legends.Array.extend(_draftList, ::Legends.Background.LegendHouseGuard, 2);
		::Legends.Array.extend(_draftList, ::Legends.Background.LegendArbalester, 2);
		::Legends.Array.extend(_draftList, ::Legends.Background.LegendFootSoldier, 2);
		::Legends.Array.extend(_draftList, ::Legends.Background.LegendMasterArcher, 2);

		if (::Legends.Mod.ModSettings.getSetting("FemaleGenderPercent").getValue() > 0) {
			::Legends.Array.extend(_draftList, ::Legends.Background.LegendShieldmaiden, 3);
		}
		if (::World.Assets.getOrigin().getID() == "scenario.militia") {
			::Legends.Array.extend(_draftList, ::Legends.Background.LegendManAtArms, 6);
		}
	}
});
