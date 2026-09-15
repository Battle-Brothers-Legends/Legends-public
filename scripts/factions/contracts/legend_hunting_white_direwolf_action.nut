this.legend_hunting_white_direwolf_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_hunting_white_direwolf_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = ::Math.rand(145, 175) * 0.01;
	}

	function onUpdate( _faction )
	{

		if (!::Const.DLC.Unhold)
		{
			return;
		}

		
		// For settlement faction
		if (_faction.getType()==::Const.FactionType.Settlement && !_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_hunting_white_direwolf_contract))
		{
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() < 900)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (this.isKindOf(village, "legends_snow_village") || this.isKindOf(village, "small_snow_village") || this.isKindOf(village, "medium_snow_village"))
		{
			return;
		}

		local minResources = ::Const.World.LegendaryContract.WhiteWolf * ::Const.World.ContractCost.WhiteWolf + ::Const.World.ContractCost.WhiteWolf;

		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * ::Const.World.ContractCost.WhiteWolf;

		if(currentResources < minResources)
		{
			return;
		}
		else
		{
			::Const.World.LegendaryContract.WhiteWolf += 1;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_hunting_white_direwolf_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		::World.Contracts.addContract(contract);
	}

});

