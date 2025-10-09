::Const.AI.Agent.ID.LegendStollwurm <- "agent.legend_stollwurm";
::Const.AI.Agent.ID.LegendWhiteWarwolf <- "agent.legend_whitewarwolf";
::Const.AI.Agent.ID.LegendWhiteDirewolf <- "agent.legend_whitewolf";
::Const.AI.Agent.ID.LegendDemonAlp <- "agent.legend_demonalp";
::Const.AI.Agent.ID.LegendRedbackSpider <- "agent.legend_redback";
::Const.AI.Agent.ID.LegendSkinGhoul <- "agent.legend_skin_ghoul";
::Const.AI.Agent.ID.LegendBanditRabble <- "agent.legend_bandit_rabble";
::Const.AI.Agent.ID.LegendBanshee <- "agent.legend_banshee";
::Const.AI.Agent.ID.LegendDemonHound <- "agent.legend_demon_hound";
::Const.AI.Agent.ID.LegendVampireLord <- "agent.legend_vampire_lord";
::Const.AI.Agent.ID.LegendButcher <- "agent.legend_butcher";
::Const.AI.Agent.ID.Bear <- "agent.bear";
::Const.AI.Agent.ID.Boar <- "agent.boar";
::Const.AI.Agent.ID.BasiliskDrone <- "agent.basilisk_drone";
::Const.AI.Agent.ID.BasiliskDroneAggressive <- "agent.basilisk_drone_aggressive";
::Const.AI.Agent.ID.LegendBasiliskSentry <- "agent.legend_basilisk_sentry";
// ::Const.AI.Agent.ID.KoboldWolfrider <- "agent.kobold_wolfrider";
::Const.AI.Agent.ID.LegendMummyQueen <- "agent.legend_mummy_queen";
::Const.AI.Agent.ID.LegendMinstrel <- "agent.minstrel";
::Const.AI.Agent.ID.LegendEnragedHyena <- "agent.legend_enraged_hyena";

local count = ::Const.AI.Behavior.ID.COUNT;
::Const.AI.Behavior.ID.Howl <- count++;
::Const.AI.Behavior.ID.SpawnShadow <- count++;
::Const.AI.Behavior.ID.Corruption <- count++;
::Const.AI.Behavior.ID.COUNT = count;

::Const.AI.Behavior.Name.extend([
	"Howl",
	"SpawnShadow",
	"Corruption"
]);

::Const.AI.Behavior.Order.Corruption <- 39;
::Const.AI.Behavior.Order.SpawnShadow <- 39;
::Const.AI.Behavior.Order.Howl <- 39;

::Const.AI.Behavior.Score.Howl <- 60;
::Const.AI.Behavior.Score.Corruption <- 480;
::Const.AI.Behavior.Score.SpawnShadow <- 2000;

::Const.AI.Behavior.HowlMaxMoraleRatio <- 2.5;
::Const.AI.Behavior.HowlMinAlliesInRange <- 1;
::Const.AI.Behavior.KnockBackMinOpponentsInMelee <- 2;
::Const.AI.Behavior.SleepTurnDoneMult <- 0.1;

//Corruption
::Const.AI.Behavior.CorruptionTurnDoneMult <- 1.1;
::Const.AI.Behavior.CorruptionAttackingMeBonus <- 7.0;
::Const.AI.Behavior.CorruptionNumAffectedPOW <- 1.2;
::Const.AI.Behavior.CorruptionRedundantPOW <- 0.85;
::Const.AI.Behavior.CorruptionAtMyTileBonus <- 4.0;
::Const.AI.Behavior.CorruptionNearAllyBonus <- 2.0;
::Const.AI.Behavior.CorruptionTargetValueMult <- 2.0;

::Const.AI.Behavior.KnockoutPriorityMult = 1.35;
::Const.AI.Behavior.SplitShieldDestroyBonusMult = 1.25;
