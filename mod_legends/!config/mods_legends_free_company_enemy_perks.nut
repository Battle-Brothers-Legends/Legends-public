local gt = this.getroottable();

if (!("EnemyPerks" in ::Const))
{
	::Const.EnemyPerks <- {};
}

::Const.EnemyPerks.Default <- []

::Const.EnemyPerks.FreeCompanyArcher <- [
	[3, ["perk_legend_specialist_shortbow_skill", "perk_legend_specialist_shortbow_damage"], 4],
	[1, "perk_rotation", 2],
	[1, "perk_anticipation", 2],
	[1, "perk_bullseye", 1],
	[2, "perk_fast_adaption", 1],
	[1, "perk_pathfinder", 1],
	[1, "perk_relentless", 1],
	[1, "perk_quick_hands", 0]
]
::Const.EnemyPerks.FreeCompanyCrossbow <- [
	[2, "perk_legend_ballistics", 3],
	[1, "perk_anticipation", 2],
	[1, "perk_rotation", 2],
	[2, "perk_bullseye", 1],
	[1, "perk_fast_adaption", 1],
	[1, "perk_pathfinder", 1],
	[1, "perk_relentless", 1],
	[1, "perk_quick_hands", 0]
]
::Const.EnemyPerks.FreeCompanyLongbow <- [
	[3, "perk_berserk", 4],
	[3, "perk_head_hunter", 3],
	[3, "perk_overwhelm", 3],
	[4, "perk_legend_alert", 2],
	[3, "perk_anticipation", 2],
	[2, "perk_legend_ballistics", 2],
	[2, "perk_rotation", 2],
	[2, "perk_bullseye", 1],
	[1, "perk_fast_adaption", 1],
	[1, "perk_pathfinder", 1],
	[1, "perk_relentless", 1],
	[1, "perk_quick_hands", 0]
]


::Const.EnemyPerks.FreeCompanySpearman <- [ 
	[4, ["perk_legend_specialist_militia_skill", "perk_legend_specialist_militia_damage"], 4],
	[2, "perk_underdog", 3],
	[2, "perk_backstabber", 2],
	[2, "perk_shield_expert", 2],
	[1, "perk_crippling_strikes", 1],
	[1, "perk_fortified_mind", 1],
	[1, "perk_hold_out", 1],
	[1, "perk_steel_brow", 1],
	[1, "perk_recover", 0]
]
::Const.EnemyPerks.FreeCompanySlayer <- [ 
	[2, ["perk_legend_alert", "perk_relentless", "perk_overwhelm"], 5],
	[4, "perk_berserk", 3],
	[2, "perk_coup_de_grace", 3],
	[3, "perk_battle_forged", 3],
	[2, "perk_legend_big_game_hunter", 3],
	[3, "perk_legend_muscularity", 3],
	[2, "perk_adrenalin", 2],
	[2, "perk_crippling_strikes", 2],
	[4, "perk_legend_hair_splitter", 2],
	[1, "perk_backstabber", 1],
	[1, "perk_quick_hands", 1],
	[1, "perk_hold_out", 0],
	[1, "perk_steel_brow", 0]
]
::Const.EnemyPerks.FreeCompanyFootman <- [ 
	[2, ["perk_crippling_strikes", "perk_coup_de_grace"], 4],
	[3, "perk_battle_forged", 3],
	[3, "perk_legend_muscularity", 3],
	[2, "perk_legend_alert", 2],
	[2, "perk_adrenalin", 2],
	[1, "perk_overwhelm", 2],
	[1, "perk_fortified_mind", 1],
	[1, "perk_hold_out", 1],
	[1, "perk_steel_brow", 1],
	[1, "perk_brawny", 0]
]

::Const.EnemyPerks.FreeCompanyPikeman <- [
	[2, "perk_coup_de_grace", 3],
	[3, "perk_legend_muscularity", 3],
	[2, "perk_backstabber", 2],
	[1, "perk_footwork", 2],
	[1, "perk_overwhelm", 2],
	[1, "perk_anticipation", 1],
	[1, "perk_fortified_mind", 1],
	[1, "perk_hold_out", 1],
	[1, "perk_relentless", 1],
	[1, "perk_steel_brow", 0],
]
::Const.EnemyPerks.FreeCompanyBillman <- [
	[3, "perk_coup_de_grace", 3],
	[2, "perk_legend_muscularity", 3],
	[2, "perk_backstabber", 2],
	[1, "perk_footwork", 2],
	[1, "perk_overwhelm", 2],
	[1, "perk_anticipation", 1],
	[1, "perk_fortified_mind", 1],
	[1, "perk_relentless", 1],
	[1, "perk_steel_brow", 1],
	[1, "perk_colossus", 1],
	[1, "perk_hold_out", 0]
]

::Const.EnemyPerks.FreeCompanyInfantry <- [
	[3, "perk_battle_forged", 3],
	[3, "perk_legend_muscularity", 3],
	[2, "perk_legend_composure", 2],
	[3, "perk_legend_double_strike", 2],
	[3, "perk_legend_smackdown", 2],
	[1, "perk_backstabber", 1],
	[1, "perk_colossus", 1],
	[1, "perk_quick_hands", 1],
	[1, "perk_coup_de_grace", 0],
	[1, "perk_hold_out", 0],
	[1, "perk_steel_brow", 0]
]
::Const.EnemyPerks.FreeCompanyLeader <- [
	[4, "perk_berserk", 3],
	[3, "perk_legend_double_strike", 2],
	[1, ["perk_footwork", "perk_legend_tumble"], 2],
	[2, "perk_reach_advantage", 2],
	[3, "perk_legend_smackdown", 2],
	[1, "perk_backstabber", 1],
	[2, "perk_colossus", 1],
	[1, "perk_fast_adaption", 1],
	[1, "perk_rally_the_troops", 0],
	[1, "perk_quick_hands", 0],
	[1, "perk_battle_forged", 0]
]
