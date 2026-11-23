this.legend_hunting_rock_unholds_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		EnemyType = 0
	},
	function create()
	{
		this.m.ID = "legend_hunting_rock_unholds_action";
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
		if (_faction.getType()==this.Const.FactionType.Settlement && !_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.legend_hunting_rock_unholds_contract))
		{
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 700)
		{
			return;
		}

		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2)
		{
			return;
		}

		local village = _faction.getSettlements()[0];

		if (this.isKindOf(village, "legends_lumber_village") || this.isKindOf(village, "legends_swamp_village") || this.isKindOf(village, "small_lumber_village") || this.isKindOf(village, "medium_lumber_village") || this.isKindOf(village, "small_swamp_village") || this.isKindOf(village, "medium_swamp_village"))
		{
			this.m.EnemyType = 0;
		}
		else if (this.isKindOf(village, "legends_snow_village") || this.isKindOf(village, "small_snow_village") || this.isKindOf(village, "medium_snow_village"))
		{
			this.m.EnemyType = 1;
		}
		else if (this.isKindOf(village, "legends_tundra_village") || this.isKindOf(village, "legends_mining_village") || this.isKindOf(village, "small_tundra_village") || this.isKindOf(village, "medium_tundra_village") || this.isKindOf(village, "small_mining_village"))
		{
			this.m.EnemyType = 2;
		}
		else
		{
			return;
		}

		local minResources = this.Const.World.LegendaryContract.RockUnhold * this.Const.World.ContractCost.RockUnhold + this.Const.World.ContractCost.RockUnhold;

		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * this.Const.World.ContractCost.RockUnhold;

		if(currentResources < minResources)
		{
			return;
		}
		else
		{
			this.Const.World.LegendaryContract.RockUnhold += 1;
		}

		this.m.Score = 1;
	}

	function onClear()
	{
		this.m.EnemyType = 0;
	}

	function onExecute( _faction )
	{
		local contract = this.new("scripts/contracts/contracts/legend_hunting_rock_unholds_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setEnemyType(this.m.EnemyType);
		this.World.Contracts.addContract(contract);
	}

});

