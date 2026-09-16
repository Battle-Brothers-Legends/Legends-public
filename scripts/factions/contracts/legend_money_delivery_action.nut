this.legend_money_delivery_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_money_delivery_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 5;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_deliver_money_contract))
		{
			return;
		}

		if (::World.getTime().Days <= 3 && ::Math.rand(1, 100) < 20 || ::Math.rand(1, 100) > 10)
		{
			return;
		}

		if (::World.Assets.getMoralReputation() < 40)
		{
			return;
		}

		if (::Math.rand(1, 100) > 20)
		{
			return;
		}

		local settlements = ::World.EntityManager.getSettlements();
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

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_deliver_money_contract");
		contract.setFaction(_faction.getID());
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setOrigin(_faction.getSettlements()[0]);
		contract.setup();
		::World.Contracts.addContract(contract);
	}

});

