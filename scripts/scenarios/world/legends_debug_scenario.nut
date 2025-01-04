this.legends_debug_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.legends_debug_party";
		this.m.Name = "(Developer Debug)";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p]Debug mode for legends developers";
		this.m.Difficulty = 2;
		this.m.Order = 999;
		this.m.StashModifier = 2000;
	}

	function isValid()
	{
		return this.Const.LegendMod.DebugMode;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local partysize = 6;
		local broLevelMax = 11;

		for( local i = 0; i < partysize; i = ++i )
		{
			local broLevel = broLevelMax
			local broPerks = broLevel - 1;
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.setStartValuesEx(this.Const.CharacterBackgroundsRandom);
			bro.m.Level = broLevel;
			bro.m.LevelUps = broPerks;
			bro.m.PerkPoints = broPerks;
		}

		 local horsesize = 0;
		 for( local i = 0; i < horsesize; i = ++i )
		 {
		 	local broLevel = broLevelMax
		 	local broPerks = broLevel - 1;
		 	local bro;
		 	bro = roster.create("scripts/entity/tactical/player");
		 	bro.m.HireTime = this.Time.getVirtualTimeF();
		 	bro.setStartValuesEx(this.Const.HorseBackgrounds);
		 	bro.m.Level = broLevel;
		 	bro.m.LevelUps = broPerks;
		 	bro.m.PerkPoints = broPerks;
		 }

		this.World.Assets.getStash().resize(2000);

		//local bros = roster.getAll();
		//bros[0].m.Skills.add(this.new("scripts/skills/injury/cut_arm_injury"));
		//bros[1].m.Skills.add(this.new("scripts/skills/injury/deep_chest_cut_injury"));

		this.World.Assets.m.Money = 50000;
		this.World.Assets.m.ArmorParts = 200;
		this.World.Assets.m.Medicine = 200;
		this.World.Assets.m.Ammo = 200;
		this.World.Assets.m.Food = 200;
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);

		this.World.Assets.getStash().add(this.new("scripts/items/supplies/beer_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_curry_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/legend_liquor_item"));

		local banner = this.new("scripts/items/tools/player_banner");
		banner.setVariant(2);
		this.World.Assets.getStash().add(banner);
		local rune =  this.new("scripts/items/rune_sigils/legend_vala_inscription_token");
		rune.setRuneVariant(5);
		rune.updateRuneSigilToken();
		this.World.Assets.getStash().add(rune);

		local stashitems = [
			"accessory/bandage_item",
			"accessory/legend_wardog_item",
			"accessory/legend_armored_wardog_item",
			"accessory/legend_warhound_item",
			"accessory/legend_armored_warhound_item",
			"accessory/legend_wolf_item",
			"accessory/falcon_item",
			"accessory/legend_white_wolf_item",
			"accessory/legend_warbear_item",
			"supplies/roots_and_berries_item",
			"supplies/legend_fresh_fruit_item",
			"trade/legend_cooking_spices_trade_item",
			"supplies/ground_grains_item",
			"ammo/large_quiver_of_bolts",
			"ammo/legend_large_broad_head_bolts",
			"ammo/legend_large_broad_head_arrows",
			"ammo/legend_large_armor_piercing_bolts",
			"ammo/legend_large_armor_piercing_arrows"
		]

		foreach (si in stashitems)
		{
			local pla = this.new("scripts/items/" + si);
			this.World.Assets.getStash().add(pla);
		}

		local armors = [
			"cloth/legend_ancient_cloth",
			"cloth/legend_ancient_cloth_restored",
			"cloth/legend_apron_butcher",
			"cloth/legend_apron",
			"cloth/legend_gladiator_harness",
			"cloth/legend_gambeson",
			"cloth/legend_gambeson_plain",
			"cloth/legend_gambeson_wolf",
			"cloth/legend_gambeson_named",
			"cloth/legend_padded_surcoat",
			"cloth/legend_padded_surcoat_plain",
			"cloth/legend_peasant_dress",
			"cloth/legend_robes",
			"cloth/legend_robes_magic",
			"cloth/legend_robes_wizard",
			"cloth/legend_robes_nun",
			"cloth/legend_sackcloth_tattered",
			"cloth/legend_sackcloth",
			"cloth/legend_sackcloth_patched",
			"cloth/legend_thick_tunic",
			"cloth/legend_tunic",
			"cloth/legend_tunic_wrap",
			"cloth/legend_tunic_collar_thin",
			"cloth/legend_tunic_collar_deep",
			"cloth/legend_dark_tunic",
			"cloth/legend_tunic_noble",
			"cloth/legend_tunic_noble_named",
			"cloth/legend_southern_robe",
			"cloth/legend_southern_gambeson",
			"cloth/legend_southern_split_gambeson",
			"cloth/legend_southern_tunic",
			"cloth/legend_southern_noble_surcoat",
			"cloth/legend_knightly_robe",
			"cloth/anatomist_robe",
			"cloth/wanderers_coat",

			"chain/legend_armor_ancient_double_mail",
			"chain/legend_armor_ancient_mail",
			"chain/legend_armor_basic_mail",
			"chain/legend_armor_hauberk",
			"chain/legend_armor_hauberk_full",
			"chain/legend_armor_hauberk_full_named",
			"chain/legend_armor_hauberk_sleevless",
			"chain/legend_armor_mail_shirt",
			"chain/legend_armor_mail_shirt_simple",
			"chain/legend_armor_reinforced_mail",
			"chain/legend_armor_reinforced_mail_shirt",
			"chain/legend_armor_reinforced_rotten_mail_shirt",
			"chain/legend_armor_reinforced_worn_mail",
			"chain/legend_armor_reinforced_worn_mail_shirt",
			"chain/legend_armor_rusty_mail_shirt",
			"chain/legend_armor_short_mail",
			"chain/legend_southern_cloth",
			"chain/legend_southern_padded_chest",
			"chain/legend_southern_mail",
			"chain/wild_scale",

			"plate/legend_armor_leather_brigandine",
			"plate/legend_armor_leather_brigandine_hardened",
			"plate/legend_armor_leather_brigandine_hardened_full",
			"plate/legend_armor_leather_brigandine_named",
			"plate/legend_armor_leather_jacket",
			"plate/legend_armor_leather_jacket_named",
			"plate/legend_armor_leather_studded_jacket_named",
			"plate/legend_armor_leather_jacket_simple",
			"plate/legend_armor_leather_lamellar",
			"plate/legend_armor_leather_lamellar_harness_heavy",
			"plate/legend_armor_leather_lamellar_harness_reinforced",
			"plate/legend_armor_leather_lamellar_heavy",
			"plate/legend_armor_leather_lamellar_heavy_named",
			"plate/legend_armor_leather_lamellar_reinforced",
			"plate/legend_armor_leather_noble",
			"plate/legend_armor_leather_padded",
			"plate/legend_armor_leather_riveted",
			"plate/legend_armor_leather_riveted_light",
			"plate/legend_armor_leather_scale",
			"plate/legend_armor_plate_ancient_chest",
			"plate/legend_armor_plate_ancient_chest_restored",
			"plate/legend_armor_plate_ancient_gladiator",
			"plate/legend_armor_plate_ancient_harness",
			"plate/legend_armor_plate_ancient_mail",
			"plate/legend_armor_plate_ancient_scale",
			"plate/legend_armor_plate_ancient_scale_coat",
			"plate/legend_armor_plate_ancient_scale_harness",
			"plate/legend_armor_plate_chest",
			"plate/legend_armor_plate_chest_rotten",
			"plate/legend_armor_plate_cuirass",
			"plate/legend_armor_plate_milanese",
			"plate/legend_armor_plate_krastenbrust",
			"plate/legend_armor_plate_triangle",
			"plate/legend_armor_plate_full",
			"plate/legend_armor_plate_full_greaves",
			"plate/legend_armor_plate_full_greaves_named",
			"plate/legend_armor_plate_full_greaves_painted",
			"plate/legend_armor_scale",
			"plate/legend_armor_scale_coat",
			"plate/legend_armor_scale_coat_named",
			"plate/legend_armor_scale_coat_rotten",
			"plate/legend_armor_scale_shirt",
			"plate/legend_animal_hide_armor",
			"plate/legend_heavy_iron_armor",
			"plate/legend_hide_and_bone_armor",
			"plate/legend_reinforced_animal_hide_armor",
			"plate/legend_rugged_scale_armor",
			"plate/legend_scrap_metal_armor",
			"plate/legend_thick_furs_armor",
			"plate/legend_thick_plated_barbarian_armor",
			"plate/legend_southern_named_golden_plates",
			"plate/legend_southern_named_plates",
			"plate/legend_southern_plate_full",
			"plate/legend_southern_plate",
			"plate/legend_southern_padded",
			"plate/legend_southern_arm_guards",
			"plate/legend_southern_strips",
			"plate/legend_southern_leather_jacket",
			"plate/legend_southern_leather_plates",
			"plate/legend_southern_leather_scale",
			"plate/legend_southern_scale",
			"plate/undertakers_apron",

			"cloak/legend_shoulder_cloth",
			"cloak/legend_noble_shawl",
			"cloak/legend_dark_wooly_cloak",
			"cloak/legend_armor_cloak_common",
			"cloak/legend_armor_cloak_heavy",
			"cloak/legend_armor_cloak_crusader",
			"cloak/legend_armor_cloak_noble",
			"cloak/legend_sash",
			"cloak/legend_southern_scarf",
			"cloak/legend_animal_pelt",
			"cloak/legend_southern_scarf_wrap",
			"cloak/anatomist_hood",
			"cloak/decorative_hood",
			"cloak/fur_cloak",
			"cloak/dukes_cloak",
			"cloak/relic_hood",
			"cloak/tabbed_hood",

			"tabard/legend_common_tabard",
			"tabard/legend_noble_tabard",
			"tabard/legend_southern_wrap_right",
			"tabard/legend_southern_wrap_left",
			"tabard/legend_southern_wide_belt",
			"tabard/legend_noble_vest",
			"tabard/legend_southern_wrap",
			"tabard/legend_southern_shoulder_cloth",
			"tabard/legend_southern_overcloth",
			"tabard/legend_southern_tabard",

			"armor_upgrades/legend_additional_padding_upgrade",
			"armor_upgrades/legend_armor_stollwurm_scales_upgrade",
			"armor_upgrades/legend_armor_white_wolf_pelt_upgrade",
			"armor_upgrades/legend_barbarian_horn_upgrade",
			"armor_upgrades/legend_bone_platings_upgrade",
			"armor_upgrades/legend_direwolf_pelt_upgrade",
			"armor_upgrades/legend_double_mail_upgrade",
			"armor_upgrades/legend_heraldic_plates_upgrade",
			"armor_upgrades/legend_horn_plate_upgrade",
			"armor_upgrades/legend_joint_cover_upgrade",
			"armor_upgrades/legend_leather_neckguard_upgrade",
			"armor_upgrades/legend_leather_shoulderguards_upgrade",
			"armor_upgrades/legend_light_padding_replacement_upgrade",
			"armor_upgrades/legend_lindwurm_scales_upgrade",
			"armor_upgrades/legend_mail_patch_upgrade",
			"armor_upgrades/legend_metal_pauldrons_upgrade",
			"armor_upgrades/legend_metal_plating_upgrade",
			"armor_upgrades/legend_protective_runes_upgrade",
			"armor_upgrades/legend_unhold_fur_upgrade",
			"armor_upgrades/legend_pauldron_upgrade",
			"armor_upgrades/legend_pauldron_heavy_upgrade",
			"armor_upgrades/legend_pauldron_strong_upgrade",
			"armor_upgrades/legend_pauldron_stag_upgrade",
			"armor_upgrades/legend_pauldron_swan_upgrade",
			"armor_upgrades/legend_pauldron_named_upgrade",
			"armor_upgrades/legend_armor_spiked_collar_upgrade",
			"armor_upgrades/legend_armor_sacred_shield_upgrade",
			"armor_upgrades/legend_armor_skull_chain_upgrade",
			"armor_upgrades/legend_armor_chain_and_mail_upgrade",

			"runes/legend_rune_endurance",
			"runes/legend_rune_resilience",
			"runes/legend_rune_safety",

			"armor/legend_armor_crusader",
			"armor/legend_armor_rabble_fur",
			"armor/legend_armor_ranger",
			"armor/legend_armor_robes_cultist",
			"armor/legend_armor_seer_robes",
			"armor/legend_armor_vala_cloak",
			"armor/legend_armor_vala_dress",
			"armor/legend_armor_warlock_cloak",
			"armor/legend_armor_werewolf_mail",

			"legendary/legend_armor_mountain",
			"legendary/legend_armor_of_davkul",
			"legendary/legend_skin_armor",
			"legendary/legend_emperors_armor",
			"legendary/legend_emperors_armor_fake",
			"legendary/legend_ijirok_armor",
			"legendary/legend_armor_named_warlock_cloak",
			"legendary/legend_lindwurm_armor",

			"named/legend_black_leather_armor",
			"named/legend_armor_named_tabard",
			"named/legend_armor_cloak_rich",
			"named/legend_armor_cloak_emperors",
			"named/legend_blue_studded_mail_armor",
			"named/legend_brown_coat_of_plates_armor",
			"named/legend_golden_scale_armor",
			"named/legend_green_coat_of_plates_armor",
			"named/legend_heraldic_mail_armor",
			"named/legend_named_bronze_armor",
			"named/legend_named_golden_lamellar_armor",
			"named/legend_named_noble_mail_armor",
			"named/legend_named_plated_fur_armor",
			"named/legend_named_sellswords_armor",
			"named/legend_named_skull_and_chain_armor"

		];

		foreach(a in armors)
		{
			local item = this.new("scripts/items/legend_armor/" + a);

			this.logInfo("Adding " + a);
			this.World.Assets.getStash().add(item);
			for( local i = 0; i < item.m.Variants.len(); i = ++i )
			{
				this.logInfo("Adding " + a + " :: " + i);
				local vitem =  this.new("scripts/items/legend_armor/" + a);
				vitem.setVariant(item.m.Variants[i]);
				this.World.Assets.getStash().add(vitem);
			}
		}

		local weapons = [
			"ancient/ancient_spear",
			"ancient/ancient_sword",
			"ancient/bladed_pike",
			"ancient/broken_ancient_sword",
			"ancient/broken_bladed_pike",
			"ancient/crypt_cleaver",
			"ancient/falx",
			"ancient/khopesh",
			"ancient/legend_fan_axe",
			"ancient/legend_gladius",
			"ancient/rhomphaia",
			"ancient/warscythe",
			"ancient/legend_kopis",
			"ancient/legend_khopesh",
			"arming_sword",
			"barbarians/antler_cleaver",
			"barbarians/axehammer",
			"barbarians/blunt_cleaver",
			"barbarians/claw_club",
			"barbarians/crude_axe",
			//"barbarians/drum_item",
			"barbarians/heavy_javelin",
			"barbarians/heavy_rusty_axe",
			"barbarians/heavy_throwing_axe",
			"barbarians/rusty_warblade",
			"barbarians/skull_hammer",
			"barbarians/thorned_whip",
			"barbarians/two_handed_spiked_mace",
			"bardiche",
			"battle_whip",
			"billhook",
			"bludgeon",
			"boar_spear",
			"butchers_cleaver",
			"crossbow",
			"dagger",
			"falchion",
			"fencing_sword",
			"fighting_axe",
			"fighting_spear",
			"flail",
			"goedendag",
			"greataxe",
			"greatsword",
			"greenskins/goblin_bow",
			"greenskins/goblin_crossbow",
			"greenskins/goblin_falchion",
			"greenskins/goblin_heavy_bow",
			"greenskins/goblin_notched_blade",
			"greenskins/goblin_pike",
			"greenskins/goblin_spear",
			"greenskins/goblin_spiked_balls",
			"greenskins/goblin_staff",
			"greenskins/legend_blowgun",
			"greenskins/legend_bone_carver",
			"greenskins/legend_bough",
			"greenskins/legend_limb_lopper",
			"greenskins/legend_man_mangler",
			"greenskins/legend_meat_hacker",
			"greenskins/legend_skin_flayer",
			"greenskins/legend_skullbreaker",
			"greenskins/legend_skullsmasher",
			"greenskins/orc_axe",
			"greenskins/orc_axe_2h",
			"greenskins/orc_cleaver",
			"greenskins/orc_flail_2h",
			"greenskins/orc_javelin",
			"greenskins/orc_metal_club",
			"greenskins/orc_wooden_club",
			"hand_axe",
			"hatchet",
			"heavy_crossbow",
			"hooked_blade",
			"hunting_bow",
			"javelin",
			"knife",
			"legendary/legend_mage_swordstaff",
			"legendary/lightbringer_sword",
			"legendary/obsidian_dagger",
			"legend_longsword",
			"legend_battle_glaive",
			"legend_cat_o_nine_tails",
			"legend_chain",
			"legend_crusader_sword",
			"legend_drum",
			"legend_estoc",
			"legend_glaive",
			//"legend_great_khopesh",
			"legend_grisly_scythe",
			"legend_halberd",
			"legend_hammer",
			"legend_hand_crossbow",
			"legend_hoe",
			"legend_infantry_axe",
			"legend_military_goedendag",
			"legend_military_voulge",
			"legend_militia_glaive",
			"legend_mystic_staff",
			"legend_parrying_dagger",
			"legend_ranged_flail",
			"legend_ranged_wooden_flail",
			"legend_redback_dagger",
			"legend_reinforced_flail",
			"legend_saw",
			"legend_scythe",
			"legend_shiv",
			"legend_shovel",
			"legend_sickle",
			"legend_sling",
			"legend_northern_sling",
			"legend_staff",
			"legend_staff_gnarled",
			"legend_staff_vala",
			"legend_swordstaff",
			"legend_tipstaff",
			"legend_two_handed_club",
			"legend_voulge",
			"legend_wooden_pitchfork",
			"legend_wooden_spear",
			"legend_wooden_stake",
			"legend_katar",
			"light_crossbow",
			"longaxe",
			"longsword",
			"lute",
			"masterwork_bow",
			"military_cleaver",
			"military_pick",
			"militia_spear",
			"morning_star",
			"named/legend_named_longsword",
			"named/legend_named_blacksmith_hammer",
			"named/legend_named_estoc",
			"named/legend_named_flail",
			"named/legend_named_gladius",
			"named/legend_named_glaive",
			"named/legend_named_halberd",
			"named/legend_named_infantry_axe",
			"named/legend_named_military_goedendag",
			"named/legend_named_parrying_dagger",
			"named/legend_named_shovel",
			"named/legend_named_sickle",
			"named/legend_named_swordstaff",
			"named/legend_named_voulge",
			"named/legend_named_warhammer",
			"named/legend_named_butchers_cleaver",
			"named/named_axe",
			"named/named_bardiche",
			"named/named_battle_whip",
			"named/named_billhook",
			"named/named_bladed_pike",
			"named/named_cleaver",
			"named/named_crossbow",
			"named/named_crypt_cleaver",
			"named/named_dagger",
			"named/named_fencing_sword",
			"named/named_flail",
			"named/named_goblin_falchion",
			"named/named_goblin_heavy_bow",
			"named/named_goblin_pike",
			"named/named_goblin_spear",
			"named/named_greataxe",
			"named/named_greatsword",
			"named/named_handgonne",
			"named/named_heavy_rusty_axe",
			"named/named_heavy_southern_mace",
			"named/named_javelin",
			"named/named_khopesh",
			"named/legend_named_great_khopesh",
			"named/named_longaxe",
			"named/legend_named_longsword",
			"named/legend_named_lute",
			"named/named_mace",
			"named/named_orc_axe",
			"named/legend_named_orc_axe_2h",
			"named/named_orc_cleaver",
			"named/legend_named_orc_flail_2h",
			"named/named_pike",
			"named/named_polehammer",
			"named/named_polemace",
			"named/named_qatal_dagger",
			"named/named_rusty_warblade",
			"named/named_shamshir",
			"named/named_skullhammer",
			"named/named_spear",
			"named/named_spetum",
			"named/named_sword",
			"named/named_swordlance",
			"named/named_three_headed_flail",
			"named/named_throwing_axe",
			"named/named_two_handed_flail",
			"named/named_two_handed_hammer",
			"named/named_two_handed_mace",
			"named/named_two_handed_scimitar",
			"named/named_two_handed_spiked_mace",
			"named/named_warbow",
			"named/named_warbrand",
			"named/named_warhammer",
			"named/named_warscythe",
			"named/legend_named_royal_lance",
			"noble_sword",
			"oriental/composite_bow",
			"oriental/firelance",
			"oriental/handgonne",
			"oriental/heavy_southern_mace",
			"oriental/light_southern_mace",
			"oriental/nomad_mace",
			"oriental/nomad_sling",
			"oriental/polemace",
			"oriental/qatal_dagger",
			"oriental/saif",
			"oriental/swordlance",
			"oriental/two_handed_saif",
			"oriental/two_handed_scimitar",
			"pickaxe",
			"pike",
			"pitchfork",
			"polehammer",
			"reinforced_wooden_flail",
			"rondel_dagger",
			"scimitar",
			"scramasax",
			"shamshir",
			"shortsword",
			"short_bow",
			"spetum",
			"staff_sling",
			"three_headed_flail",
			"throwing_axe",
			"throwing_spear",
			"two_handed_flail",
			"two_handed_flanged_mace",
			"two_handed_hammer",
			"two_handed_mace",
			"two_handed_wooden_flail",
			"two_handed_wooden_hammer",
			"warbrand",
			"warfork",
			"warhammer",
			"war_bow",
			"winged_mace",
			"wonky_bow",
			"woodcutters_axe",
			"wooden_flail",
			"wooden_stick"
		]

		foreach(w in weapons)
		{
			local item = this.new("scripts/items/weapons/" + w);


			this.logInfo("Adding " + w);
			this.World.Assets.getStash().add(item);


			for( local i = 0; i < item.m.Variants.len(); i = ++i )
			{
				this.logInfo("Adding " + w + " :: " + i);
				local vitem =  this.new("scripts/items/weapons/" + w);
				vitem.setVariant(item.m.Variants[i]);
				this.World.Assets.getStash().add(vitem);
			}
		}

		// local shields = [
		// 	"legend_faction_tower_shield"
		// ]

		// foreach(w in shields)
		// {
		// 	this.logInfo("Adding " + w);
		// 	local pla = this.new("scripts/items/shields/" + w);
		// 	this.World.Assets.getStash().add(pla);
		// }

		local helmets = [
			"runes/legend_rune_bravery",
			"runes/legend_rune_clarity",
			"runes/legend_rune_luck",

			"hood/legend_helmet_goblin_scarf",
			"hood/legend_helmet_barb_chain_scarf",
			"hood/legend_helmet_barb_open_chain",
			"hood/legend_helmet_rotten_chain_scarf",
			"hood/legend_helmet_cloth_scarf",
			"hood/legend_helmet_cloth_bandana",
			"hood/legend_helmet_patched_hood",
			"hood/legend_helmet_simple_hood",
			"hood/legend_helmet_leather_cap",
			"hood/legend_helmet_padded_cap",
			"hood/legend_helmet_leather_hood",
			"hood/legend_helmet_padded_hood",
			"hood/legend_helmet_southern_cap",
			"hood/legend_helmet_southern_cap_dark",
			"hood/legend_helmet_southern_turban_light_hood",
			"hood/legend_helmet_southern_niqaab",
			"hood/legend_helmet_open_chain_hood",
			"hood/legend_helmet_chain_scarf",
			"hood/legend_helmet_aventail",
			"hood/legend_helmet_chain_hood",
			"hood/legend_helmet_chain_hood_full",
			"hood/legend_helmet_bronze_chain",
			"hood/legend_helmet_enclave_bevor",
			"hood/legend_helmet_southern_chain_hood",
			"hood/legend_helmet_southern_open_chain_hood",
			"hood/legend_helmet_southern_open_hood",
			"hood/legend_helmet_southern_niqaab",
			"hood/legend_helmet_cloth_cap",
			"hood/legend_helmet_barb_leather_cap",
			"hood/legend_helmet_southern_headband_coin",
			"hood/legend_helmet_mummy_bandage",
			"hood/legend_helmet_full_mask",
			"hood/legend_helmet_beak_hood",
			"hood/legend_helmet_enclave_bevor",

			"helm/legend_helmet_ancient_conic_helm",
			"helm/legend_helmet_ancient_kettle",
			"helm/legend_helmet_ancient_dome",
			"helm/legend_helmet_ancient_crested",
			"helm/legend_helmet_ancient_dome_tailed",
			"helm/legend_helmet_ancient_face_plate",
			"helm/legend_helmet_ancient_legionaire",
			"helm/legend_helmet_ancient_side_hawk",
			"helm/legend_helmet_ancient_tailed_conic_helm",
			"helm/legend_helmet_ancient_face_helm",
			"helm/legend_helmet_orc_strapped_helm",
			"helm/legend_helmet_orc_double_helm",
			"helm/legend_helmet_orc_elite_double_helm",
			"helm/legend_helmet_orc_scale_helm",
			"helm/legend_helmet_orc_great_helm",
			"helm/legend_helmet_orc_behemoth_helmet",
			"helm/legend_helmet_crude_metal_helm",
			"helm/legend_helmet_crude_cylinder_helm",
			"helm/legend_helmet_heavy_plate_helm",
			"helm/legend_helmet_barb_ritual_helm",
			"helm/legend_helmet_heavy_plate_helm_named",
			"helm/legend_helmet_crude_skull_helm",
			"helm/legend_helmet_heavy_spiked_helm",
			"helm/legend_helmet_southern_leather_helm",
			"helm/legend_helmet_southern_studded_leather_helm",
			"helm/legend_helmet_southern_cap_smooth",
			"helm/legend_helmet_southern_cap_spiked",
			"helm/legend_helmet_viking_helm",
			"helm/legend_helmet_norman_helm",
			"helm/legend_helmet_flat_top_helm_low",
			"helm/legend_helmet_flat_top_helm",
			"helm/legend_helmet_flat_top_helm_polished",
			"helm/legend_helmet_barbute",
			"helm/legend_helmet_barbute_named",
			"helm/legend_helmet_horsetail",
			"helm/legend_helmet_basinet",
			"helm/legend_helmet_bascinet_named",
			"helm/legend_helmet_enclave_great_bascinet",
			"helm/legend_helmet_enclave_venitian_bascinet",
			"helm/legend_helmet_kettle_helm_low",
			"helm/legend_helmet_kettle_helm",
			"helm/legend_helmet_kettle_helm_named",
			"helm/legend_helmet_deep_sallet_named",
			"helm/legend_helmet_deep_sallet",
			"helm/legend_helmet_enclave_kettle",
			"helm/legend_helmet_enclave_skullcap",
			"helm/legend_helmet_scale_helm",
			"helm/legend_helmet_rondel_helm",
			"helm/legend_helmet_wallace_sallet",
			"helm/legend_helmet_wallace_sallet_named",
			"helm/legend_helmet_flat_top_face_plate",
			"helm/legend_helmet_carthaginian",
			"helm/legend_helmet_conic_helm",
			"helm/legend_helmet_sallet",
			"helm/legend_helmet_nordic_helm_low",
			"helm/legend_helmet_nordic_helm",
			"helm/legend_helmet_nordic_helm_high",
			"helm/legend_helmet_bronze_helm",
			"helm/legend_helmet_great_helm",
			"helm/legend_helmet_enclave_great_helm",
			"helm/legend_helmet_legend_armet",
			"helm/legend_helmet_enclave_armet",
			"helm/legend_helmet_legend_frogmouth",
			"helm/legend_helmet_legend_frogmouth_close",
			"helm/legend_helmet_southern_gladiator_helm_crested",
			"helm/legend_helmet_southern_gladiator_helm_split",
			"helm/legend_helmet_southern_gladiator_helm_masked",
			"helm/legend_helmet_southern_helmet_nasal",
			"helm/legend_helmet_italo_norman_helm",
			"helm/legend_helmet_italo_norman_helm_named",
			"helm/legend_helmet_southern_conic_helm",
			"helm/legend_helmet_southern_named_conic",
			"helm/legend_helmet_southern_peaked_helm",
			"helm/legend_helmet_southern_peaked_nasal_helm",
			"helm/legend_helmet_legend_ancient_gladiator",
			"helm/legend_helmet_legend_ancient_legionaire_restored",
			"helm/legend_helmet_dentist_helmet",
			"helm/legend_helmet_tailed_conic",
			"helm/legend_helmet_legend_armet_01_named",
			"helm/legend_helmet_stag_helm",
			"helm/legend_helmet_swan_helm",
			"helm/legend_helmet_skin_helm",
			"helm/legend_helmet_rotten_flat_top_face_mask",
			"helm/legend_helmet_rotten_great_helm",
			"helm/legend_helmet_barb_metal_cap",


			"top/legend_helmet_hood_cloth_round",
			"top/legend_helmet_hood_cloth_wide",
			"top/legend_helmet_hood_cloth_square",
			"top/legend_helmet_cloth_long_hood",
			"top/legend_helmet_orc_horn_mask",
			"top/legend_helmet_orc_metal_mask",
			"top/legend_helmet_goblin_leaves",
			"top/legend_helmet_goblin_leaf_helm",
			"top/legend_helmet_goblin_gillie",
			"top/legend_helmet_goblin_leather_mask",
			"top/legend_helmet_goblin_leather_helm",
			"top/legend_helmet_goblin_chain_helm",
			"top/legend_helmet_goblin_spiked_helm",
			"top/legend_helmet_vampire_crown",
			"top/legend_helmet_ancient_crown",
			"top/legend_helmet_leather_hood_barb",
			"top/legend_helmet_nose_plate",
			"top/legend_helmet_headband_side",
			"top/legend_helmet_headband_nose",
			"top/legend_helmet_eyemask",
			"top/legend_helmet_chain_attachment",
			"top/legend_helmet_faceplate_flat",
			"top/legend_helmet_faceplate_curved",
			"top/legend_helmet_faceplate_short",
			"top/legend_helmet_cult_hood",
			"top/legend_helmet_faceplate_long",
			"top/legend_helmet_faceplate_winged",
			"top/legend_helmet_faceplate_snub_nose",
			"top/legend_helmet_faceplate_snub_slit",
			"top/legend_helmet_faceplate_sharp",
			"top/legend_helmet_enclave_great_jaw",
			"top/legend_helmet_facemask",
			"top/legend_helmet_faceplate_pointed",
			"top/legend_helmet_enclave_armet_visor",
			"top/legend_helmet_wallace_sallet_visor",
			"top/legend_helmet_wallace_sallet_visor_named",
			"top/legend_helmet_enclave_venitian_bascinet_visor",
			"top/legend_helmet_enclave_great_bascinet_visor",
			"top/legend_helmet_faceplate_pointed_slit",
			"top/legend_helmet_faceplate_full",
			"top/legend_helmet_bascinet_visor_named",
			"top/legend_helmet_southern_faceplate_bearded",
			"top/legend_helmet_mummy_mask",
			"top/legend_helmet_mummy_beard",
			"top/legend_helmet_faceplate_full_breaths",
			"top/legend_helmet_unhold_head_chain",
			"top/legend_helmet_unhold_head_spike",
			"top/legend_helmet_faceplate_gold",
			"top/legend_helmet_faceplate_full_gold",
			"top/legend_helmet_golden_helm",
			"top/legend_helmet_faceplate_raised",
			"top/legend_helmet_faceplate_full_01_named",
			"top/legend_helmet_golden_mask",
			"top/legend_helmet_warlock_skull",
			"top/legend_helmet_fencer_hat",
			"top/legend_helmet_fencer_hat",
			"top/legend_helmet_southern_veil",
			"top/legend_helmet_undertakers_scarf",
			"top/legend_helmet_helm_adornment",
			"top/legend_helmet_ancient_beard_mask",
			"top/legend_helmet_ancient_lion_mask",
			"top/legend_helmet_ancient_mask",

		//	"vanity/legend_helmet_orc_leather_mask",
			"vanity/legend_helmet_noble_southern_crown",
			"vanity/legend_helmet_noble_southern_hat",
			"vanity/legend_helmet_southern_noble_turban",
			"vanity/legend_helmet_southern_helm_tailed",
			"vanity/legend_helmet_southern_silk_headscarf",
			"vanity/legend_helmet_southern_feathered_turban",
			"vanity/legend_helmet_southern_turban_open",
			"vanity/legend_helmet_sack",
			"vanity/legend_helmet_antler",
			"vanity/legend_helmet_bear_head",
			"vanity/legend_helmet_beret",
			"vanity/legend_helmet_bull_horns",
			"vanity/legend_helmet_crown",
			"vanity/legend_helmet_faction_helmet",
			"vanity/legend_helmet_faction_decayed_helmet",
			"vanity/legend_helmet_faction_helmet_2",
			"vanity/legend_helmet_feather_band",
			"vanity/legend_helmet_feathered_hat",
			"vanity/legend_helmet_goat_horns",
			"vanity/legend_helmet_headband",
			"vanity/legend_helmet_horn_decorations",
			"vanity/legend_helmet_impaled_head",
			"vanity/legend_helmet_metal_bird",
			"vanity/legend_helmet_noble_buckle",
			"vanity/legend_helmet_noble_feather",
			"vanity/legend_helmet_noble_floppy_hat",
			"vanity/legend_helmet_noble_hat",
			"vanity/legend_helmet_ancient_wig",
			"vanity/legend_helmet_noble_hood",
			"vanity/legend_helmet_wreath",
			"vanity/legend_helmet_orc_bones",
			"vanity/legend_helmet_orc_great_horns",
			"vanity/legend_helmet_plait",
			"vanity/legend_helmet_ponytail",
			"vanity/legend_helmet_ram_horns",
			"vanity/legend_helmet_side_feather",
			"vanity/legend_helmet_southern_headband",
			"vanity/legend_helmet_southern_patterned_headband",
			"vanity/legend_helmet_southern_patterned_headwrap",
			"vanity/legend_helmet_southern_turban_open",
			"vanity/legend_helmet_southern_turban_full",
			"vanity/legend_helmet_southern_turban_light",
			"vanity/legend_helmet_southern_turban_feather",
			"vanity/legend_helmet_southern_top_tail",
			"vanity/legend_helmet_straw_hat",
			"vanity/legend_helmet_top_feather",
			"vanity/legend_helmet_wizard_cowl",
			"vanity/legend_helmet_wolf_helm",
			"vanity/legend_helmet_lion_pelt",
			"vanity/legend_helmet_royal_hood",
			"vanity/legend_helmet_mummy_headress",
			"vanity/legend_helmet_mummy_headband",
			"vanity/legend_helmet_southern_cloth_headress",
			"vanity/legend_helmet_undertakers_hat",
			"vanity/legend_helmet_thick_braid",
			"vanity/legend_helmet_physicians_hood",
			"vanity/legend_helmet_chaperon",
			"vanity/legend_helmet_felt_chaperon",
			"vanity/legend_helmet_southern_earings",
			"vanity/legend_helmet_southern_headress_coin",
			"vanity/legend_helmet_nun_habit",
			"vanity/legend_helmet_warlock_hood",
			"vanity/legend_helmet_goblin_bones",
			"vanity/legend_helmet_ancient_priest_hat",
			"vanity_lower/legend_helmet_back_crest",
			"vanity_lower/legend_helmet_back_feathers",
			"vanity_lower/legend_helmet_feather_crest",
			"vanity_lower/legend_helmet_knotted_tail",
			"vanity_lower/legend_helmet_orc_tail",
			"vanity_lower/legend_helmet_top_plume",
			"vanity_lower/legend_helmet_wings",
			"vanity_lower/legend_helmet_goblin_tail",
			"vanity/legend_helmet_mummy_crown_king",

			"helmets/legend_faction_helmet"
		]

		foreach(h in helmets)
		{
			local item = this.new("scripts/items/legend_helmets/" + h);

			if (item.m.Variants.len() == 0)
			{
				this.logInfo("Adding " + h);
				this.World.Assets.getStash().add(item);
				continue;
			}

			for( local i = 0; i < item.m.Variants.len(); i = ++i )
			{
				this.logInfo("Adding " + h + " :: " + i);
				local vitem =  this.new("scripts/items/legend_helmets/" + h);
				vitem.setVariant(item.m.Variants[i]);
				this.World.Assets.getStash().add(vitem);
			}
		}

		local asloots = [
		"helmets/legend_ancient_laurels",
		"helmets/legend_ancient_priest_diadem",
		"helmets/legend_ancient_lich_headpiece",
		"helmets/legend_goblin_leader_helmet",
		"helmets/legend_goblin_shaman_helmet",
		"helmets/legend_goblin_light_helmet",
		"helmets/legend_goblin_skirmisher_helmet",
		"helmets/legend_unhold_helmet_heavy",
		"helmets/legend_unhold_helmet_light",
		"helmets/legend_orc_berserker_helmet",
		"helmets/legend_ancient_wig"
		]

		foreach(h in asloots)
		{
			local item = this.new("scripts/items/legend_helmets/" + h);

			if (item.m.Variants.len() == 0)
			{
				this.logInfo("Adding " + h);
				local layers = item.getLootLayers();
				foreach (l in layers) {
					this.World.Assets.getStash().add(l);
				}

				continue;
			} else {
				for( local i = 0; i < item.m.Variants.len(); i = ++i )
				{
					this.logInfo("Adding " + h + " :: " + i);
					local vitem =  this.new("scripts/items/legend_helmets/" + h);
					vitem.setVariant(item.m.Variants[i]);
					local layers = vitem.getLootLayers();
					foreach (l in layers) {
						this.World.Assets.getStash().add(l);
					}
				}

			}

		}

	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 2), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 2), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
		s.setValidForDays(5);
		randomVillage.addSituation(s);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/civilians_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.legend_random_party_scenario_intro");
		}, null);
	}
});

