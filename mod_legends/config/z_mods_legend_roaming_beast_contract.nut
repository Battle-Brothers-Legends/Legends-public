/*
*	Weights used in Preemptive and Roaming Beasts Contracts
*/
::RoamingBeastsContractWeights <- {
	Weights = {
		Default = [
			[1, "IsDirewolves"],
			[1, "IsGhouls"],
			[1, "IsSpiders"]
		],
		Lumber = [
			[2, "IsDirewolves"],
			[1, "IsGhouls"],
			[3, "IsSpiders"]
		],
		Tundra = [
			[4, "IsDirewolves"],
			[1, "IsGhouls"],
			[1, "IsSpiders"]
		],
		Snow = [
			[1, "IsDirewolves"]
		],
		Steppe = [
			[1, "IsDirewolves"],
			[4, "IsGhouls"],
			[1, "IsSpiders"]
		],
		Swamp = [
			[1, "IsDirewolves"],
			[4, "IsGhouls"],
			[1, "IsSpiders"]
		],
		Farming = [
			[2, "IsDirewolves"],
			[3, "IsGhouls"],
			[2, "IsSpiders"]
		],
	}

	/*
	*	Define rollEnemyBySettlement:
	*
	*	A function that takes in a Settlement object and checks its type,
	*	then uses the corresponding settlement type in the RoamingBeastsContractWeights.Weights table
	*	to randomly determine with weights which beast is picked.
	*	(Originally designed and created to fix the Roaming Beasts Contract)
	*	The Vanilla approach (as of Update 1.5.0.14) in /scripts/contracts/contracts/roaming_beasts_contract.nut
	*	was bugged and heavily skewed towards Ghouls
	*/
	function rollEnemyBySettlement(_settlement) {
		if (::isKindOf(_settlement, "legends_lumber_village") || ::isKindOf(_settlement, "small_lumber_village") || ::isKindOf(_settlement, "medium_lumber_village")) {
			return ::Legends.S.rollWeighted(this.Weights.Lumber)[1];
		} else if (::isKindOf(_settlement, "legends_tundra_village") || ::isKindOf(_settlement, "small_tundra_village") || ::isKindOf(_settlement, "medium_tundra_village")) {
			return ::Legends.S.rollWeighted(this.Weights.Tundra)[1];
		} else if (::isKindOf(_settlement, "legends_snow_village") || ::isKindOf(_settlement, "small_snow_village") || ::isKindOf(_settlement, "medium_snow_village")) {
			return ::Legends.S.rollWeighted(this.Weights.Snow)[1];
		} else if (::isKindOf(_settlement, "legends_steppe_village") || ::isKindOf(_settlement, "small_steppe_village") || ::isKindOf(_settlement, "medium_steppe_village")) {
			return ::Legends.S.rollWeighted(this.Weights.Steppe)[1];
		} else if (::isKindOf(_settlement, "legends_swamp_village") || ::isKindOf(_settlement, "small_swamp_village") || ::isKindOf(_settlement, "medium_swamp_village")) {
			return ::Legends.S.rollWeighted(this.Weights.Swamp)[1];
		} else if (::isKindOf(_settlement, "legends_farming_village") || ::isKindOf(_settlement, "small_farming_village") || ::isKindOf(_settlement, "medium_farming_village")) {
			return ::Legends.S.rollWeighted(this.Weights.Farming)[1];
		} else {
			return ::Legends.S.rollWeighted(this.Weights.Default)[1];
		}
	}
};
