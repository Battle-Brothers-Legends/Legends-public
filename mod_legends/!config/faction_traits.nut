// find highest number in FactionTrait
local lastTrait = 0;
foreach (item in ::Const.FactionTrait) {
	if (typeof(item) == "integer")
		lastTrait = ::Math.max(lastTrait, item);
}
// new legends faction traits
::Const.FactionTrait.FreeCompany <- ++lastTrait;
::Const.FactionTrait.DummyFaction <- ++lastTrait;
// ensure actions list is big enough to fit our stuff
while(::Const.FactionTrait.Actions.len() <= lastTrait)
	::Const.FactionTrait.Actions.push([]);

::Const.FactionTrait.Actions[::Const.FactionTrait.NobleHouse].extend([
	"scripts/factions/actions/legend_build_location_action",
	"scripts/factions/actions/legend_upgrade_settlement_action",
	"scripts/factions/contracts/legend_hunting_white_direwolf_action",
	"scripts/factions/contracts/legend_hunting_stollwurms_action",
	"scripts/factions/contracts/legend_hunting_rock_unholds_action",
	"scripts/factions/contracts/legend_hunting_redback_webknechts_action",
	"scripts/factions/contracts/legend_hunting_greenwood_schrats_action",
	"scripts/factions/contracts/legend_hunting_demon_alps_action",
	"scripts/factions/contracts/legend_hunting_coven_leader_action",
	"scripts/factions/contracts/legend_hunting_skin_ghouls_action",
	"scripts/factions/contracts/legend_bandit_army_action",
	"scripts/factions/contracts/legend_barbarian_prisoner_action"
]);

::Const.FactionTrait.Actions[::Const.FactionTrait.Settlement].extend([
	"scripts/factions/contracts/legend_money_delivery_action",
	"scripts/factions/contracts/legend_hunting_basilisks_action",
	"scripts/factions/contracts/legend_hunting_white_direwolf_action",
	"scripts/factions/contracts/legend_hunting_stollwurms_action",
	"scripts/factions/contracts/legend_hunting_rock_unholds_action",
	"scripts/factions/contracts/legend_hunting_redback_webknechts_action",
	"scripts/factions/contracts/legend_hunting_greenwood_schrats_action",
	"scripts/factions/contracts/legend_hunting_demon_alps_action",
	"scripts/factions/contracts/legend_hunting_coven_leader_action",
	"scripts/factions/contracts/legend_hunting_skin_ghouls_action",
	"scripts/factions/contracts/legend_bandit_army_action",
	"scripts/factions/contracts/legend_barbarian_prisoner_action",
	"scripts/factions/contracts/legend_preemptive_beasts_action",
	"scripts/factions/contracts/legend_spider_abductions_action",
	"scripts/factions/actions/legend_build_location_action",
	"scripts/factions/actions/legend_upgrade_settlement_action"
]);

::Const.FactionTrait.Actions[::Const.FactionTrait.OrientalCityState].extend([
	"scripts/factions/contracts/legend_hunting_mummies_action",
	"scripts/factions/actions/legend_build_location_action",
	"scripts/factions/actions/legend_upgrade_locations_action",
]);

::Const.FactionTrait.Actions[::Const.FactionTrait.FreeCompany] = [
//	"scripts/factions/contracts/legend_camp_legion_hunt_nobles_action",
	"scripts/factions/contracts/legend_camp_legion_defend_cemetery_action",
	"scripts/factions/contracts/legend_camp_unhold_bondage_action",
	"scripts/factions/contracts/legend_camp_smuggle_action",
];
