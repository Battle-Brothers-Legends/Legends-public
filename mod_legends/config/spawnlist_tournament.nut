if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.GrandGauntlet <-
{
	Name = "Tournament competitors",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 690,
	MinR = 97,
	Troops = [
		{
			Weight = 80,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 0.25 * 420,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.Peasant,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.NorthernSlave,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.SouthernPeasant,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.PeasantArmed,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaVeteran,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianThrall,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.CultistAmbush,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.MercenaryLOW,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.Conscript,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
					Cost = 22
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantBlacksmith,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcBerserker,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Mercenary,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantSquire,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianChampion,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.BountyHunter,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 40
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaRanged,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.BountyHunterRanged,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.Gunner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker,
					Cost = 50,
				}
			]
		},
		{
			Weight = 5,
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 30,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.Officer,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.Assassin,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 40,
				},
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 40,
				},
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianChosen,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 60,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.Knight,
					Cost = 80,
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditWarlord,
					Cost = 80,
				}
			]
		}
	]
}

::Const.World.Spawn.GrandMelee <-
{
	Name = "Tournament partipants",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 690,
	MinR = 97,
	Troops = [
		{
			Weight = 75,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditRabble,
					MaxR = 0.25 * 420,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.Peasant,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.NorthernSlave,
					Cost = 7
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditThug,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.SouthernPeasant,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieNomad,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.PeasantArmed,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaVeteran,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.Spider,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonLight,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyLight,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianThrall,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.CultistAmbush,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.ConscriptPolearm,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcYoung,
					Cost = 16
				},
				{
					Type = this.Const.World.Spawn.Troops.MercenaryLOW,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.SandGolem,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyMedium,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.Conscript,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
					Cost = 22
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantBlacksmith,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Serpent,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Mercenary,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.GhoulHIGH,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendBear,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyHeavy,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantSquire,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianChampion,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.BountyHunter,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonGladiator,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.SandGolemMEDIUM,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcWarrior,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Unhold,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.UnholdBog,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.UnholdFrost,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.Schrat,
					Cost = 70
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				},
				{
					Type = this.Const.World.Spawn.Troops.Lindwurm,
					Cost = 80
				}

			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.Warhound,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.ArmoredWardog,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.Hyena,
					Cost = 15
				},
		 		{
		 			Type = this.Const.World.Spawn.Troops.KoboldFighter,
		 			Cost = 15
		 		},
				{
					Type = this.Const.World.Spawn.Troops.Direwolf,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.HyenaHIGH,
					MinR = 400,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.DirewolfHIGH,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Alp,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					MinR = 800,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
					MinR = 800,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianBeastmaster,
					Cost = 15,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.BarbarianUnhold,
							Cost = 50,
							function Weight(scale) {
								local c = 100 - (scale * 100);
								return this.Math.max(20, c);
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.BarbarianUnholdFrost,
							Cost = 70,
							function Weight(scale) {
								local c = 100 - ((1.0 - scale) * 100);
								return this.Math.min(80, c);
							}
						}
					]
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonAlp,
					Cost = 150
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolf,
					Cost = 200
				}
			]
		},
		{
			Weight = 15,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditRabblePoacher,
					Cost = 8
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaRanged,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.BountyHunterRanged,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.Gunner,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker,
					Cost = 50,
				}
			]
		},
		{
			Weight = 5,
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 30,
				},
				{
					Type = this.Const.World.Spawn.Troops.Officer,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinOverseer,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.Assassin,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinShaman,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 40,
				},
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 40,
				},
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianChosen,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcWarlord,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 60,
				},
				{
					Type = this.Const.World.Spawn.Troops.Necromancer,
					Cost = 30,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 25,
					Weight = 0,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
							MinR = 200,
							Cost = 6,
							function Weight(scale) {
								local c = 100 - (scale * 100);
								return this.Math.max(0, c);
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
							MinR = 400,
							Cost = 24,
							function Weight(scale) {
								local c = 100 - ((1.0 - scale) * 100);
								return this.Math.min(100, c);
							}
						}
					]
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonPriest,
					Cost = 40,
					Roll = true
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 33,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.SkeletonHeavyBodyguard,
							Cost = 30,
							function Weight(scale) {
								return 100;
							}
						}
					]
				},
				{
					Type = this.Const.World.Spawn.Troops.Hexe,
					Cost = 50,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 66,
					Weight = 0, //0 Weight guarentees this will be added
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.DirewolfBodyguard,
							Cost = 20,
							function Weight(scale) {
								return 50;
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.SpiderBodyguard,
							Cost = 20,
							function Weight(scale) {
								return 50;
							}
						}
					]
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					MinR = 1200,
					Cost = 70
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyQueen,
					Cost = 70
				},
				{
					Type = this.Const.World.Spawn.Troops.Knight,
					Cost = 80,
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditWarlord,
					Cost = 80,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendRedbackSpider,
					Cost = 200
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendStollwurm,
					Cost = 350
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendGreenwoodSchrat,
					Cost = 350
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendHexeLeader,
					Cost = 200,
					MinGuards = 2,
					MaxGuards = 3,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolfBodyguard,
							Cost = 250,
							function Weight(scale) {
								return 50;
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
							Cost = 150,
							function Weight(scale) {
								return 50;
							}
						}
					]
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcElite,
					MinR = 400,
					Cost = 60

				},
				{
					Type = this.Const.World.Spawn.Troops.LegendRockUnhold,
					Cost = 400
				}
			]
		}
	]
}
