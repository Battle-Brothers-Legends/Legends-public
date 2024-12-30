::mods_hookExactClass("factions/actions/send_ship_action", function(o)
{
	o.m.Dest <- null;

	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _faction )
	{
		onUpdate(_faction);

		if (m.Settlement == null || m.Settlement.numShips() > 1)
			m.Score = 0;
	}

	local onExecute = o.onExecute;
	o.onExecute = function ( _faction )
	{
		local beforeNum = _faction.getUnits().len();
		local result = onExecute(_faction);

		if (_faction.getUnits().len() <= beforeNum || !::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			return result;

		local destination = null;
		local best = 9999;
		local party = _faction.getUnits().top();
		party.setDescription(format("A ship from %s transporting goods and passengers.", m.Settlement.getName()));
		party.getFlags().set("IsCaravan", true);
		local c = party.getController();
		local swim = c.getOrder(::Const.World.AI.Behavior.ID.Swim);

		if (swim == null || swim.m.TargetTile == null)
			return result;

		foreach (settlement in World.EntityManager.getSettlements())
		{
			if (settlement.getID() == m.Settlement.getID()) continue;

			local distance = settlement.getTile().getDistanceTo(swim.m.TargetTile);

			if (distance > best) continue;

			best = distance;
			destination = settlement;
		}

		if (destination == null)
			return result;
		// set up trade
		::Const.World.Common.WorldEconomy.Trade.setupTrade(party, m.Settlement, destination);
		// insert new order
		local dock = ::new("scripts/ai/world/orders/unload_order");
		dock.setController(c);
		c.m.Orders.insert(1, dock);

		return result;
	}
});
