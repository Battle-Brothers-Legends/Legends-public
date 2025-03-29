::mods_hookExactClass("factions/contracts/obtain_item_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.obtain_item_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		if (this.World.getTime().Days <= 3 && this.Math.rand(1, 100) < 30 || this.Math.rand(1, 100) > 15)
		{
			return;
		}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local bandits = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();

			foreach( b in bandits )
			{
				if (b.isLocationType(this.Const.World.LocationType.Unique))
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
