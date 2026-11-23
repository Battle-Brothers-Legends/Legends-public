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
	"Record their fate in the ledger",
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
    "Peaceful separation",
	"Returned home to recover",
	"Left with dignity",
	"A sorrowful parting",
	"Agreed it was time to part ways",
	"Decided to leave"
];

// Generic negative text (without compensation)
::Legends.Obituary.FateText.NegativeMessages <- [
    "Kicked from company",
    "Booted from the company",
    "Cast out for a terrible crime",
    "Fired unceremoniously",
    "Thrown out for mutiny",
    "Forced to leave",
    "Dismissed dishonorably",
    "Shamed the company. Sent packing",
	"Told to leave or die",
	"Abandoned in the wilds",
	"Got left in a swamp",
	"Got lost in a desert",
	"Vanished whilst on patrol",
	"Voted out by company majority",
	"A bitter parting",
	"Left in a terrible rage",
	"Banished for a transgression",
	"Left snoring in a tavern, useless sod",
	"Disliked immensely by all",
	"Left naked at a crossroads",
	"Cruelly injured and left behind",
	"Dropped for being dead weight",
	"Left to fend for themselves",
	"Stormed off after an argument",
	"Left us for a pretty face."
];

// Background-specific text
::Legends.Obituary.FateText.BackgroundMessages <- {
    ["background.adventurous_noble"]              = { pos = "Set off on a new adventure",					neg = "" },
    ["background.anatomist"]                      = { pos = "Resumed their forbidden studies",             	neg = "" },
    ["background.apprentice"]                     = { pos = "Sought a new master",                         	neg = "" },
    ["background.assassin"]                       = { pos = "Returned to the underworld",                  	neg = "" },
    ["background.assassin_southern"]              = { pos = "Returned to the underworld",                  	neg = "" },
    ["background.barbarian"]                      = { pos = "Ventured back to the frozen north",           	neg = "" },
    ["background.bastard"]                        = { pos = "Moved on without name or claim",              	neg = "" },
    ["background.beast_slayer"]                   = { pos = "Took up the hunt for monsters once more",     	neg = "" },
    ["background.beggar"]                         = { pos = "Worked the streets for more coin",            	neg = "Returned to the gutter" },
    ["background.belly_dancer"]                   = { pos = "Took their performance to new crowds",        	neg = "" },
    ["background.bowyer"]                         = { pos = "Resumed work with wood and sinew",            	neg = "" },
    ["background.brawler"]                        = { pos = "Sought a new fight",                          	neg = "" },
    ["background.butcher"]                        = { pos = "Went back to the chopping block",             	neg = "" },
    ["background.caravan_hand"]                   = { pos = "Followed trade routes for their next job",    	neg = "" },
    ["background.companion"]                      = { pos = "Parted ways and went their own path",         	neg = "" },
    ["background.converted_cultist"]              = { pos = "Clung to their newly found beliefs",          	neg = "" },
    ["background.cripple"]                        = { pos = "Struggled on, earning coin where they could", 	neg = "Left to die in the gutter" },
    ["background.crucified"]                      = { pos = "Bore their scars while seeking new work",     	neg = "" },
    ["background.crusader"]                       = { pos = "Continued their righteous war",               	neg = "Took their unceasing zealotry elsewhere" },
    ["background.cultist"]                        = { pos = "Slunk back to dark worship",                  	neg = "" },
    ["background.daytaler"]                       = { pos = "Earned their daily coin and moved on",        	neg = "" },
    ["background.deserter"]                       = { pos = "Kept hiding from banners and drums",          	neg = "" },
    ["background.disowned_noble"]                 = { pos = "Continued their exile in comfort",            	neg = "Left in a rage, swearing revenge" },
    ["background.eunuch"]                         = { pos = "Found quiet employment where needed",         	neg = "" },
    ["background.farmhand"]                       = { pos = "Returned to the plow",                        	neg = "" },
    ["background.fisherman"]                      = { pos = "Headed for familiar waters",                  	neg = "" },
    ["background.flagellant"]                     = { pos = "Continued their path of painful penance",     	neg = "" },
    ["background.gambler"]                        = { pos = "Chased fortune at dice and cards",            	neg = "Chased fortune and lost it all, again" },
    ["background.gladiator"]                      = { pos = "Returned to blood-soaked arenas",             	neg = "" },
    ["background.gravedigger"]                    = { pos = "Resumed digging graves for profit",           	neg = "" },
    ["background.graverobber"]                    = { pos = "Resumed robbing the recently deceased",       	neg = "" },
    ["background.hedge_knight"]                   = { pos = "Took to wandering battlefields again",        	neg = "" },
    ["background.historian"]                      = { pos = "Lost themselves in dusty tomes",              	neg = "Their fate is lost to time" },
    ["background.houndmaster"]                    = { pos = "Returned to beasts and leashes",              	neg = "" },
    ["background.hunter"]                         = { pos = "Disappeared into the deep woods",             	neg = "" },
    ["background.juggler"]                        = { pos = "Continued to entertain crowds",               	neg = "" },
    ["background.killer_on_the_run"]              = { pos = "Kept running from the law",                   	neg = "Captured and hung within days of leaving" },
    ["background.kings_guard"]                    = { pos = "Resumed sworn royal service",                 	neg = "" },
    ["background.lindwurm_slayer"]                = { pos = "Sought out legendary beasts once more",       	neg = "" },
    ["background.lumberjack"]                     = { pos = "Returned to felling trees",                   	neg = "" },
    ["background.manhunter"]                      = { pos = "Continued the pursuit of men",                	neg = "" },
    ["background.mason"]                          = { pos = "Resumed work with stone and mortar",          	neg = "" },
    ["background.messenger"]                      = { pos = "Carried words and warnings afar",             	neg = "" },
    ["background.militia"]                        = { pos = "Went back to guarding their home",            	neg = "" },
    ["background.miner"]                          = { pos = "Returned to the depths below",                	neg = "" },
    ["background.miller"]                         = { pos = "Decided to grind grain for coin once more",   	neg = "" },
    ["background.minstrel"]                       = { pos = "Set off to delight audiences anew",           	neg = "" },
    ["background.monk"]                           = { pos = "Returned to quiet contemplation",             	neg = "" },
    ["background.monk_turned_flagellant"]         = { pos = "Embraced suffering as faith",                 	neg = "" },
    ["background.nomad"]                          = { pos = "Drifted back to the shifting sands",          	neg = "" },
    ["background.orc_slayer"]                     = { pos = "Hunted greenskins wherever hired",            	neg = "" },
    ["background.pacified_flagellant"]            = { pos = "Sought peace after years of pain",            	neg = "" },
    ["background.paladin"]                        = { pos = "Continued their holy duty",                   	neg = "" },
    ["background.peddler"]                        = { pos = "Went back to trade and barter",               	neg = "" },
    ["background.pimp"]                           = { pos = "Returned to the gutter trade",                	neg = "Destined to be a bitter nobody" },
    ["background.poacher"]                        = { pos = "Slipped back into illicit hunts",             	neg = "Lost in the woods, never seen again" },
    ["background.raider"]                         = { pos = "Returned to pillage and bloodshed",           	neg = "Got arrested for murder" },
    ["background.ratcatcher"]                     = { pos = "Returned to filth and vermin",                	neg = "Allegedly devoured by vermin" },
    ["background.refugee"]                        = { pos = "Finally found a place to call home",          	neg = "Captured by slavers" },
    ["background.regent_in_absentia"]             = { pos = "Ruled from afar once more",                   	neg = "" },
    ["background.retired_soldier"]                = { pos = "Laid down their arms for good",               	neg = "" },
    ["background.sellsword"]                      = { pos = "Fought for coin elsewhere",                   	neg = "" },
    ["background.servant"]                        = { pos = "Found a new master",                          	neg = "" },
    ["background.shepherd"]                       = { pos = "Returned to their flock",                     	neg = "" },
    ["background.slave"]                          = { pos = "Began a new life as a free man",              	neg = "Indebted once more" },
    ["background.squire"]                         = { pos = "Sought a true knight to squire for",          	neg = "" },
    ["background.swordmaster"]                    = { pos = "Devoted themselves to the blade",             	neg = "" },
    ["background.tailor"]                         = { pos = "Returned to sewing clothes for coin",         	neg = "" },
    ["background.thief"]                          = { pos = "Stole a girl\'s heart, settled down",         	neg = "Stole from a brother, dismissed" },
    ["background.vagabond"]                       = { pos = "Drifted along the open road",                 	neg = "" },
    ["background.wildman"]                        = { pos = "Wandered the wilds once more",                	neg = "" },
    ["background.witchhunter"]                    = { pos = "Reported back to the guild",       	       	neg = "Believed killed by a hexen" },
    ["background.legend_alchemist"]               = { pos = "Pursued the Philosopher's Stone", 			   	neg = "" },
    ["background.legend_ancient_summoner"]        = { pos = "Returned to esoteric practices", 			   	neg = "" },
    ["background.legend_assassin_commander"]      = { pos = "Founded a deadly martial arts school", 	   	neg = "" },
    ["background.legend_astrologist"]             = { pos = "Found meaning in the stars", 				   	neg = "" },
    ["background.legend_battle_sister"]           = { pos = "Fought evil wherever she found it", 		   	neg = "Went back to the kitchen" },
    ["background.legend_beggar_commander"]        = { pos = "", 										   	neg = "" },
    ["background.legend_beggar_commander_op"]     = { pos = "", 										   	neg = "" },
    ["background.legend_berserker"]               = { pos = "Left to lead a pack of crazed warriors", 		neg = "" },
    ["background.legend_berserker_commander"]     = { pos = "Left to lead a pack of crazed warriors", 		neg = "" },
    ["background.legend_blacksmith"]              = { pos = "Returned to the heat of the forge", 			neg = "" },
    ["background.legend_bladedancer"]             = { pos = "Returned to the searing desert sands", 		neg = "" },
    ["background.legend_bounty_hunter"]           = { pos = "Tracked down a high-value target", 			neg = "" },
    ["background.legend_cannibal"]                = { pos = "Found a new source of meat", 					neg = "" },
    ["background.legend_companion_melee"]         = { pos = "Retired to become an innkeeper", 				neg = "Never forgave your betrayal" },
    ["background.legend_companion_ranged"]        = { pos = "Retired to become an innkeeper", 				neg = "Never forgave your betrayal" },
    ["background.legend_conjurer"]                = { pos = "Found a new calling as an entertainer", 		neg = "" },
    ["background.legend_conscript"]               = { pos = "Found a new regiment to serve", 				neg = "" },
    ["background.legend_conscript_ranged"]        = { pos = "Found a new regiment to serve", 				neg = "" },
    ["background.legend_crusader"]                = { pos = "Marched toward a new holy site", 				neg = "Headed deep into the desert, alone" },
    ["background.legend_death_summoner"]          = { pos = "", 											neg = "" },
    ["background.legend_dervish"]                 = { pos = "Returned to serve their faith", 				neg = "Left to seek penance" },
    ["background.legend_diviner"]                 = { pos = "Saw a new future for themselves", 				neg = "" },
    ["background.legend_donkey"]                  = { pos = "Left for greener pastures", 					neg = "Was sold to the butcher" },
    ["background.legend_druid"]                   = { pos = "Returned to the sacred groves", 				neg = "" },
    ["background.legend_druid_commander"]         = { pos = "Returned to the sacred groves", 				neg = "" },
    ["background.legend_enchanter"]               = { pos = "Left to pursue new arcane theories", 			neg = "" },
    ["background.legend_entrancer"]               = { pos = "Fell under the spell of a fine woman", 		neg = "Fell under the spell of a hexen" },
    ["background.legend_gladiator_prizefighter"]  = { pos = "Returned to blood-soaked arenas", 				neg = "" },
    ["background.legend_guildmaster"]             = { pos = "Returned to manage the guild", 				neg = "" },
    ["background.legend_healer"]                  = { pos = "Mended wounds in a distant village", 			neg = "" },
    ["background.legend_herbalist"]               = { pos = "Founded a potions shop", 						neg = "" },
    ["background.legend_horse"]                   = { pos = "Began a new life roaming the steppes", 		neg = "Eaten by the men" },
    ["background.legend_horserider"]              = { pos = "Found employment in noble stables", 			neg = "" },
    ["background.legend_horse_courser"]           = { pos = "Joined a jousting company", 					neg = "" },
    ["background.legend_horse_destrier"]          = { pos = "Rode off into the sunset", 					neg = "" },
    ["background.legend_horse_rouncey"]           = { pos = "", 											neg = "" },
    ["background.legend_husk"]                    = { pos = "", 											neg = "" },
    ["background.legend_illusionist"]             = { pos = "Vanished in a puff of smoke", 					neg = "" },
    ["background.legend_inventor"]                = { pos = "Setup a prosthesis shop", 						neg = "" },
    ["background.legend_ironmonger"]              = { pos = "Returned to the heat of the forge", 			neg = "" },
    ["background.legend_leech_peddler"]           = { pos = "Headed into the swamps for new stock",		 	neg = "" },
    ["background.legend_legion_auxiliary"]        = { pos = "Found a noble company to serve", 				neg = "" },
    ["background.legend_legion_centurion"]        = { pos = "Hired to a nobleman\'s retinue", 				neg = "" },
    ["background.legend_legion_gladiator"]        = { pos = "", 											neg = "" },
    ["background.legend_legion_honour_guard"]     = { pos = "", 											neg = "" },
    ["background.legend_legion_legate"]           = { pos = "", 											neg = "" },
    ["background.legend_legion_legionary"]        = { pos = "", 											neg = "" },
    ["background.legend_legion_prefect"]          = { pos = "", 											neg = "" },
    ["background.legend_lonewolf"]                = { pos = "Returned to the solitary path", 				neg = "" },
    ["background.legend_lurker"]                  = { pos = "", 											neg = "" },
    ["background.legend_magister"]                = { pos = "Returned to the archive arcana", 				neg = "" },
    ["background.legend_man_at_arms"]             = { pos = "Found a new lord to serve", 					neg = "" },
    ["background.legend_master_archer"]           = { pos = "Hired by a noble family as a tutor", 			neg = "" },
    ["background.legend_muladi"]                  = { pos = "", 											neg = "" },
    ["background.legend_necromancer"]             = { pos = "Sought unimaginable power", 					neg = "" },
    ["background.legend_necrosavant"]             = { pos = "Left for a forbidden place", 					neg = "" },
    ["background.legend_necro"]                   = { pos = "", 											neg = "" },
    ["background.legend_commander_necro"]         = { pos = "", 											neg = "" },
    ["background.legend_nightwatch"]              = { pos = "", 											neg = "" },
    ["background.legend_noble_2h"]                = { pos = "", 											neg = "" },
    ["background.legend_noble_background"]        = { pos = "Returned to their noble house", 				neg = "" },
    ["background.legend_noble_commander"]         = { pos = "", 											neg = "" },
    ["background.legend_noble_ranged"]            = { pos = "", 											neg = "" },
    ["background.legend_noble_shield"]            = { pos = "", 											neg = "" },
    ["background.legend_peddler_commander"]       = { pos = "Went back to trade and barter", 				neg = "" },
    ["background.legend_philosopher"]             = { pos = "Found the meaning of life", 					neg = "" },
    ["background.legend_pilgrim"]                 = { pos = "Reached their sacred destination", 			neg = "" },
    ["background.legend_premonitionist"]          = { pos = "They saw what fate had in store for them", 	neg = "Failed to see their own death coming" },
    ["background.legend_preserver"]               = { pos = "Found a new calling selling fruit preserves", 	neg = "" },
    ["background.legend_puppet"]                  = { pos = "Death was only the beginning", 				neg = "" },
    ["background.legend_puppet_master"]           = { pos = "Found new toys to play with", 					neg = "" },
    ["background.legend_qiyan"]                   = { pos = "Found shady employment elsewhere", 			neg = "" },
    ["background.legend_ranger"]                  = { pos = "Disappeared into the wild frontiers", 			neg = "" },
    ["background.legend_ranger_commander"]        = { pos = "Disappeared into the wild frontiers", 			neg = "" },
    ["background.legend_runesmith"]               = { pos = "", 											neg = "" },
    ["background.legend_shieldmaiden"]            = { pos = "Left to join a group of famed companions", 	neg = "" },
    ["background.legend_spiritualist"]            = { pos = "Experienced a new spiritual awakening", 		neg = "" },
    ["background.legend_surgeon"]                 = { pos = "Saved lives elsewhere", 						neg = "" },
    ["background.legend_taxidermist"]             = { pos = "Pursuing their dream of a stuffed lindwurm", 	neg = "Arrested for erotic taxidermy" },
    ["background.legend_trader"]                  = { pos = "Found a new market for their goods", 			neg = "" },
    ["background.legend_trader_commander"]        = { pos = "Found a new market for their goods", 			neg = "" },
    ["background.legend_transmuter"]              = { pos = "", 											neg = "" },
    ["background.legend_vala"]                    = { pos = "Continued healing the world", 					neg = "" },
    ["background.legend_warlock"]                 = { pos = "", 											neg = "" },
    ["background.legend_warlock_summoner"]        = { pos = "", 											neg = "" },
    ["background.legend_witch"]                   = { pos = "Joined a foul coven", 							neg = "Hunted by the hexenjager" },
    ["background.legend_witch_commander"]         = { pos = "Established a new coven of misery", 			neg = "Killed by a hexenjager, some say the Wight" },
    ["background.legend_youngblood"]              = { pos = "Found a new cause to fight for", 				neg = "" },
    ["background.mage_background"]                = { pos = "Sought a legendary arcane tome", 				neg = "" },
    ["background.mage_legend_mage_commander"]     = { pos = "", 											neg = "" }
};
