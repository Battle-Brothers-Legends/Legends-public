::Legends.addFallen <- function(_bro, _cause) {
	local fallen = {
		Name = _bro.getName(),
		Time = this.World.getTime().Days,
		TimeWithCompany = this.Math.max(1, _bro.getDaysWithCompany()),
		Kills = _bro.getLifetimeStats().Kills,
		Battles = _bro.getLifetimeStats().Battles,
		KilledBy = _cause,
		Expendable = ::Legends.Backgrounds.has(_bro, ::Legends.Background.Slave)
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
    [::Legends.Backgrounds.getID(::Legends.Background.AdventurousNoble)]              = { pos = "Set off on a new adventure",					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Anatomist)]                      = { pos = "Resumed their forbidden studies",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Apprentice)]                     = { pos = "Sought a new master",                         	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Assassin)]                       = { pos = "Returned to the underworld",                  	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.AssassinSouthern)]              = { pos = "Returned to the underworld",                  	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Barbarian)]                      = { pos = "Ventured back to the frozen north",           	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Bastard)]                        = { pos = "Moved on without name or claim",              	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.BeastSlayer)]                   = { pos = "Took up the hunt for monsters once more",     	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Beggar)]                         = { pos = "Worked the streets for more coin",            	neg = "Returned to the gutter" },
    [::Legends.Backgrounds.getID(::Legends.Background.BellyDancer)]                   = { pos = "Took their performance to new crowds",        	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Bowyer)]                         = { pos = "Resumed work with wood and sinew",            	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Brawler)]                        = { pos = "Sought a new fight",                          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Butcher)]                        = { pos = "Went back to the chopping block",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.CaravanHand)]                   = { pos = "Followed trade routes for their next job",    	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Companion)]                      = { pos = "Parted ways and went their own path",         	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.ConvertedCultist)]              = { pos = "Clung to their newly found beliefs",          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Cripple)]                        = { pos = "Struggled on, earning coin where they could", 	neg = "Left to die in the gutter" },
    [::Legends.Backgrounds.getID(::Legends.Background.Crucified)]                      = { pos = "Bore their scars while seeking new work",     	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Crusader)]                       = { pos = "Continued their righteous war",               	neg = "Took their unceasing zealotry elsewhere" },
    [::Legends.Backgrounds.getID(::Legends.Background.Cultist)]                        = { pos = "Slunk back to dark worship",                  	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Daytaler)]                       = { pos = "Earned their daily coin and moved on",        	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Deserter)]                       = { pos = "Kept hiding from banners and drums",          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.DisownedNoble)]                 = { pos = "Continued their exile in comfort",            	neg = "Left in a rage, swearing revenge" },
    [::Legends.Backgrounds.getID(::Legends.Background.Eunuch)]                         = { pos = "Found quiet employment where needed",         	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Farmhand)]                       = { pos = "Returned to the plow",                        	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Fisherman)]                      = { pos = "Headed for familiar waters",                  	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Flagellant)]                     = { pos = "Continued their path of painful penance",     	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Gambler)]                        = { pos = "Chased fortune at dice and cards",            	neg = "Chased fortune and lost it all, again" },
    [::Legends.Backgrounds.getID(::Legends.Background.Gladiator)]                      = { pos = "Returned to blood-soaked arenas",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Gravedigger)]                    = { pos = "Resumed digging graves for profit",           	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Graverobber)]                    = { pos = "Resumed robbing the recently deceased",       	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.HedgeKnight)]                   = { pos = "Took to wandering battlefields again",        	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Historian)]                      = { pos = "Lost themselves in dusty tomes",              	neg = "Their fate is lost to time" },
    [::Legends.Backgrounds.getID(::Legends.Background.Houndmaster)]                    = { pos = "Returned to beasts and leashes",              	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Hunter)]                         = { pos = "Disappeared into the deep woods",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Juggler)]                        = { pos = "Continued to entertain crowds",               	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.KillerOnTheRun)]              = { pos = "Kept running from the law",                   	neg = "Captured and hung within days of leaving" },
    [::Legends.Backgrounds.getID(::Legends.Background.KingsGuard)]                    = { pos = "Resumed sworn royal service",                 	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LindwurmSlayer)]                = { pos = "Sought out legendary beasts once more",       	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Lumberjack)]                     = { pos = "Returned to felling trees",                   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Manhunter)]                      = { pos = "Continued the pursuit of men",                	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Mason)]                          = { pos = "Resumed work with stone and mortar",          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Messenger)]                      = { pos = "Carried words and warnings afar",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Militia)]                        = { pos = "Went back to guarding their home",            	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Miner)]                          = { pos = "Returned to the depths below",                	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Miller)]                         = { pos = "Decided to grind grain for coin once more",   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Minstrel)]                       = { pos = "Set off to delight audiences anew",           	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Monk)]                           = { pos = "Returned to quiet contemplation",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.MonkTurnedFlagellant)]         = { pos = "Embraced suffering as faith",                 	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Nomad)]                          = { pos = "Drifted back to the shifting sands",          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.OrcSlayer)]                     = { pos = "Hunted greenskins wherever hired",            	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.PacifiedFlagellant)]            = { pos = "Sought peace after years of pain",            	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Paladin)]                        = { pos = "Continued their holy duty",                   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Peddler)]                        = { pos = "Went back to trade and barter",               	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Pimp)]                           = { pos = "Returned to the gutter trade",                	neg = "Destined to be a bitter nobody" },
    [::Legends.Backgrounds.getID(::Legends.Background.Poacher)]                        = { pos = "Slipped back into illicit hunts",             	neg = "Lost in the woods, never seen again" },
    [::Legends.Backgrounds.getID(::Legends.Background.Raider)]                         = { pos = "Returned to pillage and bloodshed",           	neg = "Got arrested for murder" },
    [::Legends.Backgrounds.getID(::Legends.Background.Ratcatcher)]                     = { pos = "Returned to filth and vermin",                	neg = "Allegedly devoured by vermin" },
    [::Legends.Backgrounds.getID(::Legends.Background.Refugee)]                        = { pos = "Finally found a place to call home",          	neg = "Captured by slavers" },
    [::Legends.Backgrounds.getID(::Legends.Background.RegentInAbsentia)]             = { pos = "Ruled from afar once more",                   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.RetiredSoldier)]                = { pos = "Laid down their arms for good",               	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Sellsword)]                      = { pos = "Fought for coin elsewhere",                   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Servant)]                        = { pos = "Found a new master",                          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Shepherd)]                       = { pos = "Returned to their flock",                     	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Slave)]                          = { pos = "Began a new life as a free man",              	neg = "Indebted once more" },
    [::Legends.Backgrounds.getID(::Legends.Background.Squire)]                         = { pos = "Sought a true knight to squire for",          	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Swordmaster)]                    = { pos = "Devoted themselves to the blade",             	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Tailor)]                         = { pos = "Returned to sewing clothes for coin",         	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Thief)]                          = { pos = "Stole a girl\'s heart, settled down",         	neg = "Stole from a brother, dismissed" },
    [::Legends.Backgrounds.getID(::Legends.Background.Vagabond)]                       = { pos = "Drifted along the open road",                 	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Wildman)]                        = { pos = "Wandered the wilds once more",                	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.Witchhunter)]                    = { pos = "Reported back to the guild",       	       	neg = "Believed killed by a hexen" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendAlchemist)]               = { pos = "Pursued the Philosopher's Stone", 			   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendBattleSister)]           = { pos = "Fought evil wherever she found it", 		   	neg = "Went back to the kitchen" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBeggar)]        = { pos = "", 										   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBeggarScaling)]     = { pos = "", 										   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendBerserker)]               = { pos = "Left to lead a pack of crazed warriors", 		neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderBerserker)]     = { pos = "Left to lead a pack of crazed warriors", 		neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendBlacksmith)]              = { pos = "Returned to the heat of the forge", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendBladedancer)]             = { pos = "Returned to the searing desert sands", 		neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendBountyHunter)]           = { pos = "Tracked down a high-value target", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderAssassin)]      = { pos = "Founded a deadly martial arts school", 	   	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCompanionMelee)]         = { pos = "Retired to become an innkeeper", 				neg = "Never forgave your betrayal" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCompanionRanged)]        = { pos = "Retired to become an innkeeper", 				neg = "Never forgave your betrayal" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendConscript)]               = { pos = "Found a new regiment to serve", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCrusader)]                = { pos = "Marched toward a new holy site", 				neg = "Headed deep into the desert, alone" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendDervish)]                 = { pos = "Returned to serve their faith", 				neg = "Left to seek penance" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendDonkey)]                  = { pos = "Left for greener pastures", 					neg = "Was sold to the butcher" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendDruid)]                   = { pos = "Returned to the sacred groves", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendGuildmaster)]             = { pos = "Returned to manage the guild", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHerbalist)]               = { pos = "Founded a potions shop", 						neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHorse)]                   = { pos = "Began a new life roaming the steppes", 		neg = "Eaten by the men" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHorserider)]              = { pos = "Found employment in noble stables", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHorseCourser)]           = { pos = "Joined a jousting company", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHorseDestrier)]          = { pos = "Rode off into the sunset", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHorseRouncey)]           = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendHusk)]                    = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendIllusionist)]             = { pos = "Vanished in a puff of smoke", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendInventor)]                = { pos = "Setup a prosthesis shop", 						neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendIronmonger)]              = { pos = "Returned to the heat of the forge", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLeechPeddler)]           = { pos = "Headed into the swamps for new stock",		 	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionAuxiliary)]        = { pos = "Found a noble company to serve", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionCenturion)]        = { pos = "Hired to a nobleman\'s retinue", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionGladiator)]        = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionHonourGuard)]     = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionLegate)]           = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionLegionary)]        = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionPrefect)]          = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLegionSlave)]          = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLonewolf)]                = { pos = "Returned to the solitary path", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendLurker)]                  = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendMagister)]                = { pos = "Returned to the archive arcana", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendManAtArms)]             = { pos = "Found a new lord to serve", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendMasterArcher)]           = { pos = "Hired by a noble family as a tutor", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendMuladi)]                  = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNecromancer)]             = { pos = "Sought unimaginable power", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNecrosavant)]             = { pos = "Left for a forbidden place", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNecro)]                   = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderNecro)]         = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNightwatch)]              = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNoble2h)]                = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderNoble)]         = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNobleRanged)]            = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendNobleShield)]            = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderPeddler)]       = { pos = "Went back to trade and barter", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendPilgrim)]                 = { pos = "Reached their sacred destination", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendPreserver)]               = { pos = "Found a new calling selling fruit preserves", 	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendPuppet)]                  = { pos = "Death was only the beginning", 				neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendPuppetMaster)]           = { pos = "Found new toys to play with", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendRanger)]                  = { pos = "Disappeared into the wild frontiers", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderRanger)]        = { pos = "Disappeared into the wild frontiers", 			neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendShieldmaiden)]            = { pos = "Left to join a group of famed companions", 	neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendSurgeon)]                 = { pos = "Saved lives elsewhere", 						neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendTaxidermist)]             = { pos = "Pursuing their dream of a stuffed lindwurm", 	neg = "Arrested for erotic taxidermy" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendVala)]                    = { pos = "Continued healing the world", 					neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendWarlock)]                 = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendWarlockSummoner)]        = { pos = "", 											neg = "" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendCommanderWitch)]         = { pos = "Established a new coven of misery", 			neg = "Killed by a hexenjager, some say the Wight" },
    [::Legends.Backgrounds.getID(::Legends.Background.LegendYoungblood)]              = { pos = "Found a new cause to fight for", 				neg = "" },
};
