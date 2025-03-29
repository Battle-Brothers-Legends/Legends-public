::mods_hookExactClass("factions/contracts/item_delivery_action", function(o) 
{
	o.onUpdate = function ( _faction )
	{
		// For settlement faction
		if (_faction.getType() == this.Const.FactionType.Settlement && !_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.deliver_item_contract))
		{
			return;
		}

		// For city-state faction
		if (_faction.getType() !=this.Const.FactionType.Settlement && !_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.getTime().Days <= 3 && this.Math.rand(1, 100) < 20 || this.Math.rand(1, 100) > 10)
		{
			return;
		}

		local settlements = this.World.EntityManager.getSettlements();
		local mySettlement = _faction.getSettlements()[0];
		local candidates = 0;

		foreach( s in settlements )
		{
			if (s.getID() == mySettlement.getID())
			{
				continue;
			}

			if (!s.isDiscovered() || s.isMilitary())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer())
			{
				continue;
			}

			if (mySettlement.isIsolated() || s.isIsolated() || !mySettlement.isConnectedToByRoads(s) || mySettlement.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = s.getTile().getDistanceTo(mySettlement.getTile());

			if (d <= 12 || d > 100)
			{
				continue;
			}

			candidates = ++candidates;
			break;
		}

		if (candidates == 0)
		{
			return;
		}

		this.m.Score = 1;
	}
});