::Const.World.Spawn.NomadRoamers =
{
	Name = "NomadRoamers",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_03",
	Fixed = [],
	MinR = 56, // TEST
	MaxR = 188,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					MaxR = 110,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					MinR = 200,
					Cost = 14
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					MinR = 250,
					Cost = 30
				}
			]
		}
	]
};

::Const.World.Spawn.NomadRaiders =
{
	Name = "NomadRaiders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	Fixed = [],
	MinR = 63, // TEST
	MaxR = 600
	Troops =
	[
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Slave,
					MaxR = 130,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					MinR = 100,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					MinR = 120,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker, //looks like M.Archer
					MinR = 420,
					Cost = 65,
					Roll = true
				}
			]
		},
		{
			Weight = 6,
			MinR = 140,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 60,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSighthound,
					Cost = 5
				}
			]
		},
		{
			Weight = 1,
			MinR = 160,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 65,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 310,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 65,
					Roll = true
				}
			]
		}
	]
};

::Const.World.Spawn.NomadDefenders =
{
	Name = "NomadDefenders",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	Fixed = [],
	MinR = 63, // TEST
	MaxR = 600
	Troops =
	[
		{
			Weight = 60,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadCutthroat,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadOutlaw,
					Cost = 18
				}
			]
		},
		{
			Weight = 12,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadSlinger,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.NomadArcher,
					MinR = 120,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.DesertStalker, //looks like M.Archer
					MinR = 420,
					Cost = 45,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			MinR = 140,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.NomadLeader,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			MinR = 365,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.Executioner,
					Cost = 55,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			MinR = 420,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.DesertDevil,
					Cost = 50,
					Roll = true
				}
			]
		}
	]
};
