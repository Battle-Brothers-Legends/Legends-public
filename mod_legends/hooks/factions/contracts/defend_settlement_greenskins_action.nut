::mods_hookExactClass("factions/contracts/defend_settlement_greenskins_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 5;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.defend_settlement_greenskins_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 900)
		{
			return;
		}

		if (!this.World.FactionManager.isGreenskinInvasion() && this.Math.rand(1, 100) > 10)
		{
			return;
		}

		local locations = _faction.getSettlements()[0].getAttachedLocations();
		local targets = 0;

		foreach( l in locations )
		{
			if (l.isActive() && l.isMilitary())
			{
				return;
			}

			if (l.isUsable())
			{
				targets = ++targets;
			}
		}

		if (targets < 2)
		{
			return;
		}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements();

			foreach( b in orcs )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 25)
				{
					tooFar = false;
					break;
				}
			}
		}

		if (tooFar)
		{
			local goblins = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getSettlements();

			foreach( b in goblins )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 25)
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
