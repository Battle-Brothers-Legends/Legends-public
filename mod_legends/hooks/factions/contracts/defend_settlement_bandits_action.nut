::mods_hookExactClass("factions/contracts/defend_settlement_bandits_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 5;
	}

	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.defend_settlement_bandits_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() < 500)
		{
			return;
		}

		if (::Math.rand(1, 100) > 10)
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
			local bandits = ::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getSettlements();

			foreach( b in bandits )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 20)
				{
					tooFar = false;
					break;
				}
			}
		}

		if (tooFar)
		{
			local zombies = ::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getSettlements();

			foreach( b in zombies )
			{
				if (myTile.getDistanceTo(b.getTile()) <= 20)
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
