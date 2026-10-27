this.legend_hunting_stollwurms_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		ValidSettlements = [
			"small_farming_village",
			"medium_farming_village",
			"large_farming_village",
			"legends_farming_village",
			"small_steppe_village",
			"medium_steppe_village",
			"large_steppe_village",
			"legends_steppe_village"
		]
	},

	function create() {
		this.m.ID = "legend_hunting_stollwurms_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = ::Math.rand(145, 175) * 0.01;
	}

	function onUpdate(_faction) {
		// For settlement faction
		if (_faction.getType() == ::Const.FactionType.Settlement && !_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_hunting_stollwurms_contract)) {
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract()) {
			return;
		}

		if (_faction.getSettlements()[0].isIsolated()) {
			return;
		}

		if (::World.Assets.getBusinessReputation() < 1500) {
			return;
		}

		local village = _faction.getSettlements()[0];
		if (!::Legends.S.any(this.m.ValidSettlements, @(_settlement) ::isKindOf(village, _settlement))) {
			return;
		}

		local minResources = ::Const.World.LegendaryContract.Stollwurm * ::Const.World.ContractCost.StollWurm + ::Const.World.ContractCost.StollWurm;
		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * ::Const.World.ContractCost.StollWurm;
		if (currentResources >= minResources) {
			::Const.World.LegendaryContract.Stollwurm += 1;
		}

		this.m.Score = 1;
	}

	function onClear() {}

	function onExecute(_faction) {
		local contract = this.new("scripts/contracts/contracts/legend_hunting_stollwurms_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		::World.Contracts.addContract(contract);
	}
});
