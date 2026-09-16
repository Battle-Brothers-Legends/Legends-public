this.legend_bandit_army_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_bandit_army_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = ::Math.rand(145, 175) * 0.01;
	}

	function onUpdate( _faction )
	{
		// For settlement faction
		if (_faction.getType()==::Const.FactionType.Settlement && !_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_bandit_army_contract))
		{
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() < 1200)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() < 2)
		{
			return;
		}

		//if (::World.getTime().Days <= 3 && ::Math.rand(1, 100) < 33 || ::Math.rand(1, 100) > 25)
		//{
		//	return;
		//}

		local tooFar = true;
		local myTile = _faction.getSettlements()[0].getTile();

		if (tooFar)
		{
			local bandits = ::World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).getSettlements();

			foreach( b in bandits )
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

		if (_faction.getSettlements().len() < 3)
		{
			return;
		}

		local numConnected = 0;

		foreach( s in _faction.getSettlements() )
		{
			if (!s.isIsolatedFromRoads() && s.isDiscovered())
			{
				numConnected = ++numConnected;
			}
		}

		if (numConnected < 3)
		{
			return;
		}


		local minResources = ::Const.World.LegendaryContract.BanditArmy * ::Const.World.ContractCost.BanditArmy + ::Const.World.ContractCost.BanditArmy;

		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * ::Const.World.ContractCost.BanditArmy;

		if(currentResources < minResources)
		{
			return;
		}
		else
		{
			::Const.World.LegendaryContract.BanditArmy += 1;
		}

		this.m.Score = 5;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_bandit_army_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		::World.Contracts.addContract(contract);
	}

});

