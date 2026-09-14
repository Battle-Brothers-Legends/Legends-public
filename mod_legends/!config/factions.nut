::Legends.Factions <- {
	/*
		Simple helper function that adds new factions with all respective fields set
	*/
	add = function(_color, _bust = "", _allies = []) {
		local newID = ::Const.Faction.COUNT;
		// ensure related lists are right size
		while (::Const.FactionColor.len() <= ::Const.Faction.COUNT)
			::Const.FactionColor.push(::createColor("#ffffff"));
		while (::Const.FactionBase.len() <= ::Const.Faction.COUNT)
			::Const.FactionBase.push("");
		while (::Const.FactionAlliance.len() <= ::Const.Faction.COUNT)
			::Const.FactionAlliance.push([]);
		::Const.Faction.COUNT++;
		::Const.FactionBase[newID] = _bust;
		::Const.FactionAlliance[newID].push(newID); // adds self to allies so parties of same faction don't attack each other
		foreach (ally in _allies) {
			::Const.FactionAlliance[newID].push(ally);
			::Const.FactionAlliance[ally].push(newID);
		}
		return newID;
	}
}

// add new legends factions
::Const.FactionType.FreeCompany <- ::Const.FactionType.COUNT++;
::Const.Faction.FreeCompany <- ::Legends.Factions.add("#ffffff", "bust_base_militia", [
	::Const.Faction.Civilian,
	::Const.Faction.OrientalCityState,
	::Const.Faction.NobleHouse
]);

::Const.FactionType.DummyFaction <- ::Const.FactionType.COUNT++;
::Const.Faction.DummyFaction <- ::Legends.Factions.add("#ffffff");

//was 20, set to 0 due to greenskin crisis becoming uncontrollable. Currently a quick fix and will need to be looked at further!! (28/11/21 by Luft)
::Const.Factions.GreaterEvilStrengthOnTownDestroyed = 0.0;
