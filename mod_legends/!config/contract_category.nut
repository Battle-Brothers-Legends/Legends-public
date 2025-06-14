// Note: this script does not hook a "contract_category.nut" script. Rather it uses hooks to automate setting contract categories as a time-saving convenience.
// Contract Overhaul (adding Categories)
::Const.Contracts.Categories <- {
	Economy = "Economy",
	Battle = "Battle",
	Hunt = "Hunt",
	Legendary = "Legendary"
}

// At each corresponding Settlement Tier, a settlement can have the configured maximum number of open contracts under the corresponding Category (Economic, Location etc)
// Wildcard is a bonus category, where any contract can be given an open contract slot under Wildcard if its corresponding Category is full. This is for variety's sake
::Const.Contracts.CategoryLimits <- {
	Economy = [
		1, // Tier 1 limit
		1, // Tier 2 limit
		1  // Tier 3 limit
	],
	Battle = [
		1,
		1,
		1
	],
	Hunt = [
		1,
		1,
		1
	],
	Legendary = [
		1,
		1,
		1
	],
	Wildcard = [
		1,
		2,
		3
	]
};

// Note: if adding any new categories, you will also need to update the definition of m.ContractsByCategory in faction.nut

// Contract Overhaul (adding Categories)
// This will define which Category each contract is
// Each contract's m.Category will be defined as the value configured here
// Each contract action will call isReadyForContract() with the input as the value configured for the corresponding contract
::Const.Contracts.ContractCategoryMap <- {

	// Settlement Contracts
	deliver_item_contract = this.Const.Contracts.Categories.Economy,
	legend_deliver_money_contract = this.Const.Contracts.Categories.Economy,
	escort_caravan_contract = this.Const.Contracts.Categories.Economy,
	obtain_item_contract = this.Const.Contracts.Categories.Economy,
	restore_location_contract = this.Const.Contracts.Categories.Economy,


	defend_settlement_bandits_contract = this.Const.Contracts.Categories.Battle,
	defend_settlement_greenskins_contract = this.Const.Contracts.Categories.Battle,
	discover_location_contract = this.Const.Contracts.Categories.Battle,
	drive_away_bandits_contract = this.Const.Contracts.Categories.Battle,
	drive_away_nomads_contract = this.Const.Contracts.Categories.Battle,
	drive_away_barbarians_contract = this.Const.Contracts.Categories.Battle,
	investigate_cemetery_contract = this.Const.Contracts.Categories.Battle,
	return_item_contract = this.Const.Contracts.Categories.Battle,

	hunting_alps_contract = this.Const.Contracts.Categories.Hunt,
	hunting_hexen_contract = this.Const.Contracts.Categories.Hunt,
	hunting_lindwurms_contract = this.Const.Contracts.Categories.Hunt,
	hunting_sand_golems_contract = this.Const.Contracts.Categories.Hunt,
	hunting_schrats_contract = this.Const.Contracts.Categories.Hunt,
	hunting_serpents_contract = this.Const.Contracts.Categories.Hunt,
	hunting_unholds_contract = this.Const.Contracts.Categories.Hunt,
	hunting_webknechts_contract = this.Const.Contracts.Categories.Hunt,
	roaming_beasts_contract = this.Const.Contracts.Categories.Hunt,
	legend_preemptive_beasts_contract = this.Const.Contracts.Categories.Hunt, // Adds this in here for testing
	legend_spider_abductions_contract = this.Const.Contracts.Categories.Hunt,
	legend_hunting_basilisks_contract = this.Const.Contracts.Categories.Hunt,
	roaming_beasts_desert_contract = this.Const.Contracts.Categories.Hunt,

	legend_bandit_army_contract = this.Const.Contracts.Categories.Legendary,
	legend_barbarian_prisoner_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_coven_leader_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_demon_alps_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_greenwood_schrats_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_mummies_contract = this.Const.Contracts.Categories.Battle,
	legend_hunting_redback_webknechts_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_rock_unholds_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_skin_ghouls_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_stollwurms_contract = this.Const.Contracts.Categories.Legendary,
	legend_hunting_white_direwolf_contract = this.Const.Contracts.Categories.Legendary

	// Noble Contracts (future development?)

	// City-State Contracts (future development?)

}

// Map the contract category icons that will be used in the settlement screen
::Const.Contracts.ContractCategoryIconMap <- {
	Economy = "ui/icons/contract_type_economy", // the ".png" will be appended in world_town_screen_main_dialog_module.js
	Battle = "ui/icons/contract_type_battle",
	Hunt = "ui/icons/contract_type_hunt",
	Legendary = ""
}

// Contracts in the same array are mutually exclusive. faction.nut will perform a check when adding new contracts;
// If the contract's mutually exclusive counterparts are currently available, the contract will not spawn
// To make use of this, the contract action must call _faction.hasContractExclusion in the onUpdate function
::Const.Contracts.ContractExclusions <- [
	["contract.legend_preemptive_beasts","contract.roaming_beasts"],
	["contract.hunting_webknechts","contract.legend_spider_abductions","contract.roaming_beasts"],
];

// Use hooks to programmatically set each contract's Category to the configured value in ::Const.Contracts.ContractCategoryMap
// Note: The corresponding faction action scripts that spawn the contracts still need manual coding to input the relevant Category to the isReadyForContract() call
foreach (key, value in ::Const.Contracts.ContractCategoryMap)
{
	local script = "contracts/contracts/" + key;
	local cat = ::Const.Contracts.ContractCategoryMap[key];
	::mods_hookNewObject(script, function(o){
		o.m.Category = cat;
	});
}
