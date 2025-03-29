::Const.LegendMod.Outfits <- {};

if (!("LegendMod" in ::Const))
{
	::Const.LegendMod <- {};
}

if (!("OutfitObjs" in ::Const.LegendMod))
{
	::Const.LegendMod.OutfitObjs <- [];
}

::Const.LegendMod.OutfitObjs.extend([

{
	ID = "northern_mercenary_outfit_00",
	Body = [
		[1, "northern_mercenary_armor_00"]
	],
	Helmet = [
		[1, "northern_mercenary_helmet_00"]
	]
},
{
	ID = "northern_mercenary_outfit_01",
	Body = [
		[1, "northern_mercenary_armor_01"]
	],
	Helmet = [
		[1, "northern_mercenary_helmet_01"]
	]
},
{
	ID = "northern_mercenary_outfit_02",
	Body = [
		[1, "northern_mercenary_armor_02"]
	],
	Helmet = [
		[1, "northern_mercenary_helmet_02"]
	]
},
{
	ID = "barbarian_chosen_outfit_00",
	Body = [
		[1, "barbarian_chosen_armor_00"]
	],
	Helmet = [
		[1, "barbarian_chosen_helmet_00"]
	]
},
{
	ID = "barbarian_chosen_outfit_01",
	Body = [
		[1, "barbarian_chosen_armor_01"]
	],
	Helmet = [
		[1, "barbarian_chosen_helmet_01"]
	]
},
{
	ID = "barbarian_chosen_outfit_02",
	Body = [
		[1, "barbarian_chosen_armor_00"],
		[1, "barbarian_chosen_armor_01"]
	],
	Helmet = [
		[1, "barbarian_chosen_helmet_02"],
	]
},
{
	ID = "southern_knight_outfit_00",
	Body = [
		[1, "southern_knight_armor"]
	],
	Helmet = [
		[1, "southern_knight_helmet"]
	]
},
{
	ID = "brown_hedgeknight_outfit_00",
	Body = [
		[1, "brown_hedgeknight_armor"]
	],
	Helmet = [
		[1, "brown_hedgeknight_helmet"]
	]
},
{
	ID = "red_bandit_leader_outfit_00",
	Body = [
		[1, "red_bandit_leader_armor"]
	],
	Helmet = [
		[1, "red_bandit_leader_helmet"]
	]
},
{
	ID = "brown_monk_outfit_00",
	Body = [
		[1, "brown_monk_armor_00"]
	],
	Helmet = [
		[1, "brown_monk_helmet_00"]
	]
},
{
	ID = "dark_southern_outfit_00",
	Body = [
		[1, "dark_southern_armor_00"]
	],
	Helmet = [
		[1, "dark_southern_helmet_00"]
	]
},
{
	ID = "white_nomad_leader_outfit_00",
	Body = [
		[1, "white_nomad_leader_armor_00"]
	],
	Helmet = [
		[1, "white_nomad_leader_helmet_00"]
	]
},
{
	ID = "traze_northern_mercenary_outfit_00" //00 unneeded but nice if you want to add a second one in the future maybe
	Body = [
		[1, "traze_northern_mercenary_armor"]
	],
	Helmet = [
		[1, "traze_northern_mercenary_cap"]
	]
},
{
	ID = "mercenary_archer_outfit_00" //00 unneeded but nice if you want to add a second one in the future maybe
	Body = [
		[1, "mercenary_archer_armor_00"],
		[1, "mercenary_archer_armor_01"]
	],
	Helmet = [
		[1, "mercenary_archer_helmet_00"]
	]
},
{
	ID = "mercenary_infantry_outfit_00"
	Body = [
		[1, "mercenary_infantry_armor_00"]
	],
	Helmet = [
		[1, "mercenary_infantry_helmet_00"]
	]
},
{
	ID = "mercenary_infantry_outfit_01"
	Body = [
		[1, "mercenary_infantry_armor_01"]
	],
	Helmet = [
		[1, "mercenary_infantry_helmet_01"]
	]
},
{
	ID = "mercenary_crossbow_outfit_00"
	Body = [
		[1, "mercenary_crossbow_armor_00"]
	],
	Helmet = [
		[1, "mercenary_crossbow_helmet_00"],
		[1, "mercenary_crossbow_helmet_01"],
		[1, "mercenary_crossbow_helmet_02"]
	]
},
{
	ID = "mercenary_spearman_outfit_00"
	Body = [
		[1, "mercenary_spearman_armor_00"]
	],
	Helmet = [
		[1, "mercenary_spearman_helmet_00"]
	]
},
{
	ID = "mercenary_spearman_outfit_01"
	Body = [
		[1, "mercenary_spearman_armor_01"]
	],
	Helmet = [
		[1, "mercenary_spearman_helmet_01"]
	]
},
{
	ID = "mercenary_leader_outfit_uncommon_00"
	Body = [
		[1, "mercenary_leader_armor_uncommon_00"]
	],
	Helmet = [
		[1, "mercenary_leader_helmet_uncommon_00"]
	]
},
{
	ID = "mercenary_leader_outfit_00"
	Body = [
		[1, "mercenary_leader_armor_00"]
	],
	Helmet = [
		[1, "mercenary_leader_helmet_00"]
	]
},
{
	ID = "mercenary_leader_outfit_gilded_00"
	Body = [
		[1, "mercenary_leader_armor_gilded_00"]
	],
	Helmet = [
		[1, "mercenary_leader_helmet_gilded_00"]
	]
},
{
	ID = "mercenary_longbow_outfit_00"	//todo lazy
	Body = [
		[1, "mercenary_longbow_armor_00"]
	],
	Helmet = [
		[1, "mercenary_longbow_helmet_00"]
	]
},
{
	ID = "mercenary_billman_outfit_00"
	Body = [
		[1, "mercenary_billman_armor_00"]
	],
	Helmet = [
		[1, "mercenary_billman_helmet_00"]
	]
},
{
	ID = "low_tier_unit_catchall_outfit_00"
	Body = [
		[4, "basic_mail_shirt"],
		[4, "cultist_leather_robe"],
		[4, "gambeson"],
		[4, "leather_tunic"],
		[4, "legend_blacksmith_apron"],
	//	 [4, "mail_shirt"],
		[4, "padded_leather"],
		[4, "padded_surcoat"],
		[4, "ragged_dark_surcoat"],
		[1, "wizard_robe"]
	],
	Helmet = [
		[2, "oriental/nomad_leather_cap"],
		[2, "oriental/southern_head_wrap"],
		[1, "legend_headband_coin"],
		[1, "legend_headress_coin"],
		[1, "legend_southern_veil_coin"],
		[1, "legend_southern_veil"],
		[1, "legend_jewelry"],
		[3, "mercenary_archer_helmet_00"],
	//	 [3, "closed_mail_coif"],
		[3, "cultist_leather_hood"],
		[3, "dark_cowl"],
		[3, "full_aketon_cap"],
		[3, "headscarf"],
		[3, "hood"],
		[3, "hunters_hat"],
		[3, "jesters_hat"],
		[1, "magician_hat"],
		[3, "straw_hat"],
		[1, "witchhunter_hat"],
		[1, ""]
	]
},
{
	ID = "low_tier_unit_catchall_outfit_01"
	Body = [
		[4, "cultist_leather_robe"],
		[4, "gambeson"],
		[4, "leather_tunic"],
		[4, "legend_blacksmith_apron"],
		[4, "padded_leather"],
		[4, "padded_surcoat"],
		[4, "ragged_dark_surcoat"],
		[1, "wizard_robe"]
	],
	Helmet = [
		[2, "oriental/nomad_leather_cap"],
		[2, "oriental/southern_head_wrap"],
		[1, "legend_headband_coin"],
		[1, "legend_headress_coin"],
		[1, "legend_southern_veil_coin"],
		[1, "legend_southern_veil"],
		[1, "legend_jewelry"],
		[3, "mercenary_archer_helmet_00"],
		[3, "cultist_leather_hood"],
		[3, "dark_cowl"],
		[3, "full_aketon_cap"],
		[3, "headscarf"],
		[3, "hood"],
		[3, "hunters_hat"],
		[3, "jesters_hat"],
		[1, "magician_hat"],
		[3, "straw_hat"],
		[1, "witchhunter_hat"],
		[1, ""]
	]
},
{
	ID = "peasant_outfit_00"
	Body = [
		[1, "sackcloth"],
		[1, "thick_tunic"],
		[1, "apron"],
		[1, "tattered_sackcloth"],
		[4, "linen_tunic"]
	],
	Helmet = [
		[2, "straw_hat"],
		[2, "hood"],
		[2, "headscarf"],
		[2, "feathered_hat"],
		[1, ""]
	]
},
{
	ID = "caravan_guard_outfit_00"
	Body = [
		[1, "padded_leather"],
		[1, "padded_surcoat"]
	],
	Helmet = [
		[1, "hood"],
		[1, "full_aketon_cap"],
		[1, "headscarf"],
		[1, "nasal_helmet"],
		[1, "rondel_helm"],
		[1, "scale_helm"],
		[1, "padded_nasal_helmet"]
	]
},
{
	ID = "caravan_hand_outfit_00"
	Body = [
		[1, "leather_tunic"],
		[1, "padded_leather"],
		[1, "padded_surcoat"]
	],
	Helmet = [
		[1, "hood"],
		[1, "aketon_cap"]
	]
},
{
	ID = "bandit_poacher_outfit_00"
	Body = [
		[20, "leather_wraps"]
	],
	Helmet = [
		[1, "headscarf"],
		[1, "mouth_piece"]
	]
},
{
	ID = "legend_caravan_polearm_outfit_00"
	Body = [
		[1, "leather_tunic"],
		[1, "padded_leather"],
		[1, "padded_surcoat"]
	],
	Helmet = [
		[1, "hood"],
		[1, "aketon_cap"]
	]
},
{
	ID = "bandit_poacher_outfit_00"
	Body = [
		[20, "leather_wraps"]
	],
	Helmet = [
		[1, "headscarf"],
		[1, "mouth_piece"]
	]
},
{
	ID = "bandit_thug_outfit_00"
	Body = [
		[15, "leather_wraps"],
		[15, "thick_tunic"],
		[15, "monk_robe"],
		[15, "bandit_armor_light"],
		[15, "tattered_sackcloth"],
		[10, "leather_tunic"],
		[10, "blotched_gambeson"],
		[10, "ragged_surcoat"],
		[10, "padded_surcoat"],
		[10, "gambeson"]
	],
	Helmet = [
		[4, ""],
		[1, "hood"],
		[1, "open_leather_cap"],
		[1, "headscarf"],
		[1, "mouth_piece"],
		[1, "full_leather_cap"],
		[1, "aketon_cap"]
	]
},
{
	ID = "bandit_rabble_poacher_outfit_00"
	Body = [
		[20, "leather_wraps"],
		[20, "tattered_sackcloth"],
		[20, "legend_rabble_tunic"],
		[20, "monk_robe"],
		[20, "legend_rabble_fur"],
		[5, ""]
	],
	Helmet = [
		[2, ""],
		[1, "headscarf"],
		[1, "mouth_piece"]
	]
},
{
	ID = "bandit_raider_outfit_00"
	Body = [
		[1, "bandit_armor_medium"],
		[2, "bandit_armor_light"],
		[2, "leather_lamellar"]
	],
	Helmet = [
		[1, "nasal_helmet"],
		[1, "rondel_helm"],
		[1, "barbute_helmet"],
		[1, "scale_helm"],
		[1, "dented_nasal_helmet"],
		[1, "rusty_mail_coif"],
		[1, "headscarf"],
		[1, "nasal_helmet_with_rusty_mail"]
	]
},
{
	ID = "bandit_raider_low_outfit_00"
	Body = [
		[10, "bandit_armor_light"],
		[20, "ragged_surcoat"],
		[20, "padded_leather"],
		[15, "worn_mail_shirt"],
		[15, "leather_lamellar"],
		[20, "patched_mail_shirt"]
	],
	Helmet = [
		[19, "nasal_helmet"],
		[19, "dented_nasal_helmet"],
		[19, "rusty_mail_coif"],
		[18, "headscarf"],
		[25, ""]
	]
},
{
	ID = "bandit_rabble_outfit_00"
	Body = [
		[20, "leather_wraps"],
		[20, "tattered_sackcloth"],
		[20, "legend_rabble_tunic"],
		[20, "monk_robe"],
		[20, "legend_rabble_fur"]
	],
	Helmet = [
		[1, ""]
	]
},
{
	ID = "noble_elite_footman_outfit_00"
	Body = [
		[1, "mercury_noble_elite_footman_00"]
	],
	Helmet = [
		[1, "mercury_noble_elite_footman_00"],
		[1, "mercury_noble_elite_footman_01"]
	]
},
{
	ID = "mercury_pollax_00"
	Body = [
		[1, "mercury_pollax_00"],
		[1, "mercury_pollax_01"]
	],
	Helmet = [
		[1, "mercury_pollax_00"],
		[1, "mercury_pollax_01"],
		[1, "mercury_pollax_02"],
	]
},
{
	ID = "mercury_pollax_colorful"
	Body = [
		[1, "mercury_pollax_colorful_00"],
		[1, "mercury_pollax_colorful_01"]
	],
	Helmet = [
		[1, "mercury_pollax_colorful"]
	]
},
{
	ID = "mercury_sureshot_00"
	Body = [
		[1, "mercury_sureshot_00"]
	],
	Helmet = [
		[1, "mercury_sureshot_00"]
	]
},
{
	ID = "mercury_sureshot_brown_00"
	Body = [
		[1, "mercury_sureshot_01"],
		[1, "mercury_sureshot_02"]
	],
	Helmet = [
		[1, "mercury_sureshot_01"]
	]
},
{
	ID = "mercury_sureshot_blue_00"
	Body = [
		[1, "mercury_sureshot_blue_00"]
	],
	Helmet = [
		[1, "mercury_sureshot_blue_00"]
	]
},
{
	ID = "mercury_sureshot_green_00"
	Body = [
		[1, "mercury_sureshot_green_00"]
	],
	Helmet = [
		[1, "mercury_sureshot_green_00"],
		[1, "mercury_sureshot_green_01"]
	]
},
{
	ID = "noble_footman_veteran_00"
	Body = [
		[1, "legend_noble_guard_armour"],
		[1, "mercury_royal_guard_00"]
	],
	Helmet = [
		[1, "mercury_royal_guard_00"],
		[1, "mercury_royal_guard_01"]
	]
},
]); 

foreach( i, v in ::Const.LegendMod.OutfitObjs )
{
	::Const.LegendMod.Outfits[v.ID] <- v;
}
