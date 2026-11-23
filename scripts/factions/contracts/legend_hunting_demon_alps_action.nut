this.legend_hunting_demon_alps_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_hunting_demon_alps_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
	}

	function onUpdate( _faction )
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		// For settlement faction
		if (_faction.getType()==this.Const.FactionType.Settlement && !_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.legend_hunting_demon_alps_contract))
		{
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 400)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (this.isKindOf(village, "legends_lumber_village") || this.isKindOf(village, "legends_mining_village") || this.isKindOf(village, "small_lumber_village") || this.isKindOf(village, "medium_lumber_village") || this.isKindOf(village, "small_mining_village") || this.isKindOf(village, "medium_mining_village"))
		{
			return;
		}

		local minResources = this.Const.World.LegendaryContract.DemonAlp * this.Const.World.ContractCost.DemonAlp + this.Const.World.ContractCost.DemonAlp;

		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * this.Const.World.ContractCost.DemonAlp;

		if(currentResources < minResources)
		{
			return;
		}
		else
		{
			this.Const.World.LegendaryContract.DemonAlp += 1;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_hunting_demon_alps_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

