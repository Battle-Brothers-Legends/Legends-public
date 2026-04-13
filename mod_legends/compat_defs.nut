::Legends.Compat <- {}

/** Because fuck you, that's why */
::Legends.Compat.normalizeVersion <- function (_version) {
	local parts = ::split(_version, ".");
	if (parts.len() == 1)
		return _version + ".0.0";
	if (parts.len() == 2)
		return _version + ".0";
	return _version;
}

/**
 *  For hooked mods that have no patches
 *  If no version provided, we don't care checking at all, incompat means incompat
 */
::Legends.Compat.HardIncompat <- {
	List = [],
	function add(_id, _lastKnownNotWorkingVersion = null, _replacement = null) {
		this.List.push({
			ID = _id,
			Version = _lastKnownNotWorkingVersion,
			Replacement = _replacement
		})
	}
};

/**
 * For hooked mods, that technically work, but might cause some weird issues
 */
::Legends.Compat.SoftIncompat <- {
	List = [],
	function add(_id, _lastKnownNotWorkingVersion = null, _replacement = null) {
		this.List.push({
			ID = _id,
			Version = _lastKnownNotWorkingVersion,
			Replacement = _replacement
		})
	}
};

/** For hooked mods that have patches by community */
::Legends.Compat.IncompatButPatched <- {
	List = [],
	function add(_id, _wherePatch, _patchModId = null) {
		this.List.push({
			ID = _id,
			Patch = _wherePatch,
			PatchID = _patchModId
		})
	}
}

/**
 * For hooked mods, that some version is working
 * version is array
 */
::Legends.Compat.OtherVersionCompat <- {
	List = [],
	function add(_id, _compatVersions) {
		this.List.push({
			ID = _id,
			Version = _compatVersions
		})
	}
}

/**
 * For mods that are not registered, have no hooks, no IDs, but add new stuff
 */
::Legends.Compat.IncompatNotRegistered <- {
	List = [],
	function add(_name, _filesToCheck, _replacement = null) {
		this.List.push({
			ID = _name,
			Files = _filesToCheck,
			Replacement = _replacement
		})
	}
}

/** Just a list of integrated mods, to prevent loading them again */
::Legends.Compat.Integrated <- [
	"mod_quickly_swap_items",
	"mod_legends_compat",
	"mod_buyback",
	"mod_events_delayed_fix",
	"mod_Jimmys_Tooltips",
	"mod_alwaysLootNamedItems",
	"mod_make_lindwurms_great_again",
	"mod_MINA", // More Indefinite Numeral Adjectives - a similar feature is implemented in legends
	"mod_tooltip_extension", // Rygar's perk tooltip
	"mod_turn_it_in",
	"mod_find_legendary_maps"
];

//region HardIncompat
::Legends.Compat.HardIncompat.add("mod_18bros", null, "Legends has more anyway.");
::Legends.Compat.HardIncompat.add("mod_AC", "1.30.33", "Instead use the newer ACU found in the AC Submod channel Pins"); // Accessory Companions
::Legends.Compat.HardIncompat.add("mod_allCripplesBecomeTheKingsGuard", "1.0");
::Legends.Compat.HardIncompat.add("and_justice_for_all", "1.4.0");
::Legends.Compat.HardIncompat.add("mod_autopilot", "23", "Instead use Hackflow's Autopilot New mod");
::Legends.Compat.HardIncompat.add("mod_auto_level", "1.1.1", "Instead use Hackflow's Bro Studio for something similar");
::Legends.Compat.HardIncompat.add("mod_avatar", "1.0.2");
::Legends.Compat.HardIncompat.add("mod_avgmax", "1.0"); // Average bro max stats
::Legends.Compat.HardIncompat.add("mod_backgrounds_attribute_ranges", "2.0.0");
::Legends.Compat.HardIncompat.add("backgroundBonuses"); // Nexus author states this is the "Reforged version"
::Legends.Compat.HardIncompat.add("backgroundBonusesMore"); //Calls for hard req of Hacks "More Backgrounds & Events" which is apparently not Legends compat according to Nexus comments on that mod
::Legends.Compat.HardIncompat.add("mod_background_perks", "2.6"); // Starting Perks by Background Hackflow
::Legends.Compat.HardIncompat.add("mod_balanced_tryout", "1.0"); // Balanced Tryouts
::Legends.Compat.HardIncompat.add("battle_fatigue", "0.5.0");
::Legends.Compat.HardIncompat.add("mod_best"); // overhaul conflicts
::Legends.Compat.HardIncompat.add("mod_better_bros", "1.1.0");
::Legends.Compat.HardIncompat.add("mod_brawny_nimble", "1.0.1");
::Legends.Compat.HardIncompat.add("mod_brigandMercenary", "2.34");
::Legends.Compat.HardIncompat.add("mod_broWithRandomPerks", "1.1");
::Legends.Compat.HardIncompat.add("mod_buffed_named_items", "1.0.0"); // GinoFelino version
::Legends.Compat.HardIncompat.add("CampaignTweakster", "6");
::Legends.Compat.HardIncompat.add("mod_cartupgrade", "1.0");
::Legends.Compat.HardIncompat.add("mod_challengeScenarioPack", "1.0");
::Legends.Compat.HardIncompat.add("mod_champion_beasts", "1.2.0", "Instead use Magic Concepts which is the Legends version of this"); // Necro's Vanila champ beasts.
::Legends.Compat.HardIncompat.add("mod_Chirutiru_enemies", "1", "Sellswords not compaible, there's Legends version of this mod (SSU) on Legends Discord"); // This entry should cover old Sellswords
::Legends.Compat.HardIncompat.add("sarisofoi_company_tabards"); // Company Tabards
::Legends.Compat.HardIncompat.add("comrades_mod", "4.3.0");
::Legends.Compat.HardIncompat.add("mod_desertswampSliders", "1.0"); // More map sliders
::Legends.Compat.HardIncompat.add("mod_effective_hitpoints", "2.0.0");
::Legends.Compat.HardIncompat.add("mod_elevation_bindings", "2");
::Legends.Compat.HardIncompat.add("Mod_Editable_Retinue_MSU", "3.0.3");
//::Legends.Compat.HardIncompat.add("mod_EIMO", "10.0.6"); // lately bug reports ceased, fixed?
::Legends.Compat.HardIncompat.add("TheEliteFewCore", "1.2");
//::Legends.Compat.HardIncompat.add("mod_elite_few", "2.4.1"); // Hackflow version
::Legends.Compat.HardIncompat.add("mod_enemyWithRandomPerks", "1.0");
::Legends.Compat.HardIncompat.add("mod_equal_stats", "1");
::Legends.Compat.HardIncompat.add("mod_equipment_loot_chance", "1.0.4");
::Legends.Compat.HardIncompat.add("mod_every_item_drops", "1.1.1"); // Waterplouf version
::Legends.Compat.HardIncompat.add("mod_extra_keybinds", "2.1.0"); // a lot of bug reports lately with this mod...
::Legends.Compat.HardIncompat.add("fantasyReforgedTrees");
::Legends.Compat.HardIncompat.add("mod_faster", null, "Use Swifter instead, found on Nexus");
::Legends.Compat.HardIncompat.add("mod_fastest", null, "Use Swifter instead, found on Nexus");
::Legends.Compat.HardIncompat.add("mod_legends_favoured_enemy_refund", "2.0.1");
::Legends.Compat.SoftIncompat.add("mod_fun_facts", "0.5.0"); // Seen some reports causing hard crashes with this mod. But new comments suggest issues might be fixed need more feedback vs Legends play
::Legends.Compat.HardIncompat.add("graven_passive_shield_damage_bonus", "1.0");
::Legends.Compat.HardIncompat.add("graven_plentiful_paints", "1.1");
::Legends.Compat.HardIncompat.add("mod_graze_and_crit");
::Legends.Compat.HardIncompat.add("mod_hackflows_perks", "1.4");
::Legends.Compat.HardIncompat.add("mod_hardened"); // Darx's RF submod
::Legends.Compat.HardIncompat.add("mod_healable_injury", "1.0");
::Legends.Compat.HardIncompat.add("Mod_Heavy_Injuries_MSU", "3.0.0");
::Legends.Compat.HardIncompat.add("mod_hireNaked", "1.0");
::Legends.Compat.HardIncompat.add("mod_hitpoint_injury", "1");
::Legends.Compat.HardIncompat.add("mod_Drakes_Improved_Ambitions", "1.4.1");
::Legends.Compat.HardIncompat.add("mod_IMBAvani");
::Legends.Compat.HardIncompat.add("mod_items_recipes", "2.0.0");
::Legends.Compat.HardIncompat.add("mod_jin", "1.0"); // Jurchen mod
::Legends.Compat.HardIncompat.add("mod_lifetime_stats", "1");
::Legends.Compat.HardIncompat.add("mod_lima_tactics"); // overhauls mods don't mix
::Legends.Compat.HardIncompat.add("lng_combat_tweak", "1.0");
::Legends.Compat.HardIncompat.add("mod_lessgr", "1.3");
::Legends.Compat.HardIncompat.add("mod_legendary_kriegsgeist_boss_location", "1.0.5"); // SSU has more updated version of this now
::Legends.Compat.HardIncompat.add("mod_menace", "0.03");
::Legends.Compat.HardIncompat.add("mod_more_buildings", "0.5");
::Legends.Compat.HardIncompat.add("mod_more_champions_x5");
::Legends.Compat.HardIncompat.add("mod_more_champions_x10");
::Legends.Compat.HardIncompat.add("mod_more_champions_x25");
::Legends.Compat.HardIncompat.add("mod_more_followers", "1.1");
::Legends.Compat.HardIncompat.add("mod_more_followers_fixed", "1.3", "Think twice before installing mods written ai slop mods mid run"); // we're not supporting ai slop mods
::Legends.Compat.HardIncompat.add("mod_moreRecruits", "2", "For more recruits a safe alternative seems to be Necro's World Editor");
::Legends.Compat.HardIncompat.add("mod_more_weapon_skins", "0.8.0"); // Many of Karl's skins are being integ into Legends
::Legends.Compat.HardIncompat.add("mod_namedShieldsInShops", "1.0");
::Legends.Compat.HardIncompat.add("mod_necro", "0.3.0"); // Hackflow's Proper Necromancer
::Legends.Compat.HardIncompat.add("mod_no_hitcap", "1.0.0"); // "2022 edition"
::Legends.Compat.HardIncompat.add("mod_no_more_trash_named_weapons", "2");
::Legends.Compat.HardIncompat.add("mod_north_expansion", "0.7.2"); // Hamen's doing a Legends compat version in future let's fucking gooooo!
::Legends.Compat.HardIncompat.add("mod_origin_customizer", "2.2.4");
::Legends.Compat.HardIncompat.add("mod_pauseOnView", "3");
::Legends.Compat.HardIncompat.add("mod_legends_PTR", "2.2.2", "PTR ded, hue hue"); // PTR
::Legends.Compat.HardIncompat.add("quicker", "1.3.1", "Use Swifter instead, found on Nexus");
::Legends.Compat.HardIncompat.add("quirks", "0.8.0");
::Legends.Compat.HardIncompat.add("mod_raided", "1.0");
::Legends.Compat.HardIncompat.add("mod_repeatableOguTrophyAmbitions", "1.0");
::Legends.Compat.HardIncompat.add("mod_Recruits", "2");
::Legends.Compat.HardIncompat.add("mod_reforged");
// and reforged deps
::Legends.Compat.HardIncompat.add("mod_dynamic_perks");
::Legends.Compat.HardIncompat.add("mod_dynamic_spawns");
::Legends.Compat.HardIncompat.add("mod_item_tables");
::Legends.Compat.HardIncompat.add("mod_stack_based_skills");
::Legends.Compat.HardIncompat.add("mod_upd");
::Legends.Compat.HardIncompat.add("mod_modular_vanilla");
::Legends.Compat.HardIncompat.add("mod_nested_tooltips");

::Legends.Compat.HardIncompat.add("mod_RREI", "1.0.0"); // Replace and Restore Equipped Items
::Legends.Compat.HardIncompat.add("mod_rpgr_avatar_resistances", "1.5.0");
::Legends.Compat.HardIncompat.add("mod_Reproach_sword_upgrade", "1.0");
::Legends.Compat.HardIncompat.add("mod_RevampedXPSystem", "1.0.0");
::Legends.Compat.HardIncompat.add("zmod_rise_of_the_usurper", "1.0.0", "More recent Rotu vers found at Legends / Submods"); // old ass Nexus rotu version
::Legends.Compat.HardIncompat.add("mod_rpgr_raids", "4.0.1");
::Legends.Compat.HardIncompat.add("mod_save", "1.0.0"); // Enhanced Autosave
//::Legends.Compat.HardIncompat.add("mod_sellswords", "8.2.9"); // SSU, now Legends V19+ compatible
::Legends.Compat.HardIncompat.add("mod_smart_recruiter_legends", "1.0", "Use Clever Recruiter instead, found on Nexus");
::Legends.Compat.HardIncompat.add("mod_solostart", "1.0");
::Legends.Compat.HardIncompat.add("mod_southernNomad", "1.0");
::Legends.Compat.HardIncompat.add("mod_standout_enemies", "1.2");
::Legends.Compat.HardIncompat.add("mod_talents_reworked", "1");
::Legends.Compat.HardIncompat.add("mod_tavern_arena", "1.0");
::Legends.Compat.HardIncompat.add("mod_olto_l_temple_remove_injuries", "1.15");
::Legends.Compat.HardIncompat.add("mod_town_management", "0.1");
::Legends.Compat.HardIncompat.add("mod_true_balance", "1.8");
::Legends.Compat.HardIncompat.add("mod_two_for_one", "1.1.0");
::Legends.Compat.HardIncompat.add("mod_ultrabros", "3.3.0");
::Legends.Compat.HardIncompat.add("mod_undead_trophy_upgrade_reroll", "1.0");
::Legends.Compat.HardIncompat.add("mod_unlockFollower", "1");
::Legends.Compat.HardIncompat.add("mod_useful", "0.6");
::Legends.Compat.HardIncompat.add("mod_vap", "2.1.0"); // Veteran Attrs and Perks
::Legends.Compat.HardIncompat.add("mod_veteran_attributes", "2.0.0");
::Legends.Compat.HardIncompat.add("mod_veteranStamina", "4");
::Legends.Compat.HardIncompat.add("mod_veteranXPToRookies", "4"); // Veteran XP to Rookies
::Legends.Compat.HardIncompat.add("mod_warhammer", "1.0"); // old skaven mod
::Legends.Compat.HardIncompat.add("mod_wealth", "1");
::Legends.Compat.HardIncompat.add("mod_weapons", "0.27");
::Legends.Compat.HardIncompat.add("mod_world_parameters", "1.0.1");
::Legends.Compat.HardIncompat.add("mod_wushi", "1.0"); // Samurai mod
::Legends.Compat.HardIncompat.add("mod_new_named_weapons", "1.0"); // Zythaer's Better Weapons
::Legends.Compat.HardIncompat.add("mod_xpInReserve", "1.0"); // XP in Reserve
::Legends.Compat.HardIncompat.add("sato_corpse_loot_fix"); // Sato's Corpse Loot Fix
::Legends.Compat.HardIncompat.add("mod_career_stats", "1.0.2"); // I've seen this mod being the issue in logs as cause of errors
//endregion

//region SoftIncompat
::Legends.Compat.SoftIncompat.add("advanced_grader"); // Needs to be updated with Legends specific things to work with Legends
::Legends.Compat.SoftIncompat.add("mod_BLPT", "0.1.2"); // Darx's Bad Luck Protection
::Legends.Compat.SoftIncompat.add("mod_bro_storage", "1.0.2");
::Legends.Compat.SoftIncompat.add("mod_camps_and_artifacts", "3.4");
::Legends.Compat.SoftIncompat.add("mod_cultists", "1.04"); // Davkul Rising
::Legends.Compat.SoftIncompat.add("mod_fantasybro", "1.0"); // Yorik's "Legends patches are poorly built, yes even into FB V5"
::Legends.Compat.SoftIncompat.add("mod_find_legendary_locations", "1", "Legends has maps, that do the same");
::Legends.Compat.SoftIncompat.add("mod_necropolis", "1.0");
::Legends.Compat.SoftIncompat.add("mod_PLHO", "0.1.1"); // Darx's Player Hideout
::Legends.Compat.SoftIncompat.add("mod_retinue_ups", "1.2.1"); // Hackflow's Retinue Promotions
::Legends.Compat.SoftIncompat.add("mod_SAF", "1.0.0"); // Darx's Stackable Arena Fights
::Legends.Compat.SoftIncompat.add("mod_streamlined_ui", "1.0.3");
::Legends.Compat.SoftIncompat.add("mod_URUI", "1.2.0"); // Unrecognized UI
::Legends.Compat.SoftIncompat.add("mod_persistent_characters", "0.1.8", "Bro wages keep growing on reload");
::Legends.Compat.SoftIncompat.add("mod_bbforge", "0.4.3", "The equivalent of Breditor, if you are using bbforge do not report bug reports to the Legends Mod Team");
//endregion

//region IncompatButPatched
::Legends.Compat.IncompatButPatched.add("mod_breditor", "on Legends Discord (Breditor Containment Chamber in #submod_files), replace one from nexus. If you have it already, ignore this message.");
//endregion

//region OtherVersionCompat
::Legends.Compat.OtherVersionCompat.add("mod_plan_perks", ["5.0.0"]);
//endregion

//region IncompatNotRegistered
::Legends.Compat.IncompatNotRegistered.add("mod_anatomists", [
	"scripts/retinue/followers/remedist_follower.nut",
	"scripts/items/misc/essence_honor_guard_potion_item.nut",
	"scripts/items/misc/essence_geist_potion_item.nut"
]); // Anatomist Origin Rework
::Legends.Compat.IncompatNotRegistered.add("mod_1AC_MAIN", [
	"scripts/config/!!MAIN_IS_POLEARMS.nut",
	"scripts/config/!!MAIN_IS_POLEARMS.nut",
	"scripts/config/!!MAIN_IS_RECOVER.nut"
]); // Altered Combat Main
::Legends.Compat.IncompatNotRegistered.add("main", [
	"scripts/!mods_preload/mod_ae_perkBEYE.nut",
	"scripts/!mods_preload/mod_ae_perkDuelist.nut",
	"scripts/!mods_preload/mod_ae_perkRAdvantage.nut"
]); // Altered Things
::Legends.Compat.IncompatNotRegistered.add("difficulty", [
	"scripts/!mods_preload/mod_ae_difficulty.nut"
]); // Altered Things
::Legends.Compat.IncompatNotRegistered.add("aw_all_upd2020", [
	"scripts/skills/special/weapon_check.nut",
	"scripts/skills/special/stored_ap_1.nut",
	"scripts/skills/special/balance_check1.nut"
]); // Altered Weapons
::Legends.Compat.IncompatNotRegistered.add("mod_auto_recover", [
	"scripts/!mods_preload/mod_auto_recover.nut"
]); // Auto Recover
::Legends.Compat.IncompatNotRegistered.add("mod_better_kings_guard", [
	"scripts/skills/backgrounds/hidden_kings_guard_background.nut"
]); // Better King’s Guard
::Legends.Compat.IncompatNotRegistered.add("mod_contract", [
	"scripts/!mods_preload/mod_contract.nut",
	"scripts/config/z_mod_contracts.nut"
]); // Better Contracts in Late Game
::Legends.Compat.IncompatNotRegistered.add("mod_buffedNamedShields", [
	"scripts/!mods_preload/mod_buffedNamedShields.nut"
]); // Buffed Names Shields
::Legends.Compat.IncompatNotRegistered.add("mod_buffNamedWeaponsSlight", [
	"scripts/!mods_preload/mod_buffedNamedWeaponsSlight.nut"
]); // Buffed Named Weapons
::Legends.Compat.IncompatNotRegistered.add("data_991 (Campaign Tweakster)", [
	"scripts/!mods_preload/mod_campaignTweakster.nut"
]); // Campaign Tweakster
::Legends.Compat.IncompatNotRegistered.add("mod_rule_101_formations", [
	"scripts/config/z_mods_rule_000.nut",
	"scripts/config/z_mods_rule_000_formations.nut"
]); // Company Formations and all variations
::Legends.Compat.IncompatNotRegistered.add("Mod_Non_Company_Tabards", [
	"scripts/items/armor_upgrades/tabard_10_upgrade.nut",
	"scripts/items/armor_upgrades/tabard_11_upgrade.nut",
	"scripts/items/armor_upgrades/tabard_12_upgrade.nut"
]); // Company Tabards
::Legends.Compat.IncompatNotRegistered.add("mod_pots", [
	"scripts/entity/tactical/enemies/pot.nut",
	"scripts/config/mod_pots.nut"
]); // Cracking Pots Minigame in Arena
::Legends.Compat.IncompatNotRegistered.add("Craftable Autonomist Potions", [
	"scripts/crafting/blueprints/ifrit_potion_item_blueprint.nut",
	"scripts/crafting/blueprints/ijirok_potion_item_blueprint.nut",
	"scripts/crafting/blueprints/kraken_potion_item_blueprint.nut",
	"scripts/crafting/blueprints/lindwurm_potion_item_blueprint.nut",
	"scripts/crafting/blueprints/lorekeeper_potion_item_blueprint.nut",
	"scripts/crafting/blueprints/nachzehrer_potion_item_blueprint.nut",
	"scripts/crafting/blueprints/necromancer_potion_item_blueprint.nut"
]); // Craftable Autonomist Potion
::Legends.Compat.IncompatNotRegistered.add("craft_more_potions", [
	"scripts/items/accessory/berserker_mushrooms_item_preview.nut",
	"scripts/items/special/bodily_reward_item_preview.nut",
	"scripts/items/special/spiritual_reward_item_preview.nut",
	"scripts/items/tools/holy_water_item_preview.nut"
]); // Craft More Potions
::Legends.Compat.IncompatNotRegistered.add("mod_cultistOriginEventFrequency", [
	"scripts/!mods_preload/cultistOriginEventFrequencyTweaks.nut"
]); // Cultist Origin Event Frequency Increase
::Legends.Compat.IncompatNotRegistered.add("zzz_mod_Deathgun_by_firehand", [
	"scripts/!mods_preload/hs_added_perks.nut",
	"scripts/!mods_preload/items_for_hs_mod.nut",
	"scripts/entity/tactical/enemies/vampire_praetoriani.nut"
]); // Deathgun Mod
::Legends.Compat.IncompatNotRegistered.add("mod_deterministic_loot", [
	"scripts/!mods_preload/mod_deterministic_loot.nut"
]); // Deterministic Loot
::Legends.Compat.IncompatNotRegistered.add("dual_wielding", [
	"scripts/crafting/blueprints/flail_dw_blueprint.nut",
	"scripts/crafting/blueprints/heavy_southern_mace_dw_blueprint.nut",
	"scripts/crafting/blueprints/rondel_dagger_dw_blueprint.nut",
]); // Dual Wielding
::Legends.Compat.IncompatNotRegistered.add("mod.elves.dwarves", [
	"scripts/skills/backgrounds/dwarf_background.nut",
	"scripts/skills/backgrounds/elf_background.nut"
]); // Elves and Dwarves
::Legends.Compat.IncompatNotRegistered.add("mod_enchant_weapons", [
	"scripts/items/misc/enchant_potion_item.nut",
	"scripts/items/misc/potion_of_rename.nut",
	"scripts/items/misc/dumb_enchant_item.nut",
	"scripts/items/misc/rnamed_potion_item.nut",
	"scripts/!mods_preload/mod_enchant.nut"
]); // Enchant Weapon
::Legends.Compat.IncompatNotRegistered.add("Enclave's more Armour and Weapons for Legends", [
	"Enclave Armor Mod/data/scripts/items/helmets/kettle_sallet_1.nut",
	"Enclave Armor Mod/data/scripts/items/helmets/kettle_sallet_2.nut",
	"Enclave Armor Mod/data/scripts/items/helmets/kettle_sallet_3.nut"
]); //Enclave's more Armour and Weapons
::Legends.Compat.IncompatNotRegistered.add("Extra_Starting_Scenarios", [
	"scripts/scenarios/world/barbarians_scenario.nut",
	"scripts/scenarios/world/pros_scenario.nut",
	"scripts/scenarios/world/vaegirs_scenario.nut"
]); //Extra Starting Scenarios
::Legends.Compat.IncompatNotRegistered.add("z_artifacts_and_camps", [
	"scripts/skills/traits/preternatural_dodge_trait.nut",
	"scripts/skills/traits/bonus_stam_regen_trait.nut",
	"scripts/items/armor_upgrades/litany_of_speed.nut",
	"scripts/items/armor/artifact/artifact_armor.nut"
]); //Expanded Camps and Artifacts
::Legends.Compat.IncompatNotRegistered.add("mod_fencer", [
	"scripts/!mods_preload/mod_fencer.nut",
	"scripts/skills/actives/rush.nut"
]); // Fencer New Skill
::Legends.Compat.IncompatNotRegistered.add("Gender Scenarios", [
	"scripts/events/events/scenario/legend_gendered_seer_intro_event.nut",
	"scripts/events/events/scenario/legend_vala_mid_intro_event.nut",
	"scripts/scenarios/world/legends_gendered_seer_scenario.nut"
], "It's integrated into Legends"); // Gender Scenarios Legends
::Legends.Compat.IncompatNotRegistered.add("mod_removelastkillerrestriction", [
	"scripts/!mods_preload/mod_removelastkillerrestriction.nut"
]); // Get Loot Without Last Hit
::Legends.Compat.IncompatNotRegistered.add("Graverobbers-start", [
	"scripts/events/events/scenario/graverobbers_intro_event.nut",
	"scripts/scenarios/world/graverobbers_scenario.nut"
]); // Graverobbers Origin
::Legends.Compat.IncompatNotRegistered.add("zzz_mod_zzz_delz_houndmasterbgplus", [
	"scripts/items/accessory/accessory_dog.nut",
	"scripts/skills/actives/legend_unleash_warbear.nut",
	"scripts/skills/actives/unleash_animal.nut",
	"scripts/crafting/blueprints/wolf1_blueprint.nut"
]); // Houndmaster Class Perk Buff
::Legends.Compat.IncompatNotRegistered.add("mod_leaders_origins", [
	"scripts/scenarios/world/serpent_scenario.nut",
	"scripts/scenarios/world/shepherd_scenario.nut",
	"scripts/scenarios/world/stalker_scenario.nut",
	"scripts/scenarios/world/veteran_scenario.nut",
	"scripts/skills/backgrounds/order_knight_background.nut"
]); // Leaders
::Legends.Compat.IncompatNotRegistered.add("mod_oard", [
	"scripts/!mods_preload/mod_tohru_hooks.nut",
	"scripts/ai/tactical/agents/tohru_agent.nut",
	"scripts/mapgen/templates/tactical/tactical_hoard.nut"
]); //Legendary Location the Hoard
::Legends.Compat.IncompatNotRegistered.add("mod_spear", [
	"scripts/skills/actives/call_back.nut",
	"scripts/skills/actives/penetration.nut",
	"scripts/config/mod_spear.nut",
	"scripts/items/weapons/legendary/longinus_spear.nut"
]); // Legendary Spear
::Legends.Compat.IncompatNotRegistered.add("z_mod_legends_noble_uniform", [
	"scripts/!mods_preload/noble_uniform.nut"
]); // Legends Noble Army Uniforms
::Legends.Compat.IncompatNotRegistered.add("mod_lb", [
	"scripts/!mods_preload/mod_lb_faction_action.nut",
	"scripts/!mods_preload/mod_lb_contract.nut",
	"scripts/!mods_preload/mod_lb_location.nut"
]); //Limit Break Mod
::Legends.Compat.IncompatNotRegistered.add("Lone Chosen", [
	"scripts/skills/traits/hel_chosen_trait.nut",
	"scripts/skills/traits/soul_erased_trait.nut",
	"scripts/skills/traits/thor_chosen_trait.nut"
]); //Lone Chosen
::Legends.Compat.IncompatNotRegistered.add("mod_Lute_battle_song_skill", [
	"scripts/skills/actives/battle_song_skill.nut",
	"scripts/skills/effects/battle_song_effect.nut"
]); // Lute New Skill
::Legends.Compat.IncompatNotRegistered.add("Mercenary and Brigands Mod", [
	"scripts/skills/perks/perk_verytough.nut",
	"scripts/skills/perks/perk_veteran.nut",
	"scripts/skills/perks/perk_veteran2.nut",
	"scripts/skills/racial/brigands_racial.nut"
]); // Mercenary and Brigands Mod
::Legends.Compat.IncompatNotRegistered.add("mod_Universal_Helmets_2.0_Khtulhu", [
	"scripts/items/helmets/named/ahnenerbe_helmet.nut",
	"scripts/events/events/AI_vs_AI.nut",
	"scripts/!mods_preload/!mod_additional_equipment.nut"
]); // Mod Universal Helmets
::Legends.Compat.IncompatNotRegistered.add("1.2.3, more ammos mod", [
	"scripts/!mods_preload/mod_legendary_arrow.nut",
	"scripts/!mods_preload/mod_powders.nut",
	"scripts/items/ammo/magic_powder_bag.nut",
	"scripts/items/ammo/effective_powder_bag.nut",
	"scripts/!mods_preload/mod_ammos.nut"
]); // More Ammos
::Legends.Compat.IncompatNotRegistered.add("mod_more_champions", [
	"scripts/!mods_preload/mod_morechampions.nut"
]); // mod_more_champions
::Legends.Compat.IncompatNotRegistered.add("Mod_Morecrafting", [
	"scripts/crafting/blueprints/heraldic_plates_upgrade_blueprint.nut",
	"scripts/crafting/blueprints/joint_cover_upgrade_blueprint.nut",
	"scripts/crafting/blueprints/leather_neckguard_upgrade_blueprint.nut"
]); // More Crafting
::Legends.Compat.IncompatNotRegistered.add("mod_more_scaling_100", [
	"scripts/!mods_preload/mod_more_scaling_100.nut"
]); // More Scaling
::Legends.Compat.IncompatNotRegistered.add("mod_more_scaling_200", [
	"scripts/!mods_preload/mod_more_scaling_200.nut"
]); // More Scaling
::Legends.Compat.IncompatNotRegistered.add("mod_more_scaling_5", [
	"scripts/!mods_preload/mod_more_scaling_5.nut"
]); // More Scaling
::Legends.Compat.IncompatNotRegistered.add("Named Item Rarity in Shops", [
	"scripts/!mods_preload/mod_rarity.nut"
]); // Named Item Rarity in Shops
::Legends.Compat.IncompatNotRegistered.add("z_mod_OrcWarlords_named_2h_orc_axe_flail", [
	"scripts/!mods_preload/z_orc_2h_named.nut",
	"scripts/items/weapons/named/named_two_handed_orc_axe.nut",
	"scripts/items/weapons/named/named_two_handed_orc_flail.nut"
]); // Named Two Handed Orc Axe, Flail Stand Alone
::Legends.Compat.IncompatNotRegistered.add("Olto Mod", [
	"scripts/crafting/blueprints/armor_h_20_blueprint.nut",
	"scripts/crafting/blueprints/armor_h_30_blueprint.nut",
	"scripts/crafting/blueprints/armor_h_320_blueprint.nut"
]); // OltoMod Test
::Legends.Compat.IncompatNotRegistered.add("mod_obsidian_dagger", [
	"scripts/states/hook_tactical_state.nut"
]); // Obsidian Dagger Loot Fix
::Legends.Compat.IncompatNotRegistered.add("Main file (The Player NPC Equality Mod)", [
	"scripts/skills/perks/perk_drums_of_war.nut",
	"scripts/skills/perks/perk_iron_lungs.nut"
]); // The Player NPC Equality Mod
::Legends.Compat.IncompatNotRegistered.add("mod_tryout_talents_hooks", [
	"scripts/!mods_preload/tryout_talents.nut"
], "Use Clever Recruiter instead"); // Tryout Talents Alternative
::Legends.Compat.IncompatNotRegistered.add("WotN Perks", [
	"scripts/skills/perks/perk_last_stand.nut",
	"scripts/skills/perks/perk_lookout.nut",
	"scripts/skills/perks/perk_rebound.nut"
]); // Perks for Warriors of the North
::Legends.Compat.IncompatNotRegistered.add("Purchasable Perks", [
	"scripts/!mods_preload/store_add.nut",
	"scripts/items/bags_belt.nut",
	"scripts/items/book_cooking.nut"
]); // Purchasable Perks (legends)
::Legends.Compat.IncompatNotRegistered.add("mod_ReserveSize", [
	"scripts/!mods_preload/mod_reservesize.nut"
]); //Reserve Size
::Legends.Compat.IncompatNotRegistered.add("Sato Pot Tweaks", [
	"scripts/!mods_preload/mod_pots.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("Sato Potion Tweaks", [
	"scripts/!mods_preload/mod_potions.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("Sato Swordlance to Glaive", [
	"scripts/!mods_preload/mod_swordlances.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("sato_flail_tweaks", [
	"scripts/!mods_preload/mod_flails.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("sato_handgonne_tweaks", [
	"scripts/!mods_preload/mod_handgonne.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("sato_named_weapon_tweaks", [
	"scripts/!mods_preload/mod_named_weapons.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("sato_taxidermist_tweaks", [
	"scripts/!mods_preload/mod_taxidermist.nut"
]); // Sato’s Assorted Tweaks
::Legends.Compat.IncompatNotRegistered.add("sato_expanded_scenarios", [
	"scripts/!mods_preload/mod_sato_expanded_scenarios.nut",
	"scripts/scenarios/tactical/scenario_sato_barbarians.nut",
	"scripts/scenarios/tactical/scenario_sato_gilded.nut"
]); // Sato’s Expanded Scenarios
::Legends.Compat.IncompatNotRegistered.add("sato_established_company", [
	"scripts/events/events/scenario/sato_established_company_intro_event.nut",
	"scripts/scenarios/world/sato_established_company_scenario.nut"
]); // Sato’s Established Company Origin
::Legends.Compat.IncompatNotRegistered.add("sato_additional_equipment", [
	"scripts/!mods_preload/!mod_additional_equipment.nut",
	"scripts/items/helmets/closed_conic_helmet.nut",
	"scripts/items/helmets/closed_conic_helmet_with_mail.nut"
]); // Sato’s Additional Equipment
::Legends.Compat.IncompatNotRegistered.add("mod_settlement_situations_worldmap_tooltip", [
	"scripts/!mods_preload/mod_settlement_situations_worldmap_tooltip.nut"
]); // Settlement Situation Worldmap Tooltip
::Legends.Compat.IncompatNotRegistered.add("mod_stabilized_medium_armor_perk", [
	"scripts/config/stabilized_config.nut",
	"scripts/skills/perks/perk_stabilized.nut"
]); // Stabilized Perk
::Legends.Compat.IncompatNotRegistered.add("Sons of Spandau", [
	"scripts/events/events/scenario/spandau_intro_event.nut",
	"scripts/scenarios/world/spandau_scenario.nut"
]); // Sons of Spandau
::Legends.Compat.IncompatNotRegistered.add("mod_tactical_hit_factors", [
	"scripts/!mods_preload/mod_tactical_hit_factors.nut"
]); // Tactical Hit Factors
::Legends.Compat.IncompatNotRegistered.add("TheTrials", [
	"scripts/config/spawnlist_trials.nut",
	"scripts/events/events/triala.nut",
	"scripts/events/events/trialb.nut"
]); // The Battle Trials
::Legends.Compat.IncompatNotRegistered.add("The last Paladin", [
	"scripts/events/events/scenario/last_paladin_intro_event.nut",
	"scripts/scenarios/world/last_paladin_scenario.nut",
	"scripts/skills/backgrounds/paladin22_background.nut",
	"scripts/skills/perks/perk_warrior_of_the_light.nut"
]); // The last Paladin
::Legends.Compat.IncompatNotRegistered.add("mod_totemer", [
	"scripts/config/mod_totem.nut",
	"scripts/skills/backgrounds/totemer_background.nut",
	"scripts/items/weapons/totem_staff.nut"
]); // Totemer Origin
::Legends.Compat.IncompatNotRegistered.add("Nectomancy", [
	"scripts/config/x_more_perks.nut",
	"scripts/skills/actives/necromancy.nut",
	"scripts/skills/perks/perk_necromancy.nut"
]); // True Necromancy
::Legends.Compat.IncompatNotRegistered.add("mod_fallen_order", [
	"scripts/crafting/blueprints/order_kite_shield_blueprint2.nut",
	"scripts/crafting/blueprints/order_heater_shield_blueprint2.nut",
	"scripts/crafting/blueprints/order_holy_water_blueprint2.nut"
]); // UNFINISHED Fallen Order origin
::Legends.Compat.IncompatNotRegistered.add("mod_UnlimitedFoodAmmoParts", [
	"scripts/!mods_preload/FAP_ammo_item.nut",
	"scripts/!mods_preload/FAP_armor_parts_item.nut",
	"scripts/!mods_preload/FAP_cured_rations_item.nut"
]); // Unlimited Food Ammo Supplies
::Legends.Compat.IncompatNotRegistered.add("mod_location", [
	"scripts/!mods_preload/mod_location.nut"
]); // Unlock Camps
::Legends.Compat.IncompatNotRegistered.add("witcher_mod", [
	"scripts/skills/actives/gryphon_style.nut",
	"scripts/skills/actives/igni_skill.nut",
	"scripts/skills/actives/quen_skill.nut"
]); // Witcher Mod Revamp
::Legends.Compat.IncompatNotRegistered.add("witcher_mod PTR", [
	"scripts/skills/effects/willow_potion_effect.nut",
	"scripts/skills/effects/yrden_effect.nut",
	"scripts/skills/traits/sign_trait.nut"
]); // Witcher Mod Revamp
//endregion

//region TNF
::Legends.Compat.HardIncompat.add("tnf_allPoleAP");
::Legends.Compat.IncompatNotRegistered.add("tnf_17FatigueNimble", ["scripts/!mods_preload/tnf_17FatigueNimble.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_allRecipes", ["scripts/!mods_preload/tnf_allRecipes.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_ammoThrowSpear", ["scripts/!mods_preload/tnf_ammoThrowSpear.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_betterEagleEyes", ["scripts/!mods_preload/tnf_betterEagleEyes.nut"]);
::Legends.Compat.HardIncompat.add("tnf_discoverLocations");
::Legends.Compat.HardIncompat.add("tnf_expandedRetinue");
::Legends.Compat.HardIncompat.add("tnf_fixAmbitionUpdate");
::Legends.Compat.IncompatNotRegistered.add("tnf_fixKrakenQuests", ["scripts/!mods_preload/tnf_fixKrakenQuests.nut"]);
::Legends.Compat.HardIncompat.add("tnf_greenskinsNamedWeapons");
::Legends.Compat.HardIncompat.add("tnf_higherDifficulty");
::Legends.Compat.IncompatNotRegistered.add("tnf_keepCrusaderOrcSlayer", ["scripts/!mods_preload/tnf_keepCrusaderOrcSlayer.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_lessLawmen", ["scripts/!mods_preload/tnf_lessLawmen.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_lessTiny", ["scripts/!mods_preload/tnf_lessTiny.nut"]);
::Legends.Compat.HardIncompat.add("tnf_mdfTalent1HCompanion");
::Legends.Compat.HardIncompat.add("tnf_modRNG");
::Legends.Compat.IncompatNotRegistered.add("tnf_moreMilitia", ["scripts/!mods_preload/tnf_moreMilitia.nut"]);
::Legends.Compat.HardIncompat.add("tnf_namedShields");
::Legends.Compat.HardIncompat.add("tnf_newChampions");
::Legends.Compat.HardIncompat.add("tnf_noBadTraitsCompanions");
::Legends.Compat.IncompatNotRegistered.add("tnf_noFog", ["scripts/!mods_preload/tnf_noFog.nut"]);
::Legends.Compat.HardIncompat.add("tnf_noSwallowIndomitable");
::Legends.Compat.HardIncompat.add("tnf_oldNorseHelmet");
::Legends.Compat.HardIncompat.add("tnf_refillableNet");
::Legends.Compat.IncompatNotRegistered.add("tnf_rejects", ["scripts/!mods_preload/tnf_rejects.nut"]);
::Legends.Compat.HardIncompat.add("tnf_resistFXResilient");
::Legends.Compat.IncompatNotRegistered.add("tnf_resolveConfident", ["scripts/!mods_preload/tnf_resolveConfident.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_restoreTailorEvent", ["scripts/!mods_preload/tnf_restoreTailorEvent.nut"]);
::Legends.Compat.HardIncompat.add("tnf_revisedNamedItems");
::Legends.Compat.IncompatNotRegistered.add("tnf_seedAnalyzer", ["scripts/!mods_preload/tnf_seedAnalyzer.nut"]);
::Legends.Compat.HardIncompat.add("tnf_seeNamedItems");
::Legends.Compat.HardIncompat.add("tnf_survivorNineLives");
::Legends.Compat.IncompatNotRegistered.add("tnf_triesBowyer", ["scripts/!mods_preload/tnf_triesBowyer.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_trueNightOwl", ["scripts/!mods_preload/tnf_trueNightOwl.nut"]);
::Legends.Compat.IncompatNotRegistered.add("tnf_tryout", ["scripts/!mods_preload/tnf_tryout.nut"]);
//endregion
