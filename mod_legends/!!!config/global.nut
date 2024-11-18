::Const.Serialization.Version <- 73;

::Const.Difficulty = {
	Easy = 0,
	Normal = 1,
	Hard = 2,
	Legendary = 3,
	BuyPriceMult = [
		0.95,
		1.0,
		1.05,
		1.1
	],
	SellPriceMult = [
		1.05,
		1.0,
		0.95,
		0.9
	],
	EnemyMult = [
		0.85,
		1.0,
		1.15,
		1.0
	],
	PaymentMult = [
		1.1,
		1.0,
		0.95,
		0.9
	],
	MinPayments = [
		100,
		50,
		30,
		10
	],
	MinHeadPayments = [
		15,
		10,
		5,
		1
	],
	HealMult = [
		1.0,
		0.66,
		0.33,
		0.1
	],
	RepairMult = [
		1.0,
		0.66,
		0.33,
		0.1
	],
	RetreatDefenseBonus = [
		30,
		20,
		10,
		0
	],
	XPMult = [
		1.1,
		1.0,
		1.0,
		1.0
	],
	MaxResources = [
		{
			Food = 300,
			Ammo = 250,
			Medicine = 100,
			ArmorParts = 100
		},
		{
			Food = 250,
			Ammo = 150,
			Medicine = 75,
			ArmorParts = 75
		},
		{
			Food = 200,
			Ammo = 100,
			Medicine = 50,
			ArmorParts = 75
		},
		{
			Food = 100,
			Ammo = 75,
			Medicine = 30,
			ArmorParts = 50
		}
	]
};

// Lookup table for default faction
::Const.EntityFaction <- [];

for (local i = -1; i < ::Const.EntityIcon.len(); i++) {
	::Const.EntityFaction.push(::Const.EntityType.getDefaultFaction(i));
}

::Const.EntityType.addNew <- function (_icon, _name, _plural, _faction = ::Const.FactionType.Generic) {
	local id = ::Const.EntityIcon.len();
	::Const.EntityIcon.push(_icon);
	::Const.Strings.EntityName.push(_name);
	::Const.Strings.EntityNamePlural.push(_plural);
	::Const.EntityFaction.push(_faction);
	return id;
}

::Const.EntityType.getDefaultFaction = function (_id) {
	if (_id < ::Const.EntityFaction.len() - 1)
		return ::Const.EntityFaction[_id + 1];
	return ::Const.FactionType.Generic;
}

::Const.EntityType.BanditRabble <-
	::Const.EntityType.addNew("rabble_orientation", "Bandit Rabble", "Bandit Rabble", this.Const.FactionType.Bandits);
::Const.EntityType.LegendCat <-
	::Const.EntityType.addNew("cat_orientation", "Cat", "Cats");
::Const.EntityType.LegendOrcElite <-
	::Const.EntityType.addNew("orc_elite_orientation", "Orc Elite", "Orc Elites", this.Const.FactionType.Orcs);
::Const.EntityType.LegendOrcBehemoth <-
	::Const.EntityType.addNew("orc_behemoth_orientation", "Orc Behemoth", "Orc Behemoths", this.Const.FactionType.Orcs);
::Const.EntityType.LegendWhiteDirewolf <-
	::Const.EntityType.addNew("white_direwolf_orientation", "White Direwolf", "White Direwolves", this.Const.FactionType.Beasts);
::Const.EntityType.LegendSkinGhoul <-
	::Const.EntityType.addNew("skin_ghoul_orientation", "Skin Ghoul", "Skin Ghouls", this.Const.FactionType.Beasts);
::Const.EntityType.LegendStollwurm <-
	::Const.EntityType.addNew("stollwurm_orientation", "Stollwurm", "Stollwurmer", this.Const.FactionType.Beasts);
::Const.EntityType.LegendRockUnhold <-
	::Const.EntityType.addNew("rock_unhold_orientation", "Rock Unhold", "Rock Unholds", this.Const.FactionType.Beasts);
::Const.EntityType.LegendRedbackSpider <-
	::Const.EntityType.addNew("redback_spider_orientation", "Redback Spider", "Redback Spiders", this.Const.FactionType.Beasts);
::Const.EntityType.LegendDemonAlp <-
	::Const.EntityType.addNew("demonalp_orientation", "Demon Alp", "Demon Alps", this.Const.FactionType.Beasts);
::Const.EntityType.LegendHexeLeader <-
	::Const.EntityType.addNew("hexen_leader_orientation", "Hexe Coven Leader", "Hexe Coven Leaders", this.Const.FactionType.Beasts);
::Const.EntityType.LegendGreenwoodSchrat <-
	::Const.EntityType.addNew("greenwood_schrat_orientation", "Heartwood Schrat", "Heartwood Schrats", this.Const.FactionType.Beasts);
::Const.EntityType.LegendGreenwoodSchratSmall <-
	::Const.EntityType.addNew("greenwood_schrat_small_orientation", "Heartwood Sapling", "Heartwood Saplings", this.Const.FactionType.Beasts);
::Const.EntityType.LegendWhiteWarwolf <-
	::Const.EntityType.addNew("white_direwolf_orientation", "White Warwolf", "White Warwolves", this.Const.FactionType.Beasts);
::Const.EntityType.LegendBanshee <-
	::Const.EntityType.addNew("banshee_orientation_2", "Winselmutter", "Winselmutters", this.Const.FactionType.Undead);
::Const.EntityType.LegendDemonHound <-
	::Const.EntityType.addNew("hollenhound_orientation", "Höllenhund", "Höllenhunds", this.Const.FactionType.Undead);
::Const.EntityType.LegendVampireLord <-
	::Const.EntityType.addNew("vampire_lord_orientation", "Necrosavant Lord", "Necrosavant Lords", this.Const.FactionType.Undead);
::Const.EntityType.BanditVeteran <-
	::Const.EntityType.addNew("banditveteran_orientation", "Bandit Veteran", "Bandit Veterans", this.Const.FactionType.Bandits);
::Const.EntityType.BanditWarlord <-
	::Const.EntityType.addNew("banditwarlord_orientation", "Bandit Warlord", "Bandit Warlords", this.Const.FactionType.Bandits);
::Const.EntityType.LegendPeasantButcher <-
	::Const.EntityType.addNew("butcher_orientation", "Butcher", "Butchers");
::Const.EntityType.LegendPeasantBlacksmith <-
	::Const.EntityType.addNew("blacksmith_orientation", "Blacksmith", "Blacksmiths");
::Const.EntityType.LegendPeasantMonk <-
	::Const.EntityType.addNew("monk_orientation", "Monk", "Monks");
::Const.EntityType.LegendPeasantFarmhand <-
	::Const.EntityType.addNew("farmhand_orientation", "Farmhand", "Farmhands");
::Const.EntityType.LegendPeasantMinstrel <-
	::Const.EntityType.addNew("minstrel_orientation", "Minstrel", "Minstrels");
::Const.EntityType.LegendPeasantPoacher <-
	::Const.EntityType.addNew("poacher_orientation", "Poacher", "Poachers");
::Const.EntityType.LegendPeasantWoodsman <-
	::Const.EntityType.addNew("woodcutter_orientation", "Woodcutter", "Woodsfolk");
::Const.EntityType.LegendPeasantMiner <-
	::Const.EntityType.addNew("miner_orientation", "Miner", "Miners");
::Const.EntityType.LegendPeasantSquire <-
	::Const.EntityType.addNew("squire_orientation", "Squire", "Squires");
::Const.EntityType.LegendPeasantWitchHunter <-
	::Const.EntityType.addNew("witchhunter_orientation", "Witch Hunter", "Witch Hunters");
::Const.EntityType.LegendHalberdier <-
	::Const.EntityType.addNew("halberdier_orientation", "Halberdier", "Halberdiers", this.Const.FactionType.NobleHouse);
::Const.EntityType.LegendSlinger <-
	::Const.EntityType.addNew("slinger_orientation", "Slinger", "Slingers", this.Const.FactionType.NobleHouse);
::Const.EntityType.LegendFencer <-
	::Const.EntityType.addNew("fencer_orientation", "Fencer", "Fencers", this.Const.FactionType.NobleHouse);
::Const.EntityType.BanditOutrider <-
	::Const.EntityType.addNew("banditoutrider_orientation", "Bandit Outrider", "Bandit Outriders", this.Const.FactionType.Bandits);
::Const.EntityType.LegendBear <-
	::Const.EntityType.addNew("bear_orientation", "Bear", "Bears", this.Const.FactionType.Beasts);
::Const.EntityType.LegendCatapult <-
	::Const.EntityType.addNew("catapult_01_orientation", "Catapult", "Catapults");
::Const.EntityType.LegendHorse <-
	::Const.EntityType.addNew("horse_orientation", "Horse", "Horses");
::Const.EntityType.SkeletonGladiator <-
	::Const.EntityType.addNew("gladiator_orientation", "Ancient Gladiator", "Ancient Gladiators", this.Const.FactionType.Undead);
::Const.EntityType.BanditRabblePoacher <-
	::Const.EntityType.addNew("rabble_poacher_orientation", "Bandit Rabble Poacher", "Bandit Rabble Poachers", this.Const.FactionType.Bandits);
::Const.EntityType.BanditVermes <-
	::Const.EntityType.addNew("bandit_raider_orientation", "Infected Bandit", "Bandit Vermes", this.Const.FactionType.Bandits);
::Const.EntityType.SatoManhunter <-
	::Const.EntityType.addNew("nomad_02", "Manhunter", "Manhunters", this.Const.FactionType.OrientalCityState);
::Const.EntityType.SatoManhunterVeteran <-
	::Const.EntityType.addNew("nomad_05", "Manhunter Veteran", "Manhunter Veterans", this.Const.FactionType.OrientalCityState);
::Const.EntityType.LegendMummyLight <-
	::Const.EntityType.addNew("mummy_light_orientation", "Embalmed Slave", "Embalmed Slaves", this.Const.FactionType.Undead);
::Const.EntityType.LegendMummyMedium <-
	::Const.EntityType.addNew("mummy_medium_orientation", "Embalmed Soldier", "Embalmed Soldiers", this.Const.FactionType.Undead);
::Const.EntityType.LegendMummyHeavy <-
	::Const.EntityType.addNew("mummy_heavy_orientation", "Embalmed Noble", "Embalmed Nobles", this.Const.FactionType.Undead);
::Const.EntityType.LegendMummyQueen <-
	::Const.EntityType.addNew("mummy_queen_orientation", "Embalmed Queen", "Embalmed Queens", this.Const.FactionType.Undead);
::Const.EntityType.KoboldFighter <-
	::Const.EntityType.addNew("kobold_fighter_orientation", "Kobold Fighter", "Kobold Fighters", this.Const.FactionType.Goblins);
::Const.EntityType.KoboldWolfrider <-
	::Const.EntityType.addNew("kobold_wolfrider_orientation", "Kobold Wolfrider", "Kobold Wolfriders", this.Const.FactionType.Goblins);
::Const.EntityType.LegendMummyPriest <-
	::Const.EntityType.addNew("mummy_priest_orientation", "Embalmed Priest", "Embalmed Priests", this.Const.FactionType.Undead);
::Const.EntityType.FreeCompanySpearman <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Spearman", "Free Company Spearmen");
::Const.EntityType.FreeCompanySlayer <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Slayer", "Free Company Slayers");
::Const.EntityType.FreeCompanyFootman <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Footman", "Free Company Footmen");
::Const.EntityType.FreeCompanyArcher <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Archer", "Free Company Archers");
::Const.EntityType.FreeCompanyCrossbow <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Crossbow", "Free Company Crossbows");
::Const.EntityType.FreeCompanyLongbow <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Longbow", "Free Company Longbows");
::Const.EntityType.FreeCompanyBillman <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Billman", "Free Company Billmen");
::Const.EntityType.FreeCompanyPikeman <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Pikeman", "Free Company Pikemen");
::Const.EntityType.FreeCompanyInfantry <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Infantry", "Free Company Infantry");
::Const.EntityType.FreeCompanyLeader <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Leader", "Free Company Leaders");
::Const.EntityType.FreeCompanyLeaderLow <-
	::Const.EntityType.addNew("mercenary_orientation", "Free Company Ringleader", "Free Company Ringleaders");
::Const.EntityType.SatoManhunterRanged <-
	::Const.EntityType.addNew("nomad_02", "Manhunter Handgonner", "Manhunter Handgonners", this.Const.FactionType.OrientalCityState);
::Const.EntityType.SatoManhunterVeteranRanged <-
	::Const.EntityType.addNew("nomad_05", "Manhunter Veteran Handgonner", "Manhunter Veteran Handgonners", this.Const.FactionType.OrientalCityState);
::Const.EntityType.LegendNobleGuard <-
	::Const.EntityType.addNew("footman_veteran_orientation", "Royal Guard", "Royal Guards", this.Const.FactionType.NobleHouse);
::Const.EntityType.LegendManAtArms <-
	::Const.EntityType.addNew("footman_veteran_orientation", "Veteran Knight", "Veteran Knights", this.Const.FactionType.NobleHouse);
::Const.EntityType.LegendBasiliskDrone <-
	::Const.EntityType.addNew("basilisk_drone_orientation", "Basilisk Drone", "Basilisk Drones", this.Const.FactionType.Beasts);
::Const.EntityType.LegendBasiliskDroneLow <-
	::Const.EntityType.addNew("basilisk_drone_orientation", "Basilisk Drone", "Basilisk Drones", this.Const.FactionType.Beasts);
::Const.EntityType.LegendCaravanPolearm <-
	::Const.EntityType.addNew("caravan_hand_orientation", "Caravan Polearm", "Caravan Polearms", this.Const.FactionType.Settlement);
::Const.EntityType.NobleEliteFootman <-
	::Const.EntityType.addNew("footman_veteran_orientation", "Elite Footman", "Elite Footmen", this.Const.FactionType.NobleHouse);
::Const.EntityType.NoblePollax <-
	::Const.EntityType.addNew("billman_orientation", "Pollaxe", "Pollaxes");
::Const.EntityType.NobleSureshot <-
	::Const.EntityType.addNew("arbalester_orientation", "Sureshot", "Sureshots");
::Const.EntityType.LegendBasiliskSentry <-
	::Const.EntityType.addNew("basilisk_drone_orientation", "Basilisk Sentries", "Basilisk Sentries", this.Const.FactionType.Beasts);
