::Const.World.Spawn.Cultists =
{
	Name = "Cultists",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_civilian_03",
	MaxR = 105,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.CultistAmbush,
					Cost = 15
				}
			]
		}
	]
}

::Const.World.Spawn.Peasants =
{
	Name = "Peasants",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_civilian_03",
	MaxR = 160,
	MinR = 30,
	Troops = [
		{
			Weight = 85,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Peasant,
					Cost = 5
				}
			]
		},
		{
			Weight = 12,
			Types =
			[
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
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					Cost = 20,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantBlacksmith,
					Cost = 20,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantSquire,
					Cost = 25,
				}
			]
		},
		{
			Weight = 3,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				}
			]
		}
	]
}

::Const.World.Spawn.PeasantsArmed =
{
	Name = "PeasantsArmed",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_civilian_03",
	MaxR = 160,
	Troops = [
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.PeasantArmed,
					Cost = 10
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantButcher,
					Cost = 16
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 15
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantBlacksmith,
					Cost = 25
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMinstrel,
					Cost = 12
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantPoacher,
					Cost = 18
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWoodsman,
					Cost = 15
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantMiner,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantSquire,
					Cost = 35
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantWitchHunter,
					Cost = 35
				}
			]
		}
	]
}

::Const.World.Spawn.BountyHunters =
{
	Name = "BountyHunters",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 525,
	MinR = 103,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BountyHunter,
					Cost = 25
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BountyHunterRanged,
					Cost = 20
				}
			]
		}
	]
}

::Const.World.Spawn.Mercenaries =
{
	Name = "Mercenaries",
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
					MaxR = 400,
					Type = this.Const.World.Spawn.Troops.MercenaryLOW,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.Mercenary,
					Cost = 25
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 15,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.MercenaryRanged,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40
				}
			]
		}
	]
}

::Const.World.Spawn.Militia =
{
	Name = "Militia",
	IsDynamic = true,
	MovementSpeedMult = 0.899999976,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_militia_01",
	MaxR = 326,
	MinR = 60,
	Troops = [
		{
			Weight = 70,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Militia,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.MilitiaVeteran,
					Cost = 12
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaRanged,
					Cost = 10
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.MilitiaCaptain,
					Cost = 20,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types =
			[
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
					Type = this.Const.World.Spawn.Troops.LegendPeasantMonk,
					Cost = 15,
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendPeasantFarmhand,
					Cost = 15,
				}
			]
		}
	]
}

::Const.World.Spawn.PeasantsSouthern =
{
	Name = "PeasantsSouthern",
	IsDynamic = true,
	MovementSpeedMult = 0.75,
	VisibilityMult = 1.0,
	VisionMult = 0.75,
	Body = "figure_civilian_06",
	MaxR = 160,
	Troops =
	[
		{
			Weight = 100,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.SouthernPeasant,
					Cost = 10
				}
			]
		}
	]
};
