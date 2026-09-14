::Const.World.Scaling.Arena <- {};
::Const.World.Scaling.Arena.StrongerEnemiesDay <- 50;

::Const.World.Scaling.AI <- {};
::Const.World.Scaling.AI.LegendsCorruptionAdvancedAIDay <- 100;

::Const.World.Scaling.Beasts.LegendsAlpNightmareScaleDay1 <- 20;
::Const.World.Scaling.Beasts.LegendsAlpNightmareScaleDay2 <- 40;
::Const.World.Scaling.Beasts.LegendsAlpNightmareScaleDay3 <- 50;
::Const.World.Scaling.Beasts.LegendsAlpNightmareScaleDay4 <- 75;
::Const.World.Scaling.Beasts.LegendsAlpNightmareScaleDay5 <- 100;
::Const.World.Scaling.Beasts.LegendsAlpShadowMDefIncreaseDay <- 150;
::Const.World.Scaling.Beasts.LegendsBasiliskHeadhunterDay <- 35;
::Const.World.Scaling.Beasts.LegendsBasiliskEscapeArtistDay <- 50;
::Const.World.Scaling.Beasts.LegendsBearDamageIncreaseDay <- 90;
::Const.World.Scaling.Beasts.LegendsBearDamageIncreaseDay2 <- 190;
::Const.World.Scaling.Beasts.LegendsGreenwoodSchratMeleeSkillIncreaseDay <- 250;
::Const.World.Scaling.Beasts.LegendsHyenaEnragedDodgeDay <- 100;
::Const.World.Scaling.Beasts.LegendsSpiderClusterDamageIncreaseDay <- 25;
::Const.World.Scaling.Beasts.LegendsSpiderClusterStatIncreaseDay2 <- 50;
::Const.World.Scaling.Beasts.LegendsSpiderDamageIncreaseDay <- 30;
::Const.World.Scaling.Beasts.LegendsUnholdDamageIncreaseDay2 <- 190;
::Const.World.Scaling.Beasts.LegendsStollwurmStatIncreaseDay <- 170;
::Const.World.Scaling.Beasts.getDistanceScaling <- @(_action, _tile, _multiplier = 1.0) ::Math.maxf(0.7, ::Math.minf(1.5, _multiplier * _action.getDistanceToSettlements(_tile) / 14.0)); // legends beasts set multiplier to 2.0

::Const.World.Scaling.Brigands.LegendsRabbleDefIncreaseDay <- 40; // do they even spawn then?
::Const.World.Scaling.Brigands.LegendsBanditExecutionerSwordDay <- 40;

::Const.World.Scaling.Barbarians.LegendsMarauderPillagerNewPerksDay <- 60;

::Const.World.Scaling.Goblins.LegendsAmbusherHeavyBowDay <- 60;
::Const.World.Scaling.Goblins.LegendDirewolfRiderHarrierDay <- 80;
::Const.World.Scaling.Goblins.LegendsFighterMeleeSkillIncreaseDay <- 180;

::Const.World.Scaling.Nomads.LegendsManhunterBetterArmorDay <- 18;
::Const.World.Scaling.Nomads.LegendsManhunterVeteranBetterArmorDay <- 50;
::Const.World.Scaling.Nomads.LegendsOutlawDodgeDay <- 40;
::Const.World.Scaling.Nomads.LegendsSlinger2HSlingDay <- 30;
::Const.World.Scaling.Nomads.LegendsSlingerBetterArmorDay <- 40;

::Const.World.Scaling.Orcs.LegendsOrcHighStatIncreaseDay <- 200;

::Const.World.Scaling.Undead.LegendsUndeadHighMDefIncreaseDay <- 140;

::Const.World.Scaling.UndeadMummies <- {};
::Const.World.Scaling.UndeadMummies.LegendsMummyPolearmSpecDay <- 100;

::Const.World.Scaling.getDistanceScaling <- @(_action, _tile, _isAttacker = false) ::Math.maxf(1.0, _action.getDistanceToSettlements(_tile) / 14.0 * (_isAttacker ? ::Math.minf(1.0, ::World.getTime().Days / 100) : 1.0)); // attackers distance scaling is reduced until day 100