/*
*	Define RoamingBeastsContractWeights:
*
*	A collection of configurable tables and functions originally designed and created
*	to fix the bugged Vanilla Roaming Beasts Contracts
*/
::RoamingBeastsContractWeights <- {

	/*
	*	Define RoamingBeastsContractWeights.Weights:
	* 	
	*	A table of FU WeightedContainers to thematically determine which beast is picked
	*	(Originally designed and created to fix the Roaming Beasts Contract)
	*	Currently, these weights and settlement types are based on the Vanilla setup.
	*/
	Weights = {
		
		Default = ::FU.Class.WeightedContainer([
			[50, "IsDirewolves"],
			[50, "IsGhouls"],
			[50, "IsSpiders"]
		]),

		Lumber = ::FU.Class.WeightedContainer([
			[100, "IsDirewolves"],
			[50, "IsGhouls"],
			[150, "IsSpiders"]			
		]),

		Tundra = ::FU.Class.WeightedContainer([
			[100, "IsDirewolves"],
			[25, "IsGhouls"],
			[25, "IsSpiders"]			
		]),

		Snow = ::FU.Class.WeightedContainer([
			[100, "IsDirewolves"],
			[0, "IsGhouls"],
			[0, "IsSpiders"]			
		]),

		Steppe = ::FU.Class.WeightedContainer([
			[25, "IsDirewolves"],
			[100, "IsGhouls"],
			[25, "IsSpiders"]			
		]),

		Swamp = ::FU.Class.WeightedContainer([
			[25, "IsDirewolves"],
			[100, "IsGhouls"],
			[25, "IsSpiders"]			
		]),

		Farming = ::FU.Class.WeightedContainer([
			[50, "IsDirewolves"],
			[75, "IsGhouls"],
			[50, "IsSpiders"]			
		]),

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
	function rollEnemyBySettlement( _settlement ) {

		if (::FU.isKindOf( _settlement, "legends_lumber_village") || ::FU.isKindOf( _settlement, "small_lumber_village") || ::FU.isKindOf( _settlement, "medium_lumber_village"))
		{
			return this.Weights.Lumber.roll();
		}
		else if (::FU.isKindOf( _settlement, "legends_tundra_village") || ::FU.isKindOf( _settlement, "small_tundra_village") || ::FU.isKindOf( _settlement, "medium_tundra_village"))
		{
			return this.Weights.Tundra.roll();
		}
		else if (::FU.isKindOf( _settlement, "legends_snow_village") || ::FU.isKindOf( _settlement, "small_snow_village") || ::FU.isKindOf( _settlement, "medium_snow_village"))
		{
			return this.Weights.Snow.roll();
		}
		else if (::FU.isKindOf( _settlement, "legends_steppe_village") || ::FU.isKindOf( _settlement, "small_steppe_village") || ::FU.isKindOf( _settlement, "medium_steppe_village"))
		{
			return this.Weights.Steppe.roll();
		}
		else if (::FU.isKindOf( _settlement, "legends_swamp_village") || ::FU.isKindOf( _settlement, "small_swamp_village") || ::FU.isKindOf( _settlement, "medium_swamp_village"))
		{
			return this.Weights.Swamp.roll();
		} 
		else if (::FU.isKindOf( _settlement, "legends_farming_village") || ::FU.isKindOf( _settlement, "small_farming_village") || ::FU.isKindOf( _settlement, "medium_farming_village"))
		{
			return this.Weights.Farming.roll();
		}
		else
		{
			return this.Weights.Default.roll();
		}

	}
	
};