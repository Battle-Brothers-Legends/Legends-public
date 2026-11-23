this.legend_hunting_stollwurms_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_hunting_stollwurms_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = this.Math.rand(145, 175) * 0.01;
	}

	function onUpdate( _faction )
	{


		if (!this.Const.DLC.Unhold || !this.Const.DLC.Lindwurm)
		{
			return;
		}

		
		// For settlement faction
		if (_faction.getType()==this.Const.FactionType.Settlement && !_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.legend_hunting_stollwurms_contract))
		{
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated())
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (!this.isKindOf(village, "legends_stepppe_village") && !this.isKindOf(village, "legends_farming_village") && !this.isKindOf(village, "small_stepppe_village") && !this.isKindOf(village, "medium_stepppe_village") && !this.isKindOf(village, "large_stepppe_village") && !this.isKindOf(village, "small_farming_village") && !this.isKindOf(village, "medium_farming_village") && !this.isKindOf(village, "large_farming_village"))
		{
			return;
		}

		local minResources = this.Const.World.LegendaryContract.Stollwurm * this.Const.World.ContractCost.StollWurm + this.Const.World.ContractCost.StollWurm;

		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * this.Const.World.ContractCost.StollWurm;

		if(currentResources < minResources)
		{
			return;
		}
		else
		{
			this.Const.World.LegendaryContract.Stollwurm += 1;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_hunting_stollwurms_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		this.World.Contracts.addContract(contract);
	}

});

