::Const.World.Spawn.GreenskinHorde =
{
	Name = "GreenskinHorde",
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_orc_02",
	MinR = 136,
	MaxR = 1115,
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinSkirmisherLOW,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinSkirmisher,
					Cost = 15
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendGoblinPlunderer,
					MinR = 800,
					Cost = 40
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendGoblinHarrier,
					MinR = 1200,
					Cost = 50
				}
			]
		},
		{
			Weight = 20,
			Types = [
				// {
				// 	Type = this.Const.World.Spawn.Troops.KoboldFighter,
				// 	Cost = 10
				// },
				{
					Type = this.Const.World.Spawn.Troops.GoblinAmbusherLOW,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.GoblinAmbusher,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinWolfrider,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendGoblinDirewolfRider,
					MinR = 1200,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendGoblinWhiteDirewolfRider,
					MinR = 1600,
					Cost = 80
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinOverseer,
					Cost = 35
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GoblinShaman,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendGoblinWitchDoctor,
					MinR = 1600,
					Cost = 60
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.LegendGoblinTribeDefender,
					MinR = 450,
					Cost = 40
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcYoung,
					Cost = 16
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcWarrior,
					MinR = 0.15 * 1115,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcBerserker,
					Cost = 25
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendGoblinBerserker,
					MinR = 900,
					Cost = 50
				},
				{
					Type = ::Const.World.Spawn.Troops.LegendOrcMadBerserker,
					MinR = 1200,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcWarlord,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcElite,
					MinR = 0.75 * 1115,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcTyrant,
					MinR = 1300,
					Cost = 70
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcBehemoth,
					MinR = 0.50 * 1115,
					Cost = 80
				}
			]
		}
	]
}