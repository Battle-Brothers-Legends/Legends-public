// find highest number in FactionTrait
local lastTrait = 0;
foreach (item in ::Const.FactionTrait) {
	if (typeof(item) == "integer")
		lastTrait = ::Math.max(lastTrait, item);
}
// new legends faction traits
::Const.FactionTrait.FreeCompany <- ++lastTrait;
::Const.FactionTrait.DummyFaction <- ++lastTrait;
::Const.FactionTrait.Chivalrous <- ++lastTrait;
::Const.FactionTrait.Generous <- ++lastTrait;
::Const.FactionTrait.Loyal <- ++lastTrait;
::Const.FactionTrait.Merciful <- ++lastTrait;
::Const.FactionTrait.Industrious <- ++lastTrait;
::Const.FactionTrait.Prosperous <- ++lastTrait;
::Const.FactionTrait.Visionary <- ++lastTrait;
::Const.FactionTrait.Wise <- ++lastTrait;
::Const.FactionTrait.Diplomatic <- ++lastTrait;
::Const.FactionTrait.Pragmatic <- ++lastTrait;
::Const.FactionTrait.Cosmopolitan <- ++lastTrait;
::Const.FactionTrait.Courageous <- ++lastTrait;
::Const.FactionTrait.Peaceful <- ++lastTrait;
::Const.FactionTrait.Crusader <- ++lastTrait;
::Const.FactionTrait.Pious <- ++lastTrait;
::Const.FactionTrait.Stern <- ++lastTrait;
::Const.FactionTrait.Martial <- ++lastTrait;
::Const.FactionTrait.Traditionalist <- ++lastTrait;
::Const.FactionTrait.Mystical <- ++lastTrait;
::Const.FactionTrait.Cultured <- ++lastTrait;
::Const.FactionTrait.Vigilant <- ++lastTrait;
::Const.FactionTrait.Stewardly <- ++lastTrait;
::Const.FactionTrait.Scholarly <- ++lastTrait;
::Const.FactionTrait.Distrustful <- ++lastTrait;
::Const.FactionTrait.Parsimonious <- ++lastTrait;
::Const.FactionTrait.Mercantile <- ++lastTrait;
::Const.FactionTrait.Bureaucratic <- ++lastTrait;
::Const.FactionTrait.Ambitious <- ++lastTrait;
::Const.FactionTrait.Destitute <- ++lastTrait;
::Const.FactionTrait.Cruel <- ++lastTrait;
::Const.FactionTrait.Spiteful <- ++lastTrait;
::Const.FactionTrait.Greedy <- ++lastTrait;
::Const.FactionTrait.Ruthless <- ++lastTrait;
::Const.FactionTrait.Bloodthirsty <- ++lastTrait;
::Const.FactionTrait.Paranoid <- ++lastTrait;
::Const.FactionTrait.Arrogant <- ++lastTrait;
::Const.FactionTrait.Cursed <- ++lastTrait;
::Const.FactionTrait.Inbred <- ++lastTrait;
::Const.FactionTrait.Unstable <- ++lastTrait;
::Const.FactionTrait.Decadent <- ++lastTrait;
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
	"scripts/factions/contracts/legend_camp_legion_hunt_nobles_action",
	"scripts/factions/contracts/legend_camp_legion_hunt_barbarians_action",
	"scripts/factions/contracts/legend_camp_legion_hunt_barbarians_action",
	"scripts/factions/contracts/legend_camp_legion_defend_cemetery_action",
	"scripts/factions/contracts/legend_camp_unhold_bondage_action",
	"scripts/factions/contracts/legend_camp_smuggle_action",
];
