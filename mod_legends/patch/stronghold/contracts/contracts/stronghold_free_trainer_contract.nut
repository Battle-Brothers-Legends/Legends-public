::mods_hookExactClass("contracts/contracts/stronghold_free_trainer_contract", function (o) {

	local addToCombat = o.addToCombat;
	o.addToCombat = function (_list, _entityType, _champion = false, _name = "") {
		if (_list.len() == 2 && _entityType == ::Const.World.Spawn.Troops.BarbarianChampion) {
			_entityType = ::Const.World.Spawn.Troops.LegendBarbarianBloodletter;
		}

		addToCombat(_list, _entityType, _champion, _name);
	}
});
