if (!("Effects" in ::Legends))
	::Legends.Effects <- {};

if (!("Effect" in ::Legends))
	::Legends.Effect <- {};

::Legends.Effects.EffectDefObjects <- [];

::Legends.Effects.addEffectDefObjects <- function( _effectDefObjects )
{
	local size = ::Legends.Traits.TraitDefObjects.len();
	::Legends.Effects.TraitDefObjects.extend(_effectDefObjects);
	foreach (i, effectDefObjects in _effectDefObjects)
	{
		::Legends.Effect[effectDefObjects.Const] <- size + i;
	}
}

local effectsDefs = [];
effectsDefs.push({
	ID = "effects.dazed",
	Script = "scripts\skills\effects\dazed_effect",
	Name = "Dazed",
	Const = "Dazed"
});
effectsDefs.push({
	ID = "effects.stunned",
	Script = "scripts\skills\effects\stunned_effect",
	Name = "Stunned",
	Const = "Stunned"
});
effectsDefs.push({
	ID = "effects.sleeping",
	Script = "scripts\skills\effects\sleeping_effect",
	Name = "Sleeping",
	Const = "Sleeping"
});
effectsDefs.push({
	ID = "effects.riposte",
	Script = "scripts\skills\effects\riposte_effect",
	Name = "Riposte",
	Const = "Riposte"
});
effectsDefs.push({
	ID = "effects.bleeding",
	Script = "scripts\skills\effects\bleeding_effect",
	Name = "Bleeding",
	Const = "Bleeding"
});
effectsDefs.push({
	ID = "effects.spider_poison",
	Script = "scripts\skills\effects\spider_poison_effect",
	Name = "Poisoned",
	Const = "Poisoned"
});
effectsDefs.push({
	ID = "effects.holy_water",
	Script = "scripts\skills\effects\holy_water_effect",
	Name = "Sprayed with Blessed Water",
	Const = "HolyWater"
});
effectsDefs.push({
	ID = "effects.shieldwall",
	Script = "scripts\skills\effects\shieldwall_effect",
	Name = "Shieldwall",
	Const = "Shieldwall"
});
effectsDefs.push({
	ID = "effects.fake_charmed",
	Script = "scripts\skills\effects\fake_charmed_effect",
	Name = "Charmed",
	Const = "FakeCharmed"
});
effectsDefs.push({
	ID = "effects.charmed",
	Script = "scripts\skills\effects\charmed_effect",
	Name = "Charmed",
	Const = "Charmed"
});
effectsDefs.push({
	ID = "effects.spearwall",
	Script = "scripts\skills\effects\spearwall_effect",
	Name = "Spearwall",
	Const = "Spearwall"
});
effectsDefs.push({
	ID = "effects.distracted",
	Script = "scripts\skills\effects\distracted_effect",
	Name = "Distracted",
	Const = "Distracted"
});
effectsDefs.push({
	ID = "effects.adrenaline",
	Script = "scripts\skills\effects\adrenaline_effect",
	Name = "Adrenaline",
	Const = "Adrenaline"
});
effectsDefs.push({
	ID = "effects.drums_of_war",
	Script = "scripts\skills\effects\drums_of_war_effect",
	Name = "Drums of War",
	Const = "DrumsOfWat"
});
effectsDefs.push({
	ID = "effects.killing_frenzy",
	Script = "scripts\skills\effects\killing_frenzy_effect",
	Name = "Killing Frenzy!",
	Const = "KillingFrenzy"
});
effectsDefs.push({
	ID = "effects.rallied",
	Script = "scripts\skills\effects\rallied_effect",
	Name = "Rallied",
	Const = "Rallied"
});
effectsDefs.push({
	ID = "effects.insect_swarm",
	Script = "scripts\skills\effects\insect_swarm_effect",
	Name = "Swarm of Insects",
	Const = "InsectSwarm"
});
effectsDefs.push({
	ID = "effects.disarmed",
	Script = "scripts\skills\effects\disarmed_effect",
	Name = "Disarmed",
	Const = "Disarmed"
});
effectsDefs.push({
	ID = "effects.withered",
	Script = "scripts\skills\effects\withered_effect",
	Name = "Withered",
	Const = "Withered"
});
effectsDefs.push({
	ID = "effects.smoke",
	Script = "scripts\skills\effects\smoke_effect",
	Name = "Covered by Smoke",
	Const = "Smoke"
});
effectsDefs.push({
	ID = "effects.exhausted",
	Script = "scripts\skills\effects_world\exhausted_effect",
	Name = "Exhausted",
	Const = "Exhausted"
});
effectsDefs.push({
	ID = "effects.drunk",
	Script = "scripts\skills\effects_world\drunk_effect",
	Name = "Drunk",
	Const = "Drunk"
});
effectsDefs.push({
	ID = "effects.hangover",
	Script = "scripts\skills\effects_world\hangover_effect",
	Name = "Hangover",
	Const = "Hangover"
});
effectsDefs.push({
	ID = "effects.lorekeeper_potion",
	Script = "scripts\skills\effects\lorekeeper_potion_effect",
	Name = "Lorekeeper\'s Rib Bone",
	Const = "LorekeeperPotion"
});
effectsDefs.push({
	ID = "effects.berserker_mushrooms",
	Script = "scripts\skills\effects\berserker_mushrooms_effect",
	Name = "RAGE!!!",
	Const = "BerserkerMushrooms"
});
effectsDefs.push({
	ID = "effects.indomitable",
	Script = "scripts\skills\effects\indomitable_effect",
	Name = "Indomitable",
	Const = "Indomitable"
});
effectsDefs.push({
	ID = "effects.ancient_priest_potion",
	Script = "scripts\skills\effects\ancient_priest_potion_effect",
	Name = "Synapse Blockage",
	Const = "AncientPriestPotion"
});
effectsDefs.push({
	ID = "effects.afraid",
	Script = "scripts\skills\effects_world\afraid_effect",
	Name = "Afraid",
	Const = "Afraid"
});
effectsDefs.push({
	ID = "effects.trained",
	Script = "scripts\skills\effects_world\new_trained_effect",
	Name = "Training Experience",
	Const = "Trained"
});
effectsDefs.push({
	ID = "effects.net",
	Script = "scripts\skills\effects\net_effect",
	Name = "Trapped in Net",
	Const = "Net"
});
effectsDefs.push({
	ID = "effects.web",
	Script = "scripts\skills\effects\web_effect",
	Name = "Trapped in Web",
	Const = "Web"
});
effectsDefs.push({
	ID = "effects.rooted",
	Script = "scripts\skills\effects\rooted_effect",
	Name = "Trapped in Vines",
	Const = "Rooted"
});
effectsDefs.push({
	ID = "effects.kraken_ensnare",
	Script = "scripts\skills\effects\kraken_ensnare_effect",
	Name = "Entangled",
	Const = "KrakenEnsare"
});
effectsDefs.push({
	ID = "effects.serpent_ensnare",
	Script = "scripts\skills\effects\serpent_ensnare_effect",
	Name = "Entangled",
	Const = "SerpentEnsare"
});
effectsDefs.push({
	ID = "effects.goblin_shaman_potion",
	Script = "scripts\skills\effects\goblin_shaman_potion_effect",
	Name = "Hyperactive Sweat Glands",
	Const = "GoblinShamanPotion"
});
effectsDefs.push({
	ID = "effects.poison_coat",
	Script = "scripts\skills\effects\poison_coat_effect",
	Name = "Weapon coated with poison",
	Const = "PoisonCoat"
});
effectsDefs.push({
	ID = "effects.spider_poison_coat",
	Script = "scripts\skills\effects\spider_poison_coat_effect",
	Name = "Weapon coated with poison",
	Const = "SpiderPoisonCoat"
});
effectsDefs.push({
	ID = "effects.debilitating_attack",
	Script = "scripts\skills\effects\debilitating_attack_effect",
	Name = "Debilitating Attack",
	Const = "DebilitatingAttack"
});
effectsDefs.push({
	ID = "effects.goblin_poison",
	Script = "scripts\skills\effects\goblin_poison_effect",
	Name = "Poisoned",
	Const = "GoblinPoison"
});
effectsDefs.push({
	ID = "effects.goblin_grunt_potion",
	Script = "scripts\skills\effects\goblin_grunt_potion_effect",
	Name = "Reactive Leg Muscles",
	Const = "GoblinGruntPoison"
});
effectsDefs.push({
	ID = "effects.gruesome_feast",
	Script = "scripts\skills\effects\gruesome_feast_effect",
	Name = "Feasted",
	Const = "GruesomeFeast"
});
effectsDefs.push({
	ID = "effects.hex_slave",
	Script = "scripts\skills\effects\hex_slave_effect",
	Name = "Hex",
	Const = "HexSlave"
});
effectsDefs.push({
	ID = "effects.possessing_undead",
	Script = "scripts\skills\effects\possessing_undead_effect",
	Name = "Possessing Undead",
	Const = "PossessingUndead"
});
effectsDefs.push({
	ID = "effects.possessed_undead",
	Script = "scripts\skills\effects\possessed_undead_effect",
	Name = "Possessed",
	Const = "PossessedUndead"
});
effectsDefs.push({
	ID = "effects.acid",
	Script = "scripts\skills\effects\acid_effect",
	Name = "Sprayed with Acid",
	Const = "Acid"
});
effectsDefs.push({
	ID = "effects.whipped",
	Script = "scripts\skills\effects\whipped_effect",
	Name = "Whipped",
	Const = "Whipped"
});
effectsDefs.push({
	ID = "effects.alp_potion",
	Script = "scripts\skills\effects\alp_potion_effect",
	Name = "Enhanced Eye Rods",
	Const = "AlpPotion"
});
effectsDefs.push({
	ID = "effects.immune_to_poison",
	Script = "scripts\skills\effects\antidote_effect",
	Name = "Immune to Poison",
	Const = "ImmuneToPoison"
});
effectsDefs.push({
	ID = "effects.apotheosis_potion",
	Script = "scripts\skills\effects\apotheosis_potion_effect",
	Name = "Apotheosis",
	Const = "ApotheosisPotion"
});
effectsDefs.push({
	ID = "effects.battle_standard",
	Script = "scripts\skills\effects\battle_standard_effect",
	Name = "For the company!",
	Const = "BattleStandard"
});
effectsDefs.push({
	ID = "effects.berserker_rage",
	Script = "scripts\skills\effects\berserker_rage_effect",
	Name = "Rage",
	Const = "BerserkerRage"
});
effectsDefs.push({
	ID = "effects.hyena_potion",
	Script = "scripts\skills\effects\hyena_potion_effect",
	Name = "Subdermal Clotting",
	Const = "HyenaPotion"
});
effectsDefs.push({
	ID = "effects.captain",
	Script = "scripts\skills\effects\captain_effect",
	Name = "Inspired by nearby Leader",
	Const = "Captain"
});
effectsDefs.push({
	ID = "effects.cat_potion",
	Script = "scripts\skills\effects\cat_potion_effect",
	Name = "Heightened Reflexes",
	Const = "CatPotion"
});
effectsDefs.push({
	ID = "effects.chilled",
	Script = "scripts\skills\effects\chilled_effect",
	Name = "Chilled",
	Const = "Chilled"
});
effectsDefs.push({
	ID = "effects.debilitated",
	Script = "scripts\skills\effects\debilitated_effect",
	Name = "Debilitated",
	Const = "Debilitated"
});
effectsDefs.push({
	ID = "effects.direwolf_potion",
	Script = "scripts\skills\effects\direwolf_potion_effect",
	Name = "Elasticized Sinew",
	Const = "DirewolfPotion"
});
effectsDefs.push({
	ID = "effects.dodge",
	Script = "scripts\skills\effects\dodge_effect",
	Name = "Dodge",
	Const = "Dodge"
});
effectsDefs.push({
	ID = "effects.double_strike",
	Script = "scripts\skills\effects\double_strike_effect",
	Name = "Double Strike!",
	Const = "DoubleStrike"
});
effectsDefs.push({
	ID = "effects.fallen_hero_potion",
	Script = "scripts\skills\effects\fallen_hero_potion_effect",
	Name = "Reactive Muscle Tissue",
	Const = "FallenHeroPotion"
});
effectsDefs.push({
	ID = "effects.geist_potion",
	Script = "scripts\skills\effects\geist_potion_effect",
	Name = "Kinetic Coating",
	Const = "GeistPotion"
});
effectsDefs.push({
	ID = "effects.goblin_overseer_potion",
	Script = "scripts\skills\effects\goblin_overseer_potion_effect",
	Name = "Mutated Cornea",
	Const = "GoblinOverseerPotion"
});
effectsDefs.push({
	ID = "effects.hexe_potion",
	Script = "scripts\skills\effects\hexe_potion_effect",
	Name = "Sympathetic Call",
	Const = "HexePotion"
});
effectsDefs.push({
	ID = "effects.hex_master",
	Script = "scripts\skills\effects\hex_master_effect",
	Name = "Protected by a Hex",
	Const = "HexMaster"
});
effectsDefs.push({
	ID = "effects.honor_guard_potion",
	Script = "scripts\skills\effects\honor_guard_potion_effect",
	Name = "Subdermal Stitching",
	Const = "HonorGuardPotion"
});
effectsDefs.push({
	ID = "effects.horrified",
	Script = "scripts\skills\effects\horrified_effect",
	Name = "Horrified",
	Const = "Horrified"
});
effectsDefs.push({
	ID = "effects.ifrit_potion",
	Script = "scripts\skills\effects\ifrit_potion_effect",
	Name = "Stone Skin",
	Const = "IfritPotion"
});
effectsDefs.push({
	ID = "effects.ijirok_potion",
	Script = "scripts\skills\effects\ijirok_potion_effect",
	Name = "Auspice of the Mad God",
	Const = "IjirokPotion"
});
effectsDefs.push({
	ID = "effects.iron_will",
	Script = "scripts\skills\effects\iron_will_effect",
	Name = "Iron Will",
	Const = "IronWill"
});
effectsDefs.push({
	ID = "effects.kraken_potion",
	Script = "scripts\skills\effects\kraken_potion_effect",
	Name = "Ascendant Flesh",
	Const = "KrakenPotion"
});
effectsDefs.push({
	ID = "effects.lindwurm_acid",
	Script = "scripts\skills\effects\lindwurm_acid_effect",
	Name = "Sprayed with Acid",
	Const = "LindwurmAcid"
});
effectsDefs.push({
	ID = "effects.lindwurm_potion",
	Script = "scripts\skills\effects\lindwurm_potion_effect",
	Name = "Acidic blood",
	Const = "LindwurmPotion"
});
effectsDefs.push({
	ID = "effects.lionheart_potion",
	Script = "scripts\skills\effects\lionheart_potion_effect",
	Name = "Enhanced Bravery",
	Const = "LionheartPotion"
});
effectsDefs.push({
	ID = "effects.lone_wolf",
	Script = "scripts\skills\effects\lone_wolf_effect",
	Name = "Lone Wolf",
	Const = "LoneWolf"
});
effectsDefs.push({
	ID = "effects.nachzehrer_potion",
	Script = "scripts\skills\effects\nachzehrer_potion_effect",
	Name = "Hyperactive Tissue Growth",
	Const = "NachzehrerPotion"
});
effectsDefs.push({
	ID = "effects.necromancer_potion",
	Script = "scripts\skills\effects\necromancer_potion_effect",
	Name = "Visions",
	Const = "NecromancerPotion"
});
effectsDefs.push({
	ID = "effects.necrosavant_potion",
	Script = "scripts\skills\effects\necrosavant_potion_effect",
	Name = "Parasitic Blood",
	Const = "NecrosavantPotion"
});
effectsDefs.push({
	ID = "effects.nightmare",
	Script = "scripts\skills\effects\nightmare_effect",
	Name = "Nightmares",
	Const = "Nightmare"
});
effectsDefs.push({
	ID = "effects.night_vision",
	Script = "scripts\skills\effects\night_vision_effect",
	Name = "Night Vision",
	Const = "NightVision"
});
effectsDefs.push({
	ID = "effects.nine_lives",
	Script = "scripts\skills\effects\nine_lives_effect",
	Name = "Nine Lives",
	Const = "NineLives"
});
effectsDefs.push({
	ID = "effects.orc_berserker_potion",
	Script = "scripts\skills\effects\orc_berserker_potion_effect",
	Name = "Berserker Rage",
	Const = "OrcBerserkerPotion"
});
effectsDefs.push({
	ID = "effects.orc_warlord_potion",
	Script = "scripts\skills\effects\orc_warlord_potion_effect",
	Name = "Font of Strength",
	Const = "OrcWarlordPotion"
});
effectsDefs.push({
	ID = "effects.orc_warrior_potion",
	Script = "scripts\skills\effects\orc_warrior_potion_effect",
	Name = "Sensory Redundancy",
	Const = "OrcWarriorPotion"
});
effectsDefs.push({
	ID = "effects.orc_young_potion",
	Script = "scripts\skills\effects\orc_young_potion_effect",
	Name = "Kinetic Blows",
	Const = "OrcYoundPotion"
});
effectsDefs.push({
	ID = "effects.overwhelmed",
	Script = "scripts\skills\effects\overwhelmed_effect",
	Name = "Overwhelmed",
	Const = "Overwhelmed"
});
effectsDefs.push({
	ID = "effects.rachegeist_potion",
	Script = "scripts\skills\effects\rachegeist_potion_effect",
	Name = "Ghastly Aura",
	Const = "RachegeistPotion"
});
effectsDefs.push({
	ID = "effects.recovery_potion",
	Script = "scripts\skills\effects\recovery_potion_effect",
	Name = "Enhanced Stamina",
	Const = "RecoveryPotion"
});
effectsDefs.push({
	ID = "effects.reforming",
	Script = "scripts\skills\effects\reforming_effect",
	Name = "Reforming",
	Const = "Reforming"
});
effectsDefs.push({
	ID = "effects.schrat_potion",
	Script = "scripts\skills\effects\schrat_potion_effect",
	Name = "Flexile Ligaments",
	Const = "SchratPotion"
});
effectsDefs.push({
	ID = "effects.serpent_potion",
	Script = "scripts\skills\effects\serpent_potion_effect",
	Name = "Enhanced Opportunism",
	Const = "SerpentPotion"
});
effectsDefs.push({
	ID = "effects.shellshocked",
	Script = "scripts\skills\effects\shellshocked_effect",
	Name = "Shellshocked",
	Const = "Shellshocked"
});
effectsDefs.push({
	ID = "effects.skeleton_warrior_potion",
	Script = "scripts\skills\effects\skeleton_warrior_potion_effect",
	Name = "Locking Joints",
	Const = "SkeletonWarriorPotion"
});
effectsDefs.push({
	ID = "effects.staggered",
	Script = "scripts\skills\effects\staggered_effect",
	Name = "Staggered",
	Const = "Staggered"
});
effectsDefs.push({
	ID = "effects.stealth",
	Script = "scripts\skills\effects\stealth_effect",
	Name = "Stealthed",
	Const = "Stealth"
});
effectsDefs.push({
	ID = "effects.swallowed_whole",
	Script = "scripts\skills\effects\swallowed_whole_effect",
	Name = "Devour",
	Const = "SwallowedWhole"
});
effectsDefs.push({
	ID = "effects.taunted",
	Script = "scripts\skills\effects\taunted_effect",
	Name = "Taunted",
	Const = "Taunted"
});
effectsDefs.push({
	ID = "effects.taunt",
	Script = "scripts\skills\effects\taunt_effect",
	Name = "Taunting",
	Const = "Taunt"
});
effectsDefs.push({
	ID = "effects.unhold_potion",
	Script = "scripts\skills\effects\unhold_potion_effect",
	Name = "Hyperactive Cell Growth",
	Const = "UnholdPotion"
});
effectsDefs.push({
	ID = "effects.voice_of_davkul",
	Script = "scripts\skills\effects\voice_of_davkul_effect",
	Name = "Voice of Davkul",
	Const = "VoiceOfDavkul"
});
effectsDefs.push({
	ID = "effects.webknecht_potion",
	Script = "scripts\skills\effects\webknecht_potion_effect",
	Name = "Mutated Circulatory System",
	Const = "WebknechtPotion"
});
effectsDefs.push({
	ID = "effects.wiederganger_potion",
	Script = "scripts\skills\effects\wiederganger_potion_effect",
	Name = "Subdermal Reactivity",
	Const = "WiedergangerPotion"
});
effectsDefs.push({
	ID = "effects.knowledge_potion",
	Script = "scripts\skills\effects_world\knowledge_potion_effect",
	Name = "Enhanced Learning",
	Const = "KnowledgePotion"
});
::Legends.Effects.addEffectDefObjects(effectsDefs);
