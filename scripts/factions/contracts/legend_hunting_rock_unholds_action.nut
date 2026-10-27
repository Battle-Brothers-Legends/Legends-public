this.legend_hunting_rock_unholds_action <- this.inherit("scripts/factions/faction_action", {
	m = {
		EnemyType = 0,
		ValidSettlements = [
			[
				"small_swamp_village",
				"medium_swamp_village",
				"legends_swamp_village",
				"small_lumber_village",
				"medium_lumber_village",
				"legends_lumber_village"
			],
			[
				"small_snow_village",
				"medium_snow_village",
				"legends_snow_village"
			],
			[
				"small_mining_village",
				"legends_mining_village",
				"small_tundra_village",
				"medium_tundra_village",
				"legends_tundra_village"
			]
		]
	},

	function create() {
		this.m.ID = "legend_hunting_rock_unholds_action";
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 14;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = true;
		this.faction_action.create();
		this.m.DifficultyMult = ::Math.rand(145, 175) * 0.01;
	}

	function onUpdate(_faction) {
		// For settlement faction
		if (_faction.getType() == ::Const.FactionType.Settlement && !_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.legend_hunting_rock_unholds_contract)) {
			return;
		}

		// For noble faction
		if (!_faction.isReadyForContract()) {
			return;
		}

		if (::World.Assets.getBusinessReputation() < 700) {
			return;
		}

		local village = _faction.getSettlements()[0];
		if (village.isIsolated() || village.getSize() > 2) {
			return;
		}

		if (::Legends.S.any(this.m.ValidSettlements[0], @(_settlement) ::isKindOf(village, _settlement))) {
			this.m.EnemyType = 0;
		} else if (::Legends.S.any(this.m.ValidSettlements[1], @(_settlement) ::isKindOf(village, _settlement))) {
			this.m.EnemyType = 1;
		} else if (::Legends.S.any(this.m.ValidSettlements[2], @(_settlement) ::isKindOf(village, _settlement))) {
			this.m.EnemyType = 2;
		} else {
			return;
		}

		local minResources = ::Const.World.LegendaryContract.RockUnhold * ::Const.World.ContractCost.RockUnhold + ::Const.World.ContractCost.RockUnhold;
		local currentResources = this.getDifficultyMult() * this.getScaledDifficultyMult() * ::Const.World.ContractCost.RockUnhold;
		if (currentResources >= minResources) {
			::Const.World.LegendaryContract.RockUnhold += 1;
		}

		this.m.Score = 1;
	}

	function onClear() {
		this.m.EnemyType = 0;
	}

	function onExecute(_faction) {
		local contract = this.new("scripts/contracts/contracts/legend_hunting_rock_unholds_contract");
		contract.setFaction(_faction.getID());
		contract.setHome(_faction.getSettlements()[0]);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
		contract.setEnemyType(this.m.EnemyType);
		::World.Contracts.addContract(contract);
	}

});
