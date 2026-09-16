::mods_hookExactClass("factions/contracts/obtain_item_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.obtain_item_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		if (::World.getTime().Days <= 3 && ::Math.rand(1, 100) < 30 || ::Math.rand(1, 100) > 15)
		{
			return;
		}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local bandits = ::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getSettlements();

			foreach( b in bandits )
			{
				if (b.isLocationType(::Const.World.LocationType.Unique))
				{
					continue;
				}

				if (myTile.getDistanceTo(b.getTile()) <= 15)
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
