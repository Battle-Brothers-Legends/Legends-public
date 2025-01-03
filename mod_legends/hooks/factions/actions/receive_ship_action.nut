::mods_hookExactClass("factions/actions/receive_ship_action", function(o)
{
	local onUpdate = o.onUpdate;
	o.onUpdate = function ( _faction )
	{
		onUpdate(_faction);

		if (this.m.Settlement == null || this.m.Settlement.numShips() > 1)
			this.m.Score = 0;
	}

	local onExecute = o.onExecute;
	o.onExecute = function ( _faction )
	{
		local beforeNum = _faction.getUnits().len();
		local result = onExecute(_faction);

		if (_faction.getUnits().len() <= beforeNum || !::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
			return result;

		local party = _faction.getUnits().top();
		local c = party.getController();
		local start = null;
		local best = 9999;
		local curentTile = party.getTile();

		foreach (settlement in World.EntityManager.getSettlements())
		{
			if (settlement.getID() == m.Settlement.getID()) continue;

			local distance = settlement.getTile().getDistanceTo(curentTile);

			if (distance > best) continue;

			best = distance;
			start = settlement;
		}

		if (start == null)
			return result;

		party.setDescription(format("A ship from %s transporting goods and passengers.", start.getName()));
		party.getFlags().set("IsCaravan", true);
		// set up trade
		::Const.World.Common.WorldEconomy.Trade.setupTrade(party, start, m.Settlement);
		// insert new order
		local dock = ::new("scripts/ai/world/orders/unload_order");
		dock.setController(c);
		c.m.Orders.insert(1, dock);

		return result;
	}
});
