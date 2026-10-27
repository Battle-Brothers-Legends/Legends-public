this.legend_hunting_basilisks_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		ValidSettlements = [
			"small_lumber_village",
			"medium_lumber_village",
			"legends_lumber_village"
		]
	},

	function create() {
		this.m.ID = "legend_hunting_basilisks_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
	}

	function onUpdate(_faction) {
		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_hunting_basilisks_contract)) {
			return;
		}

		local village = _faction.getSettlements()[0];
		if (village.isIsolated() || village.getSize() > 2) {
			return;
		}

		if (::World.getTime().Days <= 3 || ::Math.rand(1, 100) > 30) {
			return;
		}

		if (!::Legends.S.any(this.m.ValidSettlements, @(_settlement) ::isKindOf(village, _settlement))) {
			return;
		}

		this.m.Score = 1;
	}

	function onClear() {}

	function onExecute(_faction) {
		local contract = this.new("scripts/contracts/contracts/legend_hunting_basilisks_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		::World.Contracts.addContract(contract);
	}
});
