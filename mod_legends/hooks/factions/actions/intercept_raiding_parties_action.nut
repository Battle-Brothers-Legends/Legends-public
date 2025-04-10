::mods_hookExactClass("factions/contracts/intercept_raiding_parties_action", function(o) {
	local onExecute = o.onExecute;
	o.onExecute = function( _faction ) {
		local manager = ::World.Contracts.get();
		local original = manager.addContract;
		manager.addContract = function (_c) {
			if (_c.m.Home == null)
				_c.setHome(_faction.getSettlements()[0]);
			if (_c.m.Origin == null)
				_c.setOrigin(_faction.getSettlements()[0]);
			original(_c);
		}
		onExecute(_faction);
		manager.addContract = original;
	}
});
