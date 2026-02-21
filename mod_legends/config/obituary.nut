::Legends.addFallen <- function(_bro, _cause) {
	local fallen = {
		Name = _bro.getName(),
		Time = this.World.getTime().Days,
		TimeWithCompany = this.Math.max(1, _bro.getDaysWithCompany()),
		Kills = _bro.getLifetimeStats().Kills,
		Battles = _bro.getLifetimeStats().Battles,
		KilledBy = _cause,
		Expendable = _bro.getBackground().getID() == "background.slave"
	};

	::World.Statistics.addFallen(_bro.finalizeFallen(fallen));
}

::Legends.Obituary <- {
	getColoredKeybindText = function(_keybindId) {
		local HexString = ::Legends.Mod.ModSettings.getSetting("obituary_hotkey_text_colour").getValueAsHexString();
		return "[color=#" + HexString.slice(0, 6) + "]" + ::Legends.Mod.Keybinds.getKeybind(_keybindId).getKeyCombinationsCapitalized() + "[/color]";
	},
	Tooltip = {},
	FateText = {}
};

::Legends.Obituary.Tooltip["world-screen.obituary.Level"] <- [
	"Level",
	"The level the character was upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.Traits"] <- [
	"Traits",
	"The background and traits the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.PermInjuries"] <- [
	"Permanent Injuries",
	"The permanent injuries the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.Perks"] <- [
	"Perks",
	"The perks the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.HP"] <- [
	"Hitpoints",
	"The base hitpoints the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.FT"] <- [
	"Fatigue",
	"The base fatigue the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.BR"] <- [
	"Resolve",
	"The base resolve the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.IT"] <- [
	"Initiative",
	"The base initiative the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.MA"] <- [
	"Melee Skill",
	"The base melee skill the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.RA"] <- [
	"Ranged Skill",
	"The base ranged skill the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.MD"] <- [
	"Melee Defense",
	"The base melee defense the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.RD"] <- [
	"Ranged Defense",
	"The base ranged defense the character had upon meeting their fate."
];
::Legends.Obituary.Tooltip["world-screen.obituary.swapperks"] <- [
	"Show Perks",
	@() "Swap the trait/permanent injuries columns for perks.\nHotkey: " + ::Legends.Obituary.getColoredKeybindText("toggle_perks")
];
::Legends.Obituary.Tooltip["world-screen.obituary.swapstats"] <- [
	"Swap Stat Order",
	@() "Swaps the position of first 4 stats (hp, fatigue, initiative, bravery) with the last 4 (attack / defense).\nHotkey: " + ::Legends.Obituary.getColoredKeybindText("toggle_stat_order")
];
::Legends.Obituary.Tooltip["world-screen.obituary.stackedstars"] <- [
	"Stacked Talent Stars",
	@() "Replace the 3 star talent icon (row of 3) with a triangle of stars.\nHotkey: " + ::Legends.Obituary.getColoredKeybindText("stacked_talent_stars")
];
::Legends.Obituary.Tooltip["AddToObituary"] <- [
	"Add To Obituary",
	@() "This bro will be added to the obituary, the same as any deceased bro or those who left due to certain events.\n\nThe reason shown for their departure may vary, and the tone of the message depends on whether you paid them compensation when dismissing them."
];

// Generic positive text (with compensation)
::Legends.Obituary.FateText.PositiveMessages <- [
    "Dismissed from company",
    "Retired gracefully",
    "Left on good terms",
    "Parted amicably",
    "Honorable discharge",
    "Finished service with distinction",
    "Dismissed honorably",
    "Peaceful separation"
];

// Generic negative text (without compensation)
::Legends.Obituary.FateText.NegativeMessages <- [
    "Kicked from company",
    "Booted from company",
    "Cast out",
    "Fired unceremoniously",
    "Thrown out",
    "Forced to leave",
    "Dismissed dishonorably",
    "Sent packing"
];

// Background-specific text
::Legends.Obituary.FateText.BackgroundMessages <- {
    ["background.adventurous_noble"]              = { pos = "Set off on a new adventure",                  neg = "" },
    ["background.anatomist"]                      = { pos = "Resumed their forbidden studies",             neg = "" },
    ["background.apprentice"]                     = { pos = "Sought a new master",                         neg = "" },
    ["background.assassin"]                       = { pos = "Returned to the underworld",                  neg = "" },
    ["background.assassin_southern"]              = { pos = "Returned to the underworld",                  neg = "" },
    ["background.barbarian"]                      = { pos = "Ventured back to the frozen north",           neg = "" },
    ["background.bastard"]                        = { pos = "Moved on without name or claim",              neg = "" },
    ["background.beast_slayer"]                   = { pos = "Took up the hunt for monsters once more",     neg = "" },
    ["background.beggar"]                         = { pos = "Worked the streets for more coin",            neg = "" },
    ["background.belly_dancer"]                   = { pos = "Took their performance to new crowds",        neg = "" },
    ["background.bowyer"]                         = { pos = "Resumed work with wood and sinew",            neg = "" },
    ["background.brawler"]                        = { pos = "Sought a new fight",                          neg = "" },
    ["background.butcher"]                        = { pos = "Went back to the chopping block",             neg = "" },
    ["background.caravan_hand"]                   = { pos = "Followed trade routes for their next job",    neg = "" },
    ["background.companion"]                      = { pos = "Parted ways and went their own path",         neg = "" },
    ["background.converted_cultist"]              = { pos = "Clung to their newly found beliefs",          neg = "" },
    ["background.cripple"]                        = { pos = "Struggled on, earning coin where they could", neg = "" },
    ["background.crucified"]                      = { pos = "Bore their scars while seeking new work",     neg = "" },
    ["background.crusader"]                       = { pos = "Continued their righteous war",               neg = "" },
    ["background.cultist"]                        = { pos = "Slunk back to dark worship",                  neg = "" },
    ["background.daytaler"]                       = { pos = "Earned their daily coin and moved on",        neg = "" },
    ["background.deserter"]                       = { pos = "Kept hiding from banners and drums",          neg = "" },
    ["background.disowned_noble"]                 = { pos = "Continued their exile",                       neg = "" },
    ["background.eunuch"]                         = { pos = "Found employment where needed",               neg = "" },
    ["background.farmhand"]                       = { pos = "Returned to the plow",                        neg = "" },
    ["background.fisherman"]                      = { pos = "Headed for familiar waters",                  neg = "" },
    ["background.flagellant"]                     = { pos = "Continued their path of painful penance",     neg = "" },
    ["background.gambler"]                        = { pos = "Chased fortune at dice and cards",            neg = "" },
    ["background.gladiator"]                      = { pos = "Returned to blood-soaked arenas",             neg = "" },
    ["background.gravedigger"]                    = { pos = "Resumed digging graves for the dead",         neg = "" },
    ["background.graverobber"]                    = { pos = "Resumed robbing the buried",                  neg = "" },
    ["background.hedge_knight"]                   = { pos = "Took to wandering battlefields again",        neg = "" },
    ["background.historian"]                      = { pos = "Lost themselves in dusty tomes",              neg = "" },
    ["background.houndmaster"]                    = { pos = "Returned to beasts and leashes",              neg = "" },
    ["background.hunter"]                         = { pos = "Disappeared into the deep woods",             neg = "" },
    ["background.juggler"]                        = { pos = "Continued to entertain crowds",               neg = "" },
    ["background.killer_on_the_run"]              = { pos = "Kept running from the law",                   neg = "" },
    ["background.kings_guard"]                    = { pos = "Resumed sworn royal service",                 neg = "" },
    ["background.lindwurm_slayer"]                = { pos = "Sought out legendary beasts once more",       neg = "" },
    ["background.lumberjack"]                     = { pos = "Returned to felling trees",                   neg = "" },
    ["background.manhunter"]                      = { pos = "Continued the pursuit of men",                neg = "" },
    ["background.mason"]                          = { pos = "Resumed work with stone and mortar",          neg = "" },
    ["background.messenger"]                      = { pos = "Carried words and warnings afar",             neg = "" },
    ["background.militia"]                        = { pos = "Went back to guarding their home",            neg = "" },
    ["background.miner"]                          = { pos = "Returned to the depths below",                neg = "" },
    ["background.miller"]                         = { pos = "Decided to grind grain for coin once more",   neg = "" },
    ["background.minstrel"]                       = { pos = "Set off to delight audiences anew",           neg = "" },
    ["background.monk"]                           = { pos = "Returned to quiet contemplation",             neg = "" },
    ["background.monk_turned_flagellant"]         = { pos = "Embraced suffering as faith",                 neg = "" },
    ["background.nomad"]                          = { pos = "Drifted back into the shifting sands",        neg = "" },
    ["background.orc_slayer"]                     = { pos = "Hunted greenskins wherever hired",            neg = "" },
    ["background.pacified_flagellant"]            = { pos = "Sought peace after years of pain",            neg = "" },
    ["background.paladin"]                        = { pos = "Continued their holy duty",                   neg = "" },
    ["background.peddler"]                        = { pos = "Went back to trade and barter",               neg = "" },
    ["background.pimp"]                           = { pos = "Returned to the gutter trade",                neg = "" },
    ["background.poacher"]                        = { pos = "Slipped back into illicit hunts",             neg = "" },
    ["background.raider"]                         = { pos = "Returned to pillage and bloodshed",           neg = "" },
    ["background.ratcatcher"]                     = { pos = "Returned to filth and vermin",                neg = "" },
    ["background.refugee"]                        = { pos = "Continued a life of flight",                  neg = "" },
    ["background.regent_in_absentia"]             = { pos = "Ruled from afar once more",                   neg = "" },
    ["background.retired_soldier"]                = { pos = "Laid down their arms for good",               neg = "" },
    ["background.sellsword"]                      = { pos = "Fought for coin elsewhere",                   neg = "" },
    ["background.servant"]                        = { pos = "Found a new master",                          neg = "" },
    ["background.shepherd"]                       = { pos = "Returned to their flock",                     neg = "" },
    ["background.slave"]                          = { pos = "Began a new life as a free man",              neg = "" },
    ["background.squire"]                         = { pos = "Continued their knightly training",           neg = "" },
    ["background.swordmaster"]                    = { pos = "Devoted themselves to the blade",             neg = "" },
    ["background.tailor"]                         = { pos = "Returned to sewing clothes for coin",         neg = "" },
    ["background.thief"]                          = { pos = "Returned to the underworld",                  neg = "" },
    ["background.vagabond"]                       = { pos = "Drifted along the open road",                 neg = "" },
    ["background.wildman"]                        = { pos = "Wandered the wilds once more",                neg = "" },
    ["background.witchhunter"]                    = { pos = "Continued purging heresy",                    neg = "" },
    ["background.legend_alchemist"]               = { pos = "", neg = "" },
    ["background.legend_ancient_summoner"]        = { pos = "", neg = "" },
    ["background.legend_assassin_commander"]      = { pos = "", neg = "" },
    ["background.legend_astrologist"]             = { pos = "", neg = "" },
    ["background.legend_battle_sister"]           = { pos = "", neg = "" },
    ["background.legend_beggar_commander"]        = { pos = "", neg = "" },
    ["background.legend_beggar_commander_op"]     = { pos = "", neg = "" },
    ["background.legend_berserker"]               = { pos = "", neg = "" },
    ["background.legend_berserker_commander"]     = { pos = "", neg = "" },
    ["background.legend_blacksmith"]              = { pos = "", neg = "" },
    ["background.legend_bladedancer"]             = { pos = "", neg = "" },
    ["background.legend_bounty_hunter"]           = { pos = "", neg = "" },
    ["background.legend_cannibal"]                = { pos = "", neg = "" },
    ["background.legend_companion_melee"]         = { pos = "", neg = "" },
    ["background.legend_companion_ranged"]        = { pos = "", neg = "" },
    ["background.legend_conjurer"]                = { pos = "", neg = "" },
    ["background.legend_conscript"]               = { pos = "", neg = "" },
    ["background.legend_conscript_ranged"]        = { pos = "", neg = "" },
    ["background.legend_crusader"]                = { pos = "", neg = "" },
    ["background.legend_death_summoner"]          = { pos = "", neg = "" },
    ["background.legend_dervish"]                 = { pos = "", neg = "" },
    ["background.legend_diviner"]                 = { pos = "", neg = "" },
    ["background.legend_donkey"]                  = { pos = "", neg = "" },
    ["background.legend_druid"]                   = { pos = "", neg = "" },
    ["background.legend_druid_commander"]         = { pos = "", neg = "" },
    ["background.legend_enchanter"]               = { pos = "", neg = "" },
    ["background.legend_entrancer"]               = { pos = "", neg = "" },
    ["background.legend_gladiator_prizefighter"]  = { pos = "", neg = "" },
    ["background.legend_guildmaster"]             = { pos = "", neg = "" },
    ["background.legend_healer"]                  = { pos = "", neg = "" },
    ["background.legend_herbalist"]               = { pos = "", neg = "" },
    ["background.legend_horse"]                   = { pos = "", neg = "" },
    ["background.legend_horserider"]              = { pos = "", neg = "" },
    ["background.legend_horse_courser"]           = { pos = "", neg = "" },
    ["background.legend_horse_destrier"]          = { pos = "", neg = "" },
    ["background.legend_horse_rouncey"]           = { pos = "", neg = "" },
    ["background.legend_husk"]                    = { pos = "", neg = "" },
    ["background.legend_illusionist"]             = { pos = "", neg = "" },
    ["background.legend_inventor"]                = { pos = "", neg = "" },
    ["background.legend_ironmonger"]              = { pos = "", neg = "" },
    ["background.legend_leech_peddler"]           = { pos = "", neg = "" },
    ["background.legend_legion_auxiliary"]        = { pos = "", neg = "" },
    ["background.legend_legion_centurion"]        = { pos = "", neg = "" },
    ["background.legend_legion_gladiator"]        = { pos = "", neg = "" },
    ["background.legend_legion_honour_guard"]     = { pos = "", neg = "" },
    ["background.legend_legion_legate"]           = { pos = "", neg = "" },
    ["background.legend_legion_legionary"]        = { pos = "", neg = "" },
    ["background.legend_legion_prefect"]          = { pos = "", neg = "" },
    ["background.legend_lonewolf"]                = { pos = "", neg = "" },
    ["background.legend_lurker"]                  = { pos = "", neg = "" },
    ["background.legend_magister"]                = { pos = "", neg = "" },
    ["background.legend_man_at_arms"]             = { pos = "", neg = "" },
    ["background.legend_master_archer"]           = { pos = "", neg = "" },
    ["background.legend_muladi"]                  = { pos = "", neg = "" },
    ["background.legend_necromancer"]             = { pos = "", neg = "" },
    ["background.legend_necrosavant"]             = { pos = "", neg = "" },
    ["background.legend_necro"]                   = { pos = "", neg = "" },
    ["background.legend_necro_commander"]         = { pos = "", neg = "" },
    ["background.legend_nightwatch"]              = { pos = "", neg = "" },
    ["background.legend_noble_2h"]                = { pos = "", neg = "" },
    ["background.legend_noble_background"]        = { pos = "", neg = "" },
    ["background.legend_noble_commander"]         = { pos = "", neg = "" },
    ["background.legend_noble_ranged"]            = { pos = "", neg = "" },
    ["background.legend_noble_shield"]            = { pos = "", neg = "" },
    ["background.legend_peddler_commander"]       = { pos = "", neg = "" },
    ["background.legend_philosopher"]             = { pos = "", neg = "" },
    ["background.legend_pilgrim"]                 = { pos = "", neg = "" },
    ["background.legend_premonitionist"]          = { pos = "", neg = "" },
    ["background.legend_preserver"]               = { pos = "", neg = "" },
    ["background.legend_puppet"]                  = { pos = "", neg = "" },
    ["background.legend_puppet_master"]           = { pos = "", neg = "" },
    ["background.legend_qiyan"]                   = { pos = "", neg = "" },
    ["background.legend_ranger"]                  = { pos = "", neg = "" },
    ["background.legend_ranger_commander"]        = { pos = "", neg = "" },
    ["background.legend_runesmith"]               = { pos = "", neg = "" },
    ["background.legend_shieldmaiden"]            = { pos = "", neg = "" },
    ["background.legend_spiritualist"]            = { pos = "", neg = "" },
    ["background.legend_surgeon"]                 = { pos = "", neg = "" },
    ["background.legend_taxidermist"]             = { pos = "", neg = "" },
    ["background.legend_trader"]                  = { pos = "", neg = "" },
    ["background.legend_trader_commander"]        = { pos = "", neg = "" },
    ["background.legend_transmuter"]              = { pos = "", neg = "" },
    ["background.legend_vala"]                    = { pos = "", neg = "" },
    ["background.legend_warlock"]                 = { pos = "", neg = "" },
    ["background.legend_warlock_summoner"]        = { pos = "", neg = "" },
    ["background.legend_witch"]                   = { pos = "", neg = "" },
    ["background.legend_witch_commander"]         = { pos = "", neg = "" },
    ["background.legend_youngblood"]              = { pos = "", neg = "" },
    ["background.mage_background"]                = { pos = "", neg = "" },
    ["background.mage_legend_mage_commander"]     = { pos = "", neg = "" }
};
