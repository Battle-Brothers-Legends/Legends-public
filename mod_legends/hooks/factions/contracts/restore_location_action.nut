::mods_hookExactClass("factions/contracts/restore_location_action", function(o) 
{
	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.restore_location_contract))
		{
			return;
		}

		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (_faction.getSettlements()[0].hasSituation("situation.rebuilding_effort"))
		{
			return;
		}

		this.m.Location = null;

		foreach( a in _faction.getSettlements()[0].getAttachedLocations() )
		{
			if (!a.isActive() && a.isUsable() && a.getTile().getDistanceTo(_faction.getSettlements()[0].getTile()) >= 4)
			{
				this.m.Location = a;
				break;
			}
		}

		if (this.m.Location == null)
		{
			return;
		}

		this.m.Score = 1;
	}
});
