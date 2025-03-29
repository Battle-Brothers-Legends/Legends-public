this.legend_barbarian_prisoner_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_barbarian_prisoner_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
	}

	function onUpdate( _faction )
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		// For settlement faction
		if (_faction.getType()==this.Const.FactionType.Settlement && !_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.legend_barbarian_prisoner_contract))
		{
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1200)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		local currentTile = _faction.getSettlements()[0].getTile();

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.7)
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

			if (!s.isDiscovered())
			{
				continue;
			}

			if (!s.isAlliedWith(_faction.getID()))
			{
				continue;
			}

			if (mySettlement.isIsolated() || s.isIsolated() || !mySettlement.isConnectedToByRoads(s) || mySettlement.isCoastal() && s.isCoastal())
			{
				continue;
			}

			local d = s.getTile().getDistanceTo(mySettlement.getTile());

			if (d <= 15 || d > 100)
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

		local minResources = this.Const.World.LegendaryContract.BarbPrison * this.Const.World.ContractCost.BarbPrison + this.Const.World.ContractCost.BarbPrison;

		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * this.Const.World.ContractCost.BarbPrison;

		if(currentResources < minResources)
		{
			return;
		}
		else
		{
			this.Const.World.LegendaryContract.BarbPrison += 1;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_barbarian_prisoner_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setOrigin(_faction.getSettlements()[0]);
		contract.setup();
		this.World.Contracts.addContract(contract);
	}

});

