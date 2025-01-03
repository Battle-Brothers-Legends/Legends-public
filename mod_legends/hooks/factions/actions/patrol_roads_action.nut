::mods_hookExactClass("factions/actions/patrol_roads_action", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Cooldown = 200.0;
	}

	local onExecute = o.onExecute;
	o.onExecute = function ( _faction ) {
		local party = null;
		_faction.setSpawnListener(function(entity) {
			party = entity;
		});
		onExecute(_faction);
		foreach (order in party.getController().getOrders()) {
			if (::mods_isClass(order, "wait_order") != null)
				order.setTime(this.Math.rand(5, 40));
		}
		this.m.Cooldown = this.World.FactionManager.isGreaterEvil() ? 150.0 : 300.0;
	}
});
