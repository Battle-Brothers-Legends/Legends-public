this.legend_hunting_demon_alps_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		ValidSettlements = [
			"small_lumber_village",
			"medium_lumber_village",
			"legends_lumber_village",
			"small_mining_village",
			"medium_mining_village",
			"legends_mining_village"
		]
	},

	function create() {
		this.m.ID = "legend_hunting_demon_alps_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = ::Math.rand(145, 175) * 0.01;
	}

	function onUpdate(_faction) {
		// For settlement faction
		if (_faction.getType() == ::Const.FactionType.Settlement && !_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_hunting_demon_alps_contract)) {
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract()) {
			return;
		}

		if (::World.Assets.getBusinessReputation() < 400) {
			return;
		}

		local village = _faction.getSettlements()[0];
		if (village.isIsolated() || village.getSize() > 2) {
			return;
		}

		if (::Legends.S.any(this.m.ValidSettlements, @(_settlement) ::isKindOf(village, _settlement))) {
			return;
		}

		local minResources = ::Const.World.LegendaryContract.DemonAlp * ::Const.World.ContractCost.DemonAlp + ::Const.World.ContractCost.DemonAlp;
		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * ::Const.World.ContractCost.DemonAlp;
		if (currentResources >= minResources) {
			::Const.World.LegendaryContract.DemonAlp += 1;
		}

		this.m.Score = 1;
	}

	function onClear() {}

	function onExecute(_faction) {
		local contract = this.new("scripts/contracts/contracts/legend_hunting_demon_alps_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		::World.Contracts.addContract(contract);
	}
});
