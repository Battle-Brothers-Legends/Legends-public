this.legend_spider_abductions_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_spider_abductions_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.legend_spider_abductions_contract))
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		// Check contract exclusivity
		if (_faction.hasContractExclusion("contract.legend_spider_abductions"))
		{
			return;
		}

		// Check if there are enough forest tiles around the settlement
		local types = [::Const.World.TerrainType.Forest, ::Const.World.TerrainType.LeaveForest, ::Const.World.TerrainType.AutumnForest];
		if (!(_faction.getSettlements()[0].getSurroundingTileTypeProportion(types, 10) >= 0.1 && _faction.getSettlements()[0].getSurroundingTileTypeCount(types, 10, 6) > 10))
		{
			return;
		}

		if (::Math.rand(1, 100) > 10)
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
		local contract = this.new("scripts/contracts/contracts/legend_spider_abductions_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

