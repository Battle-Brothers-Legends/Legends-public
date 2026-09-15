::mods_hookExactClass("factions/contracts/drive_away_barbarians_action", function(o) 
{
	o.onUpdate = function ( _faction )
	{
		if (!::Const.DLC.Wildmen || ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians) == null)
		{
			return;
		}

		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.drive_away_barbarians_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		if (::World.getTime().Days <= 3 && ::Math.rand(1, 100) < 33 || ::Math.rand(1, 100) > 25)
		{
			return;
		}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local bandits = ::World.FactionManager.getFactionOfType(::Const.FactionType.Barbarians).getSettlements();

			foreach( b in bandits )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 12)
				{
					tooFar = false;
					break;
				}
			}
		}

		if (tooFar)
		{
			return;
		}

		this.m.Score = 1;
	}
});