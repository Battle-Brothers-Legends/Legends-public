if (!("Effects" in ::Legends))
	::Legends.Effects <- {};

if (!("Effect" in ::Legends))
	::Legends.Effect <- {};

::Legends.Effects.EffectDefObjects <- [];

::Legends.Effects.addEffectDefObjects <- function( _effectDefObjects )
{
	local size = ::Legends.Effects.EffectDefObjects.len();
	::Legends.Effects.EffectDefObjects.extend(_effectDefObjects);
	foreach (i, effectDefObjects in _effectDefObjects)
	{
		if (effectDefObjects.Const in ::Legends.Effect)
			::Legends.Effect[effectDefObjects.Const] = size + i;
		else
			::Legends.Effect[effectDefObjects.Const] <- size + i;
	}
}

local effectsDefs = [];

::Legends.Effect.Dazed <- null;
effectsDefs.push({
	ID = "effects.dazed",
	Script = "scripts/skills/effects/dazed_effect",
	Name = "Dazed",
	Const = "Dazed"
});

::Legends.Effect.Stunned <- null;
effectsDefs.push({
	ID = "effects.stunned",
	Script = "scripts/skills/effects/stunned_effect",
	Name = "Stunned",
	Const = "Stunned"
});

::Legends.Effect.Sleeping <- null;
effectsDefs.push({
	ID = "effects.sleeping",
	Script = "scripts/skills/effects/sleeping_effect",
	Name = "Sleeping",
	Const = "Sleeping"
});

::Legends.Effect.Riposte <- null;
effectsDefs.push({
	ID = "effects.riposte",
	Script = "scripts/skills/effects/riposte_effect",
	Name = "Riposte",
	Const = "Riposte"
});

::Legends.Effect.Bleeding <- null;
effectsDefs.push({
	ID = "effects.bleeding",
	Script = "scripts/skills/effects/bleeding_effect",
	Name = "Bleeding",
	Const = "Bleeding"
});

::Legends.Effect.SpiderPoison <- null;
effectsDefs.push({
	ID = "effects.spider_poison",
	Script = "scripts/skills/effects/spider_poison_effect",
	Name = "Poisoned",
	Const = "SpiderPoison"
});

::Legends.Effect.HolyWater <- null;
effectsDefs.push({
	ID = "effects.holy_water",
	Script = "scripts/skills/effects/holy_water_effect",
	Name = "Sprayed with Blessed Water",
	Const = "HolyWater"
});

::Legends.Effect.Shieldwall <- null;
effectsDefs.push({
	ID = "effects.shieldwall",
	Script = "scripts/skills/effects/shieldwall_effect",
	Name = "Shieldwall",
	Const = "Shieldwall"
});

::Legends.Effect.FakeCharmed <- null;
effectsDefs.push({
	ID = "effects.fake_charmed",
	Script = "scripts/skills/effects/fake_charmed_effect",
	Name = "Charmed",
	Const = "FakeCharmed"
});

::Legends.Effect.Charmed <- null;
effectsDefs.push({
	ID = "effects.charmed",
	Script = "scripts/skills/effects/charmed_effect",
	Name = "Charmed",
	Const = "Charmed"
});

::Legends.Effect.Spearwall <- null;
effectsDefs.push({
	ID = "effects.spearwall",
	Script = "scripts/skills/effects/spearwall_effect",
	Name = "Spearwall",
	Const = "Spearwall"
});

::Legends.Effect.Distracted <- null;
effectsDefs.push({
	ID = "effects.distracted",
	Script = "scripts/skills/effects/distracted_effect",
	Name = "Distracted",
	Const = "Distracted"
});

::Legends.Effect.Adrenaline <- null;
effectsDefs.push({
	ID = "effects.adrenaline",
	Script = "scripts/skills/effects/adrenaline_effect",
	Name = "Adrenaline",
	Const = "Adrenaline"
});

::Legends.Effect.DrumsOfWar <- null;
effectsDefs.push({
	ID = "effects.drums_of_war",
	Script = "scripts/skills/effects/drums_of_war_effect",
	Name = "Drums of War",
	Const = "DrumsOfWar"
});

::Legends.Effect.KillingFrenzy <- null;
effectsDefs.push({
	ID = "effects.killing_frenzy",
	Script = "scripts/skills/effects/killing_frenzy_effect",
	Name = "Killing Frenzy!",
	Const = "KillingFrenzy"
});

::Legends.Effect.Rallied <- null;
effectsDefs.push({
	ID = "effects.rallied",
	Script = "scripts/skills/effects/rallied_effect",
	Name = "Rallied",
	Const = "Rallied"
});

::Legends.Effect.InsectSwarm <- null;
effectsDefs.push({
	ID = "effects.insect_swarm",
	Script = "scripts/skills/effects/insect_swarm_effect",
	Name = "Swarm of Insects",
	Const = "InsectSwarm"
});

::Legends.Effect.Disarmed <- null;
effectsDefs.push({
	ID = "effects.disarmed",
	Script = "scripts/skills/effects/disarmed_effect",
	Name = "Disarmed",
	Const = "Disarmed"
});

::Legends.Effect.Withered <- null;
effectsDefs.push({
	ID = "effects.withered",
	Script = "scripts/skills/effects/withered_effect",
	Name = "Withered",
	Const = "Withered"
});

::Legends.Effect.Smoke <- null;
effectsDefs.push({
	ID = "effects.smoke",
	Script = "scripts/skills/effects/smoke_effect",
	Name = "Covered by Smoke",
	Const = "Smoke"
});

::Legends.Effect.Exhausted <- null;
effectsDefs.push({
	ID = "effects.exhausted",
	Script = "scripts/skills/effects_world/exhausted_effect",
	Name = "Exhausted",
	Const = "Exhausted"
});

::Legends.Effect.Drunk <- null;
effectsDefs.push({
	ID = "effects.drunk",
	Script = "scripts/skills/effects_world/drunk_effect",
	Name = "Drunk",
	Const = "Drunk"
});

::Legends.Effect.Hangover <- null;
effectsDefs.push({
	ID = "effects.hangover",
	Script = "scripts/skills/effects_world/hangover_effect",
	Name = "Hangover",
	Const = "Hangover"
});

::Legends.Effect.LorekeeperPotion <- null;
effectsDefs.push({
	ID = "effects.lorekeeper_potion",
	Script = "scripts/skills/effects/lorekeeper_potion_effect",
	Name = "Lorekeeper\'s Rib Bone",
	Const = "LorekeeperPotion"
});

::Legends.Effect.BerserkerMushrooms <- null;
effectsDefs.push({
	ID = "effects.berserker_mushrooms",
	Script = "scripts/skills/effects/berserker_mushrooms_effect",
	Name = "RAGE!!!",
	Const = "BerserkerMushrooms"
});

::Legends.Effect.Indomitable <- null;
effectsDefs.push({
	ID = "effects.indomitable",
	Script = "scripts/skills/effects/indomitable_effect",
	Name = "Indomitable",
	Const = "Indomitable"
});

::Legends.Effect.AncientPriestPotion <- null;
effectsDefs.push({
	ID = "effects.ancient_priest_potion",
	Script = "scripts/skills/effects/ancient_priest_potion_effect",
	Name = "Synapse Blockage",
	Const = "AncientPriestPotion"
});

::Legends.Effect.Afraid <- null;
effectsDefs.push({
	ID = "effects.afraid",
	Script = "scripts/skills/effects_world/afraid_effect",
	Name = "Afraid",
	Const = "Afraid"
});

::Legends.Effect.Trained <- null;
effectsDefs.push({
	ID = "effects.trained",
	Script = "scripts/skills/effects_world/new_trained_effect",
	Name = "Training Experience",
	Const = "Trained"
});

::Legends.Effect.Net <- null;
effectsDefs.push({
	ID = "effects.net",
	Script = "scripts/skills/effects/net_effect",
	Name = "Trapped in Net",
	Const = "Net"
});

::Legends.Effect.Web <- null;
effectsDefs.push({
	ID = "effects.web",
	Script = "scripts/skills/effects/web_effect",
	Name = "Trapped in Web",
	Const = "Web"
});

::Legends.Effect.Rooted <- null;
effectsDefs.push({
	ID = "effects.rooted",
	Script = "scripts/skills/effects/rooted_effect",
	Name = "Trapped in Vines",
	Const = "Rooted"
});

::Legends.Effect.KrakenEnsnare <- null;
effectsDefs.push({
	ID = "effects.kraken_ensnare",
	Script = "scripts/skills/effects/kraken_ensnare_effect",
	Name = "Entangled",
	Const = "KrakenEnsnare"
});

::Legends.Effect.SerpentEnsnare <- null;
effectsDefs.push({
	ID = "effects.serpent_ensnare",
	Script = "scripts/skills/effects/serpent_ensnare_effect",
	Name = "Entangled",
	Const = "SerpentEnsnare"
});

::Legends.Effect.GoblinShamanPotion <- null;
effectsDefs.push({
	ID = "effects.goblin_shaman_potion",
	Script = "scripts/skills/effects/goblin_shaman_potion_effect",
	Name = "Hyperactive Sweat Glands",
	Const = "GoblinShamanPotion"
});

::Legends.Effect.PoisonCoat <- null;
effectsDefs.push({
	ID = "effects.poison_coat",
	Script = "scripts/skills/effects/poison_coat_effect",
	Name = "Weapon coated with poison",
	Const = "PoisonCoat"
});

::Legends.Effect.SpiderPoisonCoat <- null;
effectsDefs.push({
	ID = "effects.spider_poison_coat",
	Script = "scripts/skills/effects/spider_poison_coat_effect",
	Name = "Weapon coated with poison",
	Const = "SpiderPoisonCoat"
});

::Legends.Effect.DebilitatingAttack <- null;
effectsDefs.push({
	ID = "effects.debilitating_attack",
	Script = "scripts/skills/effects/debilitating_attack_effect",
	Name = "Debilitating Attack",
	Const = "DebilitatingAttack"
});

::Legends.Effect.GoblinPoison <- null;
effectsDefs.push({
	ID = "effects.goblin_poison",
	Script = "scripts/skills/effects/goblin_poison_effect",
	Name = "Poisoned",
	Const = "GoblinPoison"
});

::Legends.Effect.GoblinGruntPotion <- null;
effectsDefs.push({
	ID = "effects.goblin_grunt_potion",
	Script = "scripts/skills/effects/goblin_grunt_potion_effect",
	Name = "Reactive Leg Muscles",
	Const = "GoblinGruntPotion"
});

::Legends.Effect.GruesomeFeast <- null;
effectsDefs.push({
	ID = "effects.gruesome_feast",
	Script = "scripts/skills/effects/gruesome_feast_effect",
	Name = "Feasted",
	Const = "GruesomeFeast"
});

::Legends.Effect.HexSlave <- null;
effectsDefs.push({
	ID = "effects.hex_slave",
	Script = "scripts/skills/effects/hex_slave_effect",
	Name = "Hex",
	Const = "HexSlave"
});

::Legends.Effect.PossessingUndead <- null;
effectsDefs.push({
	ID = "effects.possessing_undead",
	Script = "scripts/skills/effects/possessing_undead_effect",
	Name = "Possessing Undead",
	Const = "PossessingUndead"
});

::Legends.Effect.PossessedUndead <- null;
effectsDefs.push({
	ID = "effects.possessed_undead",
	Script = "scripts/skills/effects/possessed_undead_effect",
	Name = "Possessed",
	Const = "PossessedUndead"
});

::Legends.Effect.Acid <- null;
effectsDefs.push({
	ID = "effects.acid",
	Script = "scripts/skills/effects/acid_effect",
	Name = "Sprayed with Acid",
	Const = "Acid"
});

::Legends.Effect.Whipped <- null;
effectsDefs.push({
	ID = "effects.whipped",
	Script = "scripts/skills/effects/whipped_effect",
	Name = "Whipped",
	Const = "Whipped"
});

::Legends.Effect.AlpPotion <- null;
effectsDefs.push({
	ID = "effects.alp_potion",
	Script = "scripts/skills/effects/alp_potion_effect",
	Name = "Enhanced Eye Rods",
	Const = "AlpPotion"
});

::Legends.Effect.ImmuneToPoison <- null;
effectsDefs.push({
	ID = "effects.immune_to_poison",
	Script = "scripts/skills/effects/antidote_effect",
	Name = "Immune to Poison",
	Const = "ImmuneToPoison"
});

::Legends.Effect.ApotheosisPotion <- null;
effectsDefs.push({
	ID = "effects.apotheosis_potion",
	Script = "scripts/skills/effects/apotheosis_potion_effect",
	Name = "Apotheosis",
	Const = "ApotheosisPotion"
});

::Legends.Effect.BattleStandard <- null;
effectsDefs.push({
	ID = "effects.battle_standard",
	Script = "scripts/skills/effects/battle_standard_effect",
	Name = "For the company!",
	Const = "BattleStandard"
});

::Legends.Effect.BerserkerRage <- null;
effectsDefs.push({
	ID = "effects.berserker_rage",
	Script = "scripts/skills/effects/berserker_rage_effect",
	Name = "Rage",
	Const = "BerserkerRage"
});

::Legends.Effect.HyenaPotion <- null;
effectsDefs.push({
	ID = "effects.hyena_potion",
	Script = "scripts/skills/effects/hyena_potion_effect",
	Name = "Subdermal Clotting",
	Const = "HyenaPotion"
});

::Legends.Effect.Captain <- null;
effectsDefs.push({
	ID = "effects.captain",
	Script = "scripts/skills/effects/captain_effect",
	Name = "Inspired by nearby Leader",
	Const = "Captain"
});

::Legends.Effect.CatPotion <- null;
effectsDefs.push({
	ID = "effects.cat_potion",
	Script = "scripts/skills/effects/cat_potion_effect",
	Name = "Heightened Reflexes",
	Const = "CatPotion"
});

::Legends.Effect.Chilled <- null;
effectsDefs.push({
	ID = "effects.chilled",
	Script = "scripts/skills/effects/chilled_effect",
	Name = "Chilled",
	Const = "Chilled"
});

::Legends.Effect.Debilitated <- null;
effectsDefs.push({
	ID = "effects.debilitated",
	Script = "scripts/skills/effects/debilitated_effect",
	Name = "Debilitated",
	Const = "Debilitated"
});

::Legends.Effect.DirewolfPotion <- null;
effectsDefs.push({
	ID = "effects.direwolf_potion",
	Script = "scripts/skills/effects/direwolf_potion_effect",
	Name = "Elasticized Sinew",
	Const = "DirewolfPotion"
});

::Legends.Effect.Dodge <- null;
effectsDefs.push({
	ID = "effects.dodge",
	Script = "scripts/skills/effects/dodge_effect",
	Name = "Dodge",
	Const = "Dodge"
});

::Legends.Effect.DoubleStrike <- null;
effectsDefs.push({
	ID = "effects.double_strike",
	Script = "scripts/skills/effects/double_strike_effect",
	Name = "Double Strike!",
	Const = "DoubleStrike"
});

::Legends.Effect.FallenHeroPotion <- null;
effectsDefs.push({
	ID = "effects.fallen_hero_potion",
	Script = "scripts/skills/effects/fallen_hero_potion_effect",
	Name = "Reactive Muscle Tissue",
	Const = "FallenHeroPotion"
});

::Legends.Effect.GeistPotion <- null;
effectsDefs.push({
	ID = "effects.geist_potion",
	Script = "scripts/skills/effects/geist_potion_effect",
	Name = "Kinetic Coating",
	Const = "GeistPotion"
});

::Legends.Effect.GoblinOverseerPotion <- null;
effectsDefs.push({
	ID = "effects.goblin_overseer_potion",
	Script = "scripts/skills/effects/goblin_overseer_potion_effect",
	Name = "Mutated Cornea",
	Const = "GoblinOverseerPotion"
});

::Legends.Effect.HexePotion <- null;
effectsDefs.push({
	ID = "effects.hexe_potion",
	Script = "scripts/skills/effects/hexe_potion_effect",
	Name = "Sympathetic Call",
	Const = "HexePotion"
});

::Legends.Effect.HexMaster <- null;
effectsDefs.push({
	ID = "effects.hex_master",
	Script = "scripts/skills/effects/hex_master_effect",
	Name = "Protected by a Hex",
	Const = "HexMaster"
});

::Legends.Effect.HonorGuardPotion <- null;
effectsDefs.push({
	ID = "effects.honor_guard_potion",
	Script = "scripts/skills/effects/honor_guard_potion_effect",
	Name = "Subdermal Stitching",
	Const = "HonorGuardPotion"
});

::Legends.Effect.Horrified <- null;
effectsDefs.push({
	ID = "effects.horrified",
	Script = "scripts/skills/effects/horrified_effect",
	Name = "Horrified",
	Const = "Horrified"
});

::Legends.Effect.IfritPotion <- null;
effectsDefs.push({
	ID = "effects.ifrit_potion",
	Script = "scripts/skills/effects/ifrit_potion_effect",
	Name = "Stone Skin",
	Const = "IfritPotion"
});

::Legends.Effect.IjirokPotion <- null;
effectsDefs.push({
	ID = "effects.ijirok_potion",
	Script = "scripts/skills/effects/ijirok_potion_effect",
	Name = "Auspice of the Mad God",
	Const = "IjirokPotion"
});

::Legends.Effect.IronWill <- null;
effectsDefs.push({
	ID = "effects.iron_will",
	Script = "scripts/skills/effects/iron_will_effect",
	Name = "Iron Will",
	Const = "IronWill"
});

::Legends.Effect.KrakenPotion <- null;
effectsDefs.push({
	ID = "effects.kraken_potion",
	Script = "scripts/skills/effects/kraken_potion_effect",
	Name = "Ascendant Flesh",
	Const = "KrakenPotion"
});

::Legends.Effect.LindwurmAcid <- null;
effectsDefs.push({
	ID = "effects.lindwurm_acid",
	Script = "scripts/skills/effects/lindwurm_acid_effect",
	Name = "Sprayed with Acid",
	Const = "LindwurmAcid"
});

::Legends.Effect.LindwurmPotion <- null;
effectsDefs.push({
	ID = "effects.lindwurm_potion",
	Script = "scripts/skills/effects/lindwurm_potion_effect",
	Name = "Acidic blood",
	Const = "LindwurmPotion"
});

::Legends.Effect.LionheartPotion <- null;
effectsDefs.push({
	ID = "effects.lionheart_potion",
	Script = "scripts/skills/effects/lionheart_potion_effect",
	Name = "Enhanced Bravery",
	Const = "LionheartPotion"
});

::Legends.Effect.LoneWolf <- null;
effectsDefs.push({
	ID = "effects.lone_wolf",
	Script = "scripts/skills/effects/lone_wolf_effect",
	Name = "Lone Wolf",
	Const = "LoneWolf"
});

::Legends.Effect.NachzehrerPotion <- null;
effectsDefs.push({
	ID = "effects.nachzehrer_potion",
	Script = "scripts/skills/effects/nachzehrer_potion_effect",
	Name = "Hyperactive Tissue Growth",
	Const = "NachzehrerPotion"
});

::Legends.Effect.NecromancerPotion <- null;
effectsDefs.push({
	ID = "effects.necromancer_potion",
	Script = "scripts/skills/effects/necromancer_potion_effect",
	Name = "Visions",
	Const = "NecromancerPotion"
});

::Legends.Effect.NecrosavantPotion <- null;
effectsDefs.push({
	ID = "effects.necrosavant_potion",
	Script = "scripts/skills/effects/necrosavant_potion_effect",
	Name = "Parasitic Blood",
	Const = "NecrosavantPotion"
});

::Legends.Effect.Nightmare <- null;
effectsDefs.push({
	ID = "effects.nightmare",
	Script = "scripts/skills/effects/nightmare_effect",
	Name = "Nightmares",
	Const = "Nightmare"
});

::Legends.Effect.NightVision <- null;
effectsDefs.push({
	ID = "effects.night_vision",
	Script = "scripts/skills/effects/night_vision_effect",
	Name = "Night Vision",
	Const = "NightVision"
});

::Legends.Effect.NineLives <- null;
effectsDefs.push({
	ID = "effects.nine_lives",
	Script = "scripts/skills/effects/nine_lives_effect",
	Name = "Nine Lives",
	Const = "NineLives"
});

::Legends.Effect.OrcBerserkerPotion <- null;
effectsDefs.push({
	ID = "effects.orc_berserker_potion",
	Script = "scripts/skills/effects/orc_berserker_potion_effect",
	Name = "Berserker Rage",
	Const = "OrcBerserkerPotion"
});

::Legends.Effect.OrcWarlordPotion <- null;
effectsDefs.push({
	ID = "effects.orc_warlord_potion",
	Script = "scripts/skills/effects/orc_warlord_potion_effect",
	Name = "Font of Strength",
	Const = "OrcWarlordPotion"
});

::Legends.Effect.OrcWarriorPotion <- null;
effectsDefs.push({
	ID = "effects.orc_warrior_potion",
	Script = "scripts/skills/effects/orc_warrior_potion_effect",
	Name = "Sensory Redundancy",
	Const = "OrcWarriorPotion"
});

::Legends.Effect.OrcYoungPotion <- null;
effectsDefs.push({
	ID = "effects.orc_young_potion",
	Script = "scripts/skills/effects/orc_young_potion_effect",
	Name = "Kinetic Blows",
	Const = "OrcYoungPotion"
});

::Legends.Effect.Overwhelmed <- null;
effectsDefs.push({
	ID = "effects.overwhelmed",
	Script = "scripts/skills/effects/overwhelmed_effect",
	Name = "Overwhelmed",
	Const = "Overwhelmed"
});

::Legends.Effect.RachegeistPotion <- null;
effectsDefs.push({
	ID = "effects.rachegeist_potion",
	Script = "scripts/skills/effects/rachegeist_potion_effect",
	Name = "Ghastly Aura",
	Const = "RachegeistPotion"
});

::Legends.Effect.RecoveryPotion <- null;
effectsDefs.push({
	ID = "effects.recovery_potion",
	Script = "scripts/skills/effects/recovery_potion_effect",
	Name = "Enhanced Stamina",
	Const = "RecoveryPotion"
});

::Legends.Effect.Reforming <- null;
effectsDefs.push({
	ID = "effects.reforming",
	Script = "scripts/skills/effects/reforming_effect",
	Name = "Reforming",
	Const = "Reforming"
});

::Legends.Effect.SchratPotion <- null;
effectsDefs.push({
	ID = "effects.schrat_potion",
	Script = "scripts/skills/effects/schrat_potion_effect",
	Name = "Flexile Ligaments",
	Const = "SchratPotion"
});

::Legends.Effect.SerpentPotion <- null;
effectsDefs.push({
	ID = "effects.serpent_potion",
	Script = "scripts/skills/effects/serpent_potion_effect",
	Name = "Enhanced Opportunism",
	Const = "SerpentPotion"
});

::Legends.Effect.Shellshocked <- null;
effectsDefs.push({
	ID = "effects.shellshocked",
	Script = "scripts/skills/effects/shellshocked_effect",
	Name = "Shellshocked",
	Const = "Shellshocked"
});

::Legends.Effect.SkeletonWarriorPotion <- null;
effectsDefs.push({
	ID = "effects.skeleton_warrior_potion",
	Script = "scripts/skills/effects/skeleton_warrior_potion_effect",
	Name = "Locking Joints",
	Const = "SkeletonWarriorPotion"
});

::Legends.Effect.Staggered <- null;
effectsDefs.push({
	ID = "effects.staggered",
	Script = "scripts/skills/effects/staggered_effect",
	Name = "Staggered",
	Const = "Staggered"
});

::Legends.Effect.Stealth <- null;
effectsDefs.push({
	ID = "effects.stealth",
	Script = "scripts/skills/effects/stealth_effect",
	Name = "Stealthed",
	Const = "Stealth"
});

::Legends.Effect.SwallowedWhole <- null;
effectsDefs.push({
	ID = "effects.swallowed_whole",
	Script = "scripts/skills/effects/swallowed_whole_effect",
	Name = "Devour",
	Const = "SwallowedWhole"
});

::Legends.Effect.Taunted <- null;
effectsDefs.push({
	ID = "effects.taunted",
	Script = "scripts/skills/effects/taunted_effect",
	Name = "Taunted",
	Const = "Taunted"
});

::Legends.Effect.Taunt <- null;
effectsDefs.push({
	ID = "effects.taunt",
	Script = "scripts/skills/effects/taunt_effect",
	Name = "Taunting",
	Const = "Taunt"
});

::Legends.Effect.UnholdPotion <- null;
effectsDefs.push({
	ID = "effects.unhold_potion",
	Script = "scripts/skills/effects/unhold_potion_effect",
	Name = "Hyperactive Cell Growth",
	Const = "UnholdPotion"
});

::Legends.Effect.VoiceOfDavkul <- null;
effectsDefs.push({
	ID = "effects.voice_of_davkul",
	Script = "scripts/skills/effects/voice_of_davkul_effect",
	Name = "Voice of Davkul",
	Const = "VoiceOfDavkul"
});

::Legends.Effect.WebknechtPotion <- null;
effectsDefs.push({
	ID = "effects.webknecht_potion",
	Script = "scripts/skills/effects/webknecht_potion_effect",
	Name = "Mutated Circulatory System",
	Const = "WebknechtPotion"
});

::Legends.Effect.WiedergangerPotion <- null;
effectsDefs.push({
	ID = "effects.wiederganger_potion",
	Script = "scripts/skills/effects/wiederganger_potion_effect",
	Name = "Subdermal Reactivity",
	Const = "WiedergangerPotion"
});

::Legends.Effect.KnowledgePotion <- null;
effectsDefs.push({
	ID = "effects.knowledge_potion",
	Script = "scripts/skills/effects_world/knowledge_potion_effect",
	Name = "Enhanced Learning",
	Const = "KnowledgePotion"
});

::Legends.Effect.LegendBeerBuzzEffect <- null;
effectsDefs.push({
	ID = "effects.legend_beer_buzz_effect",
	Script = "scripts/skills/effects/legend_beer_buzz_effect",
	Name = "Buzzed",
	Const = "LegendBeerBuzzEffect"
});

::Legends.Effect.LegendWineTipsyEffect <- null;
effectsDefs.push({
	ID = "effects.legend_wine_tipsy_effect",
	Script = "scripts/skills/effects/legend_wine_tipsy_effect",
	Name = "Tipsy",
	Const = "LegendWineTipsyEffect"
});

::Legends.Effect.LegendMeadWarmthEffect <- null;
effectsDefs.push({
	ID = "effects.legend_mead_warmth_effect",
	Script = "scripts/skills/effects/legend_mead_warmth_effect",
	Name = "Warmth",
	Const = "LegendMeadWarmthEffect"
});

::Legends.Effect.LegendLiquorBurnEffect <- null;
effectsDefs.push({
	ID = "effects.legend_liquor_burn_effect",
	Script = "scripts/skills/effects/legend_liquor_burn_effect",
	Name = "Liquor Burn",
	Const = "LegendLiquorBurnEffect"
});

::Legends.Effect.LegendReturnFavor <- null;
effectsDefs.push({
	ID = "effects.legend_return_favor",
	Script = "scripts/skills/effects/legend_return_favor_effect",
	Name = "Return Favor",
	Const = "LegendReturnFavor"
});

::Legends.Effect.LegendValaChantDisharmonyEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_chant_disharmony_effect",
	Script = "scripts/skills/effects/legend_vala_chant_disharmony_effect",
	Name = "Disharmony",
	Const = "LegendValaChantDisharmonyEffect"
});

::Legends.Effect.LegendValaChantFuryEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_chant_fury_effect",
	Script = "scripts/skills/effects/legend_vala_chant_fury_effect",
	Name = "Fury",
	Const = "LegendValaChantFuryEffect"
});

::Legends.Effect.LegendValaChantSensesEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_chant_senses_effect",
	Script = "scripts/skills/effects/legend_vala_chant_senses_effect",
	Name = "Heightened Senses",
	Const = "LegendValaChantSensesEffect"
});

::Legends.Effect.LegendValaCurrentlyChanting <- null;
effectsDefs.push({
	ID = "effects.legend_vala_currently_chanting",
	Script = "scripts/skills/effects/legend_vala_currently_chanting",
	Name = "Currently Chanting",
	Const = "LegendValaCurrentlyChanting"
});

::Legends.Effect.LegendValaInTrance <- null;
effectsDefs.push({
	ID = "effects.legend_vala_in_trance",
	Script = "scripts/skills/effects/legend_vala_in_trance",
	Name = "In Trance",
	Const = "LegendValaInTrance"
});

::Legends.Effect.LegendConsecratedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_consecrated_effect",
	Script = "scripts/skills/effects/legend_consecrated_effect",
	Name = "Consecrated",
	Const = "LegendConsecratedEffect"
});

::Legends.Effect.LegendSanctifiedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_sanctified_effect",
	Script = "scripts/skills/effects/legend_sanctified_effect",
	Name = "Sanctified",
	Const = "LegendSanctifiedEffect"
});

::Legends.Effect.LegendParried <- null;
effectsDefs.push({
	ID = "effects.legend_parried",
	Script = "scripts/skills/effects/legend_parried_effect",
	Name = "Parried",
	Const = "LegendParried"
});

::Legends.Effect.LegendGrazedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_grazed_effect",
	Script = "scripts/skills/effects/legend_grazed_effect",
	Name = "Bleeding from Grazes",
	Const = "LegendGrazedEffect"
});

::Legends.Effect.LegendIntenselyCharmed <- null;
effectsDefs.push({
	ID = "effects.legend_intensely_charmed",
	Script = "scripts/skills/effects/legend_intensely_charmed_effect",
	Name = "Infatuated",
	Const = "LegendIntenselyCharmed"
});

::Legends.Effect.LegendBaffled <- null;
effectsDefs.push({
	ID = "effects.legend_baffled",
	Script = "scripts/skills/effects/legend_baffled_effect",
	Name = "Baffled",
	Const = "LegendBaffled"
});

::Legends.Effect.LegendChoked <- null;
effectsDefs.push({
	ID = "effects.legend_choked",
	Script = "scripts/skills/effects/legend_choked_effect",
	Name = "Choked",
	Const = "LegendChoked"
});

::Legends.Effect.LegendTackled <- null;
effectsDefs.push({
	ID = "effects.legend_tackled",
	Script = "scripts/skills/effects/legend_tackled_effect",
	Name = "Knocked Over",
	Const = "LegendTackled"
});

::Legends.Effect.LegendRedbackSpiderPoison <- null;
effectsDefs.push({
	ID = "effects.legend_redback_spider_poison",
	Script = "scripts/skills/effects/legend_redback_spider_poison_effect",
	Name = "Redback Poisoned",
	Const = "LegendRedbackSpiderPoison"
});

::Legends.Effect.LegendPerfectFocus <- null;
effectsDefs.push({
	ID = "effects.legend_perfect_focus",
	Script = "scripts/skills/effects/legend_perfect_focus_effect",
	Name = "Perfect Focus",
	Const = "LegendPerfectFocus"
});

::Legends.Effect.LegendDazed <- null;
effectsDefs.push({
	ID = "effects.legend_dazed",
	Script = "scripts/skills/effects/legend_dazed_effect",
	Name = "Stupefied",
	Const = "LegendDazed"
});

::Legends.Effect.LegendGrappled <- null;
effectsDefs.push({
	ID = "effects.legend_grappled",
	Script = "scripts/skills/effects/legend_grappled_effect",
	Name = "Grappled",
	Const = "LegendGrappled"
});

::Legends.Effect.LegendFortify <- null;
effectsDefs.push({
	ID = "effects.legend_fortify",
	Script = "scripts/skills/effects/legend_fortify_effect",
	Name = "Fortify",
	Const = "LegendFortify"
});

::Legends.Effect.LegendSafeguarding <- null;
effectsDefs.push({
	ID = "effects.legend_safeguarding",
	Script = "scripts/skills/effects/legend_safeguarding_effect",
	Name = "Safeguarding",
	Const = "LegendSafeguarding"
});

::Legends.Effect.LegendThrewSandEffect <- null;
effectsDefs.push({
	ID = "effects.legend_threw_sand_effect",
	Script = "scripts/skills/effects/legend_threw_sand_effect",
	Name = "Threw Sand",
	Const = "LegendThrewSandEffect"
});

::Legends.Effect.LegendRswPoisonEffect <- null;
effectsDefs.push({
	ID = "effects.legend_RSW_poison_effect",
	Script = "scripts/skills/rune_sigils/legend_RSW_poison_effect",
	Name = "Poisoned",
	Const = "LegendRswPoisonEffect"
});

::Legends.Effect.LegendWolfsbane <- null;
effectsDefs.push({
	ID = "effects.legend_wolfsbane",
	Script = "scripts/skills/effects/legend_wolfsbane_effect",
	Name = "Wolfsbane Scent",
	Const = "LegendWolfsbane"
});

::Legends.Effect.LegendAlpRealmOfShadow <- null;
effectsDefs.push({
	ID = "effects.legend_alp_realm_of_shadow",
	Script = "scripts/skills/effects/legend_alp_realm_of_shadow_effect",
	Name = "Engulfed By Darkness",
	Const = "LegendAlpRealmOfShadow"
});

::Legends.Effect.LegendApothecaryMushrooms <- null;
effectsDefs.push({
	ID = "effects.legend_apothecary_mushrooms",
	Script = "scripts/skills/effects/legend_apothecary_mushrooms_effect",
	Name = "Purple Haze",
	Const = "LegendApothecaryMushrooms"
});

::Legends.Effect.LegendBasiliskPoison <- null;
effectsDefs.push({
	ID = "effects.legend_basilisk_poison",
	Script = "scripts/skills/effects/legend_basilisk_poison_effect",
	Name = "Poisoned",
	Const = "LegendBasiliskPoison"
});

::Legends.Effect.LegendCheeredOn <- null;
effectsDefs.push({
	ID = "effects.legend_cheered_on",
	Script = "scripts/skills/effects/legend_cheered_on_effect",
	Name = "Cheered On",
	Const = "LegendCheeredOn"
});

::Legends.Effect.LegendCoordinatingVolleys <- null;
effectsDefs.push({
	ID = "effects.legend_coordinating_volleys",
	Script = "scripts/skills/effects/legend_coordinating_volleys",
	Name = "Coordinated Volleys",
	Const = "LegendCoordinatingVolleys"
});

::Legends.Effect.LegendCurseofyears <- null;
effectsDefs.push({
	ID = "effects.legend_curseofyears",
	Script = "scripts/skills/effects/legend_curseofyears_effect",
	Name = "Decrepify",
	Const = "LegendCurseofyears"
});

::Legends.Effect.LegendMotivatedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_motivated_effect",
	Script = "scripts/skills/effects/legend_motivated_effect",
	Name = "Motivated",
	Const = "LegendMotivatedEffect"
});

::Legends.Effect.LegendDemonHoundBiteEffect <- null;
effectsDefs.push({
	ID = "effects.legend_demon_hound_bite_effect",
	Script = "scripts/skills/effects/legend_demon_hound_bite_effect",
	Name = "Höllenhund Curse",
	Const = "LegendDemonHoundBiteEffect"
});

::Legends.Effect.LegendRationsEffect <- null;
effectsDefs.push({
	ID = "effects.legend_rations_effect",
	Script = "scripts/skills/effects/legend_rations_effect",
	Name = "Satiated",
	Const = "LegendRationsEffect"
});

::Legends.Effect.LegendSatiatedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_satiated_effect",
	Script = "scripts/skills/effects/legend_satiated_effect",
	Name = "Satiated",
	Const = "LegendSatiatedEffect"
});

::Legends.Effect.LegendStuffedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_stuffed_effect",
	Script = "scripts/skills/effects/legend_stuffed_effect",
	Name = "Stuffed",
	Const = "LegendStuffedEffect"
});

::Legends.Effect.LegendEvasion <- null;
effectsDefs.push({
	ID = "effects.legend_evasion",
	Script = "scripts/skills/effects/legend_evasion_effect",
	Name = "Evading",
	Const = "LegendEvasion"
});

::Legends.Effect.LegendSummonedFalconEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_falcon_effect",
	Script = "scripts/skills/effects/legend_summoned_falcon_effect",
	Name = "Summoned a Falcon",
	Const = "LegendSummonedFalconEffect"
});

::Legends.Effect.LegendStepsGuided <- null;
effectsDefs.push({
	ID = "effects.legend_steps_guided",
	Script = "scripts/skills/effects/legend_steps_guided",
	Name = "Steps Guided",
	Const = "LegendStepsGuided"
});

::Legends.Effect.LegendHoldingTheLine <- null;
effectsDefs.push({
	ID = "effects.legend_holding_the_line",
	Script = "scripts/skills/effects/legend_holding_the_line",
	Name = "Holding the Line",
	Const = "LegendHoldingTheLine"
});

::Legends.Effect.LegendDodgingIncoming <- null;
effectsDefs.push({
	ID = "effects.legend_dodging_incoming",
	Script = "scripts/skills/effects/legend_dodging_incoming",
	Name = "Dodging Incoming Projectiles",
	Const = "LegendDodgingIncoming"
});

::Legends.Effect.LegendInspired <- null;
effectsDefs.push({
	ID = "effects.legend_inspired",
	Script = "scripts/skills/effects/legend_inspired_effect",
	Name = "Inspired",
	Const = "LegendInspired"
});

::Legends.Effect.LegendLevitating <- null;
effectsDefs.push({
	ID = "effects.legend_levitating",
	Script = "scripts/skills/effects/legend_levitating_effect",
	Name = "Levitating",
	Const = "LegendLevitating"
});

::Legends.Effect.LegendPossession <- null;
effectsDefs.push({
	ID = "effects.legend_possession",
	Script = "scripts/skills/effects/legend_possession_effect",
	Name = "Possessed",
	Const = "LegendPossession"
});

::Legends.Effect.LegendPrayerOfLife <- null;
effectsDefs.push({
	ID = "effects.legend_prayer_of_life",
	Script = "scripts/skills/effects/legend_prayer_of_life_effect",
	Name = "Prayer of Hope",
	Const = "LegendPrayerOfLife"
});

::Legends.Effect.LegendBleedPrepared <- null;
effectsDefs.push({
	ID = "effects.legend_bleed_prepared",
	Script = "scripts/skills/effects/legend_bleed_prepared_effect",
	Name = "Prepared to Inflict Bleeding",
	Const = "LegendBleedPrepared"
});

::Legends.Effect.LegendGrazePrepared <- null;
effectsDefs.push({
	ID = "effects.legend_graze_prepared",
	Script = "scripts/skills/effects/legend_graze_prepared_effect",
	Name = "Prepared to Inflict a Graze",
	Const = "LegendGrazePrepared"
});

::Legends.Effect.LegendKnockbackPrepared <- null;
effectsDefs.push({
	ID = "effects.legend_knockback_prepared",
	Script = "scripts/skills/effects/legend_knockback_prepared_effect",
	Name = "Prepared to Inflict Knockback.",
	Const = "LegendKnockbackPrepared"
});

::Legends.Effect.LegendGuardedEffect <- null;
effectsDefs.push({
	ID = "effects.legend_guarded_effect",
	Script = "scripts/skills/effects/legend_guarded_effect",
	Name = "Guarded",
	Const = "LegendGuardedEffect"
});

::Legends.Effect.LegendGuard <- null;
effectsDefs.push({
	ID = "effects.legend_guard",
	Script = "scripts/skills/effects/legend_guard_effect",
	Name = "Guarding",
	Const = "LegendGuard"
});

::Legends.Effect.LegendPushingForward <- null;
effectsDefs.push({
	ID = "effects.legend_pushing_forward",
	Script = "scripts/skills/effects/legend_pushing_forward",
	Name = "Pushing Forward",
	Const = "LegendPushingForward"
});

::Legends.Effect.LegendReadOmens <- null;
effectsDefs.push({
	ID = "effects.legend_read_omens",
	Script = "scripts/skills/effects/legend_read_omens_effect",
	Name = "Omens Foretold",
	Const = "LegendReadOmens"
});

::Legends.Effect.LegendSafeguarded <- null;
effectsDefs.push({
	ID = "effects.legend_safeguarded",
	Script = "scripts/skills/effects/legend_safeguarded_effect",
	Name = "Safeguarded",
	Const = "LegendSafeguarded"
});

::Legends.Effect.LegendStaffwall <- null;
effectsDefs.push({
	ID = "effects.legend_staffwall",
	Script = "scripts/skills/effects/legend_staffwall_effect",
	Name = "Spearwall",
	Const = "LegendStaffwall"
});

::Legends.Effect.LegendSummonedBearEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_bear_effect",
	Script = "scripts/skills/effects/legend_summoned_bear_effect",
	Name = "Summoned a Bear",
	Const = "LegendSummonedBearEffect"
});

::Legends.Effect.LegendSummonedCatapultEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_catapult_effect",
	Script = "scripts/skills/effects/legend_summoned_catapult_effect",
	Name = "Summoned a Catapult",
	Const = "LegendSummonedCatapultEffect"
});

::Legends.Effect.LegendSummonedHoundEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_hound_effect",
	Script = "scripts/skills/effects/legend_summoned_hound_effect",
	Name = "Summoned a Hound",
	Const = "LegendSummonedHoundEffect"
});

::Legends.Effect.LegendSummonedWolfEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_wolf_effect",
	Script = "scripts/skills/effects/legend_summoned_wolf_effect",
	Name = "Summoned a Wolf",
	Const = "LegendSummonedWolfEffect"
});

::Legends.Effect.LegendSummonedSighthoundEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_sighthound_effect",
	Script = "scripts/skills/effects/legend_summoned_sighthound_effect",
	Name = "Summoned a Sighthound",
	Const = "LegendSummonedSighthoundEffect"
});

::Legends.Effect.LegendSummonedHoundEffect <- null;
effectsDefs.push({
	ID = "effects.legend_summoned_hound_effect",
	Script = "scripts/skills/effects/legend_summoned_hound_effect",
	Name = "Summoned a Hound",
	Const = "LegendSummonedHoundEffect"
});

::Legends.Effect.LegendBerserkerRage <- null;
effectsDefs.push({
	ID = "effects.legend_berserker_rage",
	Script = "scripts/skills/effects/legend_berserker_rage_effect",
	Name = "Rage",
	Const = "LegendBerserkerRage"
});

::Legends.Effect.LegendBonePlating <- null;
effectsDefs.push({
	ID = "effects.legend_bone_plating",
	Script = "scripts/skills/effects/legend_bone_plating_effect",
	Name = "Bone Plating",
	Const = "LegendBonePlating"
});

::Legends.Effect.LegendBuckler <- null;
effectsDefs.push({
	ID = "effects.legend_buckler",
	Script = "scripts/skills/effects/legend_buckler_effect",
	Name = "Buckler Defense",
	Const = "LegendBuckler"
});

::Legends.Effect.LegendDemonHoundAura <- null;
effectsDefs.push({
	ID = "effects.legend_demon_hound_aura",
	Script = "scripts/skills/effects/legend_demon_hound_aura_effect",
	Name = "Sluggish",
	Const = "LegendDemonHoundAura"
});

::Legends.Effect.LegendDisintegrating <- null;
effectsDefs.push({
	ID = "effects.legend_disintegrating",
	Script = "scripts/skills/effects/legend_disintegrating_effect",
	Name = "Disintegrating",
	Const = "LegendDisintegrating"
});

::Legends.Effect.LegendDrumsOfLife <- null;
effectsDefs.push({
	ID = "effects.legend_drums_of_life",
	Script = "scripts/skills/effects/legend_drums_of_life_effect",
	Name = "Drums of Life",
	Const = "LegendDrumsOfLife"
});

::Legends.Effect.LegendDrumsOfWar <- null;
effectsDefs.push({
	ID = "effects.legend_drums_of_war",
	Script = "scripts/skills/effects/legend_drums_of_war_effect",
	Name = "Drums of War",
	Const = "LegendDrumsOfWar"
});

::Legends.Effect.LegendGreenwoodSap <- null;
effectsDefs.push({
	ID = "effects.legend_greenwood_sap",
	Script = "scripts/skills/effects/legend_greenwood_sap_effect",
	Name = "Heartwood Focus",
	Const = "LegendGreenwoodSap"
});

::Legends.Effect.LegendHexeIchorPotion <- null;
effectsDefs.push({
	ID = "effects.legend_hexe_ichor_potion",
	Script = "scripts/skills/effects/legend_hexe_ichor_potion_effect",
	Name = "Hexe Ichor Potion",
	Const = "LegendHexeIchorPotion"
});

::Legends.Effect.LegendHuntingBigGame <- null;
effectsDefs.push({
	ID = "effects.legend_hunting_big_game",
	Script = "scripts/skills/effects/legend_hunting_big_game",
	Name = "Hunting Big Game",
	Const = "LegendHuntingBigGame"
});

::Legends.Effect.LegendImbueEffect <- null;
effectsDefs.push({
	ID = "effects.legend_imbue_effect",
	Script = "scripts/skills/effects/legend_imbue_effect",
	Name = "Imbued",
	Const = "LegendImbueEffect"
});

::Legends.Effect.LeaderbannerEffect <- null;
effectsDefs.push({
	ID = "effects.leaderbanner_effect",
	Script = "scripts/skills/effects/legend_leaderbanner_effect",
	Name = "For the Captain!",
	Const = "LeaderbannerEffect"
});

::Legends.Effect.LegendLurker <- null;
effectsDefs.push({
	ID = "effects.legend_lurker",
	Script = "scripts/skills/effects/legend_lurker_effect",
	Name = "Lurking",
	Const = "LegendLurker"
});

::Legends.Effect.LegendLwRelationship <- null;
effectsDefs.push({
	ID = "effects.legend_lw_relationship",
	Script = "scripts/skills/effects/legend_lw_relationship_effect",
	Name = "Band of Brothers",
	Const = "LegendLwRelationship"
});

::Legends.Effect.LegendMagicCircleOfProtectionEffect <- null;
effectsDefs.push({
	ID = "effects.legend_magic_circle_of_protection_effect",
	Script = "scripts/skills/effects/legend_magic_circle_of_protection_effect",
	Name = "Protected",
	Const = "LegendMagicCircleOfProtectionEffect"
});

::Legends.Effect.LegendMarked <- null;
effectsDefs.push({
	ID = "effects.legend_marked_target",
	Script = "scripts/skills/effects/legend_marked_effect",
	Name = "Marked",
	Const = "LegendMarked"
});

::Legends.Effect.LegendMarkedTarget <- null;
effectsDefs.push({
	ID = "effects.legend_marked_target",
	Script = "scripts/skills/effects/legend_marked_target_effect",
	Name = "Marked",
	Const = "LegendMarkedTarget"
});

::Legends.Effect.LegendMummyCurse <- null;
effectsDefs.push({
	ID = "effects.legend_mummy_curse",
	Script = "scripts/skills/effects/legend_mummy_curse_effect",
	Name = "Curse of the Mummy",
	Const = "LegendMummyCurse"
});

::Legends.Effect.LegendNamedAxe <- null;
effectsDefs.push({
	ID = "effects.legend_named_axe",
	Script = "scripts/skills/effects/legend_named_axe_effect",
	Name = "Named Axe",
	Const = "LegendNamedAxe"
});

::Legends.Effect.LegendNamedEstoc <- null;
effectsDefs.push({
	ID = "effects.legend_named_estoc",
	Script = "scripts/skills/effects/legend_named_estoc_effect",
	Name = "Named Estoc",
	Const = "LegendNamedEstoc"
});

::Legends.Effect.LegendNamedFencingSword <- null;
effectsDefs.push({
	ID = "effects.legend_named_fencing_sword",
	Script = "scripts/skills/effects/legend_named_fencing_sword_effect",
	Name = "Named Fencing Sword",
	Const = "LegendNamedFencingSword"
});

::Legends.Effect.LegendParryingDagger <- null;
effectsDefs.push({
	ID = "effects.legend_parrying_dagger",
	Script = "scripts/skills/effects/legend_parrying_dagger_effect",
	Name = "Parrying Dagger Defense",
	Const = "LegendParryingDagger"
});

::Legends.Effect.LegendParrying <- null;
effectsDefs.push({
	ID = "effects.legend_parrying",
	Script = "scripts/skills/effects/legend_parrying_effect",
	Name = "Parrying Stance",
	Const = "LegendParrying"
});

::Legends.Effect.LegendPeacefulReassured <- null;
effectsDefs.push({
	ID = "effects.legend_peaceful_reassured",
	Script = "scripts/skills/effects/legend_peaceful_reassured_effect",
	Name = "Reassured",
	Const = "LegendPeacefulReassured"
});

::Legends.Effect.LegendPieEffect <- null;
effectsDefs.push({
	ID = "effects.legend_pie_effect",
	Script = "scripts/skills/effects/legend_pie_effect",
	Name = "Satiated",
	Const = "LegendPieEffect"
});

::Legends.Effect.LegendPorridgeEffect <- null;
effectsDefs.push({
	ID = "effects.legend_porridge_effect",
	Script = "scripts/skills/effects/legend_porridge_effect",
	Name = "Porridge",
	Const = "LegendPorridgeEffect"
});

::Legends.Effect.LegendPrayerOfFaith <- null;
effectsDefs.push({
	ID = "effects.legend_prayer_of_faith",
	Script = "scripts/skills/effects/legend_prayer_of_faith_effect",
	Name = "Prayer of Faith",
	Const = "LegendPrayerOfFaith"
});

::Legends.Effect.LegendPuddingEffect <- null;
effectsDefs.push({
	ID = "effects.legend_pudding_effect",
	Script = "scripts/skills/effects/legend_pudding_effect",
	Name = "Satiated",
	Const = "LegendPuddingEffect"
});

::Legends.Effect.LegendRatPoison <- null;
effectsDefs.push({
	ID = "effects.legend_rat_poison",
	Script = "scripts/skills/effects/legend_rat_poison_effect",
	Name = "Infected",
	Const = "LegendRatPoison"
});

::Legends.Effect.LegendRealmOfNightmares <- null;
effectsDefs.push({
	ID = "effects.legend_realm_of_nightmares",
	Script = "scripts/skills/effects/legend_realm_of_nightmares_effect",
	Name = "Realm of Nightmares",
	Const = "LegendRealmOfNightmares"
});

::Legends.Effect.Scroll <- null;
effectsDefs.push({
	ID = "effects.scroll",
	Script = "scripts/skills/effects/legend_scroll_effect",
	Name = "Scroll Effect",
	Const = "Scroll"
});

::Legends.Effect.LegendSecondWind <- null;
effectsDefs.push({
	ID = "effects.legend_second_wind",
	Script = "scripts/skills/effects/legend_second_wind_effect",
	Name = "Second Wind",
	Const = "LegendSecondWind"
});

::Legends.Effect.LegendHidden <- null;
effectsDefs.push({
	ID = "effects.legend_hidden",
	Script = "scripts/skills/effects/legend_hidden_effect",
	Name = "Hidden",
	Const = "LegendHidden"
});

::Legends.Effect.LegendSkinGhoulBlood <- null;
effectsDefs.push({
	ID = "effects.legend_skin_ghoul_blood",
	Script = "scripts/skills/effects/legend_skin_ghoul_blood_effect",
	Name = "Skin Ghoul Blood",
	Const = "LegendSkinGhoulBlood"
});

::Legends.Effect.LegendSprint <- null;
effectsDefs.push({
	ID = "effects.legend_sprint",
	Script = "scripts/skills/effects/legend_sprint_effect",
	Name = "Sprinting",
	Const = "LegendSprint"
});

::Legends.Effect.LegendStollwurmBlood <- null;
effectsDefs.push({
	ID = "effects.legend_stollwurm_blood",
	Script = "scripts/skills/effects/legend_stollwurm_blood_effect",
	Name = "Stollwurm Vigor",
	Const = "LegendStollwurmBlood"
});

::Legends.Effect.LegendValaSpiritualBondEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_spiritual_bond_effect",
	Script = "scripts/skills/effects/legend_vala_spiritual_bond_effect",
	Name = "Spiritual Bond",
	Const = "LegendValaSpiritualBondEffect"
});

::Legends.Effect.LegendValaThreadsEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_threads_effect",
	Script = "scripts/skills/effects/legend_vala_threads_effect",
	Name = "Threads of Fate",
	Const = "LegendValaThreadsEffect"
});

::Legends.Effect.LegendValaTranceMalevolentEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_trance_malevolent_effect",
	Script = "scripts/skills/effects/legend_vala_trance_malevolent_effect",
	Name = "Haunted",
	Const = "LegendValaTranceMalevolentEffect"
});

::Legends.Effect.LegendValaTrancePerspectiveEffect <- null;
effectsDefs.push({
	ID = "effects.legend_vala_trance_perspective_effect",
	Script = "scripts/skills/effects/legend_vala_trance_perspective_effect",
	Name = "Observed",
	Const = "LegendValaTrancePerspectiveEffect"
});

::Legends.Effect.LegendValaWardenDamage <- null;
effectsDefs.push({
	ID = "special.legend_vala_warden_damage",
	Script = "scripts/skills/effects/legend_vala_warden_damage",
	Name = "Warden Damage Scaling",
	Const = "LegendValaWardenDamage"
});

::Legends.Effect.LegendVengeance <- null;
effectsDefs.push({
	ID = "effects.legend_vengeance",
	Script = "scripts/skills/effects/legend_vengeance_effect",
	Name = "Vengeance!",
	Const = "LegendVengeance"
});

::Legends.Effect.LegendViolentDecompositionEffect <- null;
effectsDefs.push({
	ID = "effects.legend_violent_decomposition_effect",
	Script = "scripts/skills/effects/legend_violent_decomposition_effect",
	Name = "Violent Decomposition",
	Const = "LegendViolentDecompositionEffect"
});

::Legends.Effect.LegendWebAtStart <- null;
effectsDefs.push({
	ID = "effects.legend_web_at_start",
	Script = "scripts/skills/effects/legend_web_at_start_effect",
	Name = "Start Combat Trapped in Web",
	Const = "LegendWebAtStart"
});

::Legends.Effect.LegendZombiePoison <- null;
effectsDefs.push({
	ID = "effects.legend_zombie_poison",
	Script = "scripts/skills/effects/legend_zombie_poison_effect",
	Name = "Infected",
	Const = "LegendZombiePoison"
});

::Legends.Effect.LegendBrothersInChains <- null;
effectsDefs.push({
	ID = "effects.legend_brothers_in_chains",
	Script = "scripts/skills/effects/legend_brothers_in_chains_effect",
	Name = "Brothers in Chains",
	Const = "LegendBrothersInChains"
});

::Legends.Effect.LegendHeadache <- null;
effectsDefs.push({
	ID = "effects.legend_headache",
	Script = "scripts/skills/effects_world/legend_headache_effect",
	Name = "Headache",
	Const = "LegendHeadache"
});

::Legends.Effect.LegendIrritable <- null;
effectsDefs.push({
	ID = "effects.legend_irritable",
	Script = "scripts/skills/effects_world/legend_irritable_effect",
	Name = "Irritable",
	Const = "LegendIrritable"
});

::Legends.Effect.LegendWellTended <- null;
effectsDefs.push({
	ID = "effects.legend_well_tended",
	Script = "scripts/skills/effects_world/legend_well_tended_effect",
	Name = "Well Tended",
	Const = "LegendWellTended"
});

::Legends.Effect.LegendRssRadianceEffect <- null;
effectsDefs.push({
	ID = "effects.legend_RSS_radiance_effect",
	Script = "scripts/skills/rune_sigils/legend_RSS_radiance_effect",
	Name = "Blinded",
	Const = "LegendRssRadianceEffect"
});

::Legends.Effect.LegendRswBleedingEffect <- null;
effectsDefs.push({
	ID = "effects.legend_RSW_bleeding_effect",
	Script = "scripts/skills/rune_sigils/legend_RSW_bleeding_effect",
	Name = "Bleeding",
	Const = "LegendRswBleedingEffect"
});

::Legends.Effect.LegendVeteranLevels <- null;
effectsDefs.push({
	ID = "effects.legend_veteran_levels",
	Script = "scripts/skills/effects/legend_veteran_levels_effect",
	Name = "",
	Const = "LegendVeteranLevels"
});

::Legends.Effect.LegendHiddenKobold <- null;
effectsDefs.push({
	ID = "effects.legend_hidden_kobold",
	Script = "scripts/skills/effects/legend_hidden_kobold_effect",
	Name = "Hidden",
	Const = "LegendHiddenKobold"
});

::Legends.Effect.Night <- null;
effectsDefs.push({
	ID = "special.night",
	Script = "scripts/skills/special/night_effect",
	Const = "Night",
	Name = "Nighttime",
});

::Legends.Effect.OathOfFortificationWarning <- null;
effectsDefs.push({
	ID = "special.oath_of_fortification_warning",
	Script = "scripts/skills/special/oath_of_fortification_warning",
	Const = "OathOfFortificationWarning",
	Name = "Fortifying!",
});

::Legends.Effect.OathOfHonorWarning <- null;
effectsDefs.push({
	ID = "special.oath_of_honor_warning",
	Script = "scripts/skills/special/oath_of_honor_warning",
	Const = "OathOfHonorWarning",
	Name = "Honorable Combat!",
});

::Legends.Effect.DoubleGrip <- null;
effectsDefs.push({
	ID = "special.double_grip",
	Script = "scripts/skills/special/double_grip",
	Const = "DoubleGrip",
	Name = "Double Grip",
});

::Legends.Effect.MoodCheck <- null;
effectsDefs.push({
	ID = "special.mood_check",
	Script = "scripts/skills/special/mood_check",
	Const = "MoodCheck",
	Name = "Mood Check",
});

::Legends.Effect.Check <- null;
effectsDefs.push({
	ID = "special.morale.check",
	Script = "scripts/skills/special/morale_check",
	Const = "Check",
	Name = "Morale Check",
});

::Legends.Effect.NoAmmoWarning <- null;
effectsDefs.push({
	ID = "special.no_ammo_warning",
	Script = "scripts/skills/special/no_ammo_warning",
	Const = "NoAmmoWarning",
	Name = "No Ammunition!",
});

::Legends.Effect.WeaponBreakingWarning <- null;
effectsDefs.push({
	ID = "special.weapon_breaking_warning",
	Script = "scripts/skills/special/weapon_breaking_warning",
	Const = "WeaponBreakingWarning",
	Name = "Weapon in poor condition!",
});

::Legends.Effect.LegendRain <- null;
effectsDefs.push({
	ID = "special.legend_rain",
	Script = "scripts/skills/special/legend_rain_effect",
	Const = "LegendRain",
	Name = "Raining",
});

::Legends.Effect.LegendRsaEndurance <- null;
effectsDefs.push({
	ID = "special.legend_RSA_endurance",
	Script = "scripts/skills/rune_sigils/legend_RSA_endurance",
	Const = "LegendRsaEndurance",
	Name = "Rune Sigil: Endurance",
});

::Legends.Effect.LegendRsaResilience <- null;
effectsDefs.push({
	ID = "special.legend_RSA_resilience",
	Script = "scripts/skills/rune_sigils/legend_RSA_resilience",
	Const = "LegendRsaResilience",
	Name = "Rune Sigil: Resilience",
});

::Legends.Effect.LegendRsaSafety <- null;
effectsDefs.push({
	ID = "special.legend_RSA_safety",
	Script = "scripts/skills/rune_sigils/legend_RSA_safety",
	Const = "LegendRsaSafety",
	Name = "Rune Sigil: Safety",
});

::Legends.Effect.LegendRshBravery <- null;
effectsDefs.push({
	ID = "special.legend_RSH_bravery",
	Script = "scripts/skills/rune_sigils/legend_RSH_bravery",
	Const = "LegendRshBravery",
	Name = "Rune Sigil: Bravery",
});

::Legends.Effect.LegendRshClarity <- null;
effectsDefs.push({
	ID = "special.legend_RSH_clarity",
	Script = "scripts/skills/rune_sigils/legend_RSH_clarity",
	Const = "LegendRshClarity",
	Name = "Rune Sigil: Clarity",
});

::Legends.Effect.LegendRshLuck <- null;
effectsDefs.push({
	ID = "special.legend_RSH_luck",
	Script = "scripts/skills/rune_sigils/legend_RSH_luck",
	Const = "LegendRshLuck",
	Name = "Rune Sigil: Luck",
});

::Legends.Effect.LegendRssDefense <- null;
effectsDefs.push({
	ID = "special.legend_RSS_defense",
	Script = "scripts/skills/rune_sigils/legend_RSS_defense",
	Const = "LegendRssDefense",
	Name = "Rune Sigil: Defense",
});

::Legends.Effect.LegendRssRadiance <- null;
effectsDefs.push({
	ID = "special.legend_RSS_radiance",
	Script = "scripts/skills/rune_sigils/legend_RSS_radiance",
	Const = "LegendRssRadiance",
	Name = "Rune Sigil: Radiance",
});

::Legends.Effect.LegendRswAccuracy <- null;
effectsDefs.push({
	ID = "special.legend_RSW_accuracy",
	Script = "scripts/skills/rune_sigils/legend_RSW_accuracy",
	Const = "LegendRswAccuracy",
	Name = "Rune Sigil: Accuracy",
});

::Legends.Effect.LegendRswBleeding <- null;
effectsDefs.push({
	ID = "special.legend_RSW_bleeding",
	Script = "scripts/skills/rune_sigils/legend_RSW_bleeding",
	Const = "LegendRswBleeding",
	Name = "Rune Sigil: Bleeding",
});

::Legends.Effect.LegendRswFeeding <- null;
effectsDefs.push({
	ID = "special.legend_RSW_feeding",
	Script = "scripts/skills/rune_sigils/legend_RSW_feeding",
	Const = "LegendRswFeeding",
	Name = "Rune Sigil: Feeding",
});

::Legends.Effect.LegendRswPoison <- null;
effectsDefs.push({
	ID = "special.legend_RSW_poison",
	Script = "scripts/skills/rune_sigils/legend_RSW_poison",
	Const = "LegendRswPoison",
	Name = "Rune Sigil: Poison",
});

::Legends.Effect.LegendRswPower <- null;
effectsDefs.push({
	ID = "special.legend_RSW_power",
	Script = "scripts/skills/rune_sigils/legend_RSW_power",
	Const = "LegendRswPower",
	Name = "Rune Sigil: Power",
});

::Legends.Effect.LegendRswUnbreaking <- null;
effectsDefs.push({
	ID = "special.legend_RSW_unbreaking",
	Script = "scripts/skills/rune_sigils/legend_RSW_unbreaking",
	Const = "LegendRswUnbreaking",
	Name = "Rune Sigil: Unbreaking",
});

::Legends.Effect.LegendRelationshipCheck <- null;
effectsDefs.push({
	ID = "special.legend_relationship_check",
	Script = "scripts/skills/special/legend_relationship_check",
	Const = "LegendRelationshipCheck",
	Name = "Relationship Check",
});

::Legends.Effect.LegendAnimatedPlayerProperties <- null;
effectsDefs.push({
	ID = "special.legend_animated_player_properties",
	Script = "scripts/skills/special/legend_animated_player_properties",
	Const = "LegendAnimatedPlayerProperties",
	Name = "",
});

::Legends.Effect.LegendHorseriderSkill <- null;
effectsDefs.push({
	ID = "special.legend_horserider_skill",
	Script = "scripts/skills/special/legend_horserider_skill",
	Const = "LegendHorseriderSkill",
	Name = "",
});

::Legends.Effect.LegendGravedigging <- null;
effectsDefs.push({
	ID = "effects.legend_gravedigging",
	Script = "scripts/skills/effects/legend_gravedigging_effect",
	Const = "LegendGravedigging",
	Name = "Gravedigging",
});

::Legends.Effect.LegendMartialMarch <- null;
effectsDefs.push({
	ID = "effects.legend_martial_march",
	Script = "scripts/skills/effects/legend_martial_march_effect",
	Const = "LegendMartialMarch",
	Name = "Martial March",
});

::Legends.Effect.LegendPrepareBullet <- null;
effectsDefs.push({
	ID = "effects.legend_prepare_bullet",
	Script = "scripts/skills/effects/legend_prepare_bullet_effect",
	Const = "LegendPrepareBullet",
	Name = "Prepare Bullet",
});

::Legends.Effect.LegendCommanded <- null;
effectsDefs.push({
	ID = "effects.legend_commanded",
	Script = "scripts/skills/effects/legend_commanded_effect",
	Const = "LegendCommanded",
	Name = "Commanded",
});

::Legends.Effect.LegendRamHammer <- null;
effectsDefs.push({
	ID = "effects.legend_ram_hammer",
	Script = "scripts/skills/effects/legend_ram_hammer_effect",
	Const = "LegendRamHammer",
	Name = "Ram Hammer",
});

::Legends.Effect.LegendCompromisedArmor <- null;
effectsDefs.push({
	ID = "effects.legend_compromised_armor",
	Script = "scripts/skills/effects/legend_compromised_armor_effect",
	Const = "LegendCompromisedArmor",
	Name = "Compromised Armor",
});

::Legends.Effect.LegendFlourish <- null;
effectsDefs.push({
	ID = "effects.legend_flourish",
	Script = "scripts/skills/effects/legend_flourish_effect",
	Const = "LegendFlourish",
	Name = "Flourish",
});

::Legends.Effect.LegendFreedomOfMovement <- null;
effectsDefs.push({
	ID = "effects.legend_freedom_of_movement",
	Script = "scripts/skills/effects/legend_freedom_of_movement_effect",
	Const = "LegendFreedomOfMovement",
	Name = "Freedom of Movement",
});

::Legends.Effect.LegendEnragedHyenaBite <- null;
effectsDefs.push({
	ID = "effects.legend_enraged_hyena_bite",
	Script = "scripts/skills/effects/legend_enraged_hyena_bite_effect",
	Const = "LegendEnragedHyenaBite",
	Name = "Locked in Jaws",
});

::Legends.Effect.LegendEnragedHyenaGrip <- null;
effectsDefs.push({
	ID = "effects.legend_enraged_hyena_grip",
	Script = "scripts/skills/effects/legend_enraged_hyena_grip_effect",
	Const = "LegendEnragedHyenaGrip",
	Name = "Predatory Grip",
});

::Legends.Effect.LegendPatientHunter <- null;
effectsDefs.push({
	ID = "effects.legend_patient_hunter",
	Script = "scripts/skills/effects/legend_patient_hunter_effect",
	Const = "LegendPatientHunter",
	Name = "Patient Hunter",
});

::Legends.Effect.LegendArmorTracking <- null;
effectsDefs.push({
	ID = "effects.legend_armor_tracking",
	Script = "scripts/skills/effects/legend_armor_tracking_effect",
	Const = "LegendArmorTracking",
	Name = "LegendArmorTracking",
});

::Legends.Effects.addEffectDefObjects(effectsDefs);
