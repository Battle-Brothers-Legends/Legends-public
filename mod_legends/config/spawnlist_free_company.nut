::Const.World.Spawn.FreeCompany <-
{
	Name = "FreeCompany",
	IsDynamic = true,
	MovementSpeedMult = 0.95,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 690,
	MinR = 97,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.FreeCompanyLeader,
			Cost = 30,
			Weight = 0, //0 Weight guarentees this will be added
		}
	],
	Troops = [ //weights dont add up to 100 but it doesn't really matter : total weight is of 120
		{
			Weight = 60, //frontline shielded units
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySpearmanLow,
					MaxR = 250,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySpearman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySlayer,
					MinR = 250,
					Cost = 22
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyFootman,
					MinR = 250,
					Cost = 22
				}
			]
		},
		{
			Weight = 10, //just the dog
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 20, //backline archers
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyArcherLow,
					MaxR = 250,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyArcher,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyCrossbow,
					MinR = 250,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyLongbow,
					MinR = 300,
					Cost = 25
				}
			]
		},
		{
			Weight = 20, //backline 2tile range
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyBillman,
					MinR = 200,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyPikeman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10, //frontline 2handers
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyInfantry,
					MinR = 250,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyLeader,
					MinR = 250,
					Cost = 30
				}
			]
		}
	]
}
::Const.World.Spawn.FreeCompanyLow <-
{
	Name = "FreeCompanyLow",
	IsDynamic = true,
	MovementSpeedMult = 0.90,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_03",
	MaxR = 225,
	MinR = 97,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.FreeCompanyLeaderLow,
			Cost = 30,
			Weight = 0, //0 Weight guarentees this will be added
		}
	],
	Troops = [ //weights dont add up to 100 but it doesn't really matter : total weight is of 120
		{
			Weight = 60, //frontline shielded units
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySpearmanLow,
					MaxR = 250,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySpearman,
					Cost = 15
				}
			]
		},
		{
			Weight = 10, //just the dog
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 20, //backline archers
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyArcherLow,
					MaxR = 250,
					Cost = 10
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyArcher,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyCrossbow,
					MinR = 250,
					Cost = 15
				}
			]
		},
		{
			Weight = 20, //backline 2tile range
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyPikeman,
					MinR = 200,
					Cost = 20
				}
			]
		}
	]
}

::Const.World.Spawn.GildedCompany <-
{
	Name = "GildedCompany",
	IsDynamic = true,
	MovementSpeedMult = 0.95,
	VisibilityMult = 1,
	VisionMult = 1,
	Body = "figure_bandit_03",
	MaxR = 690,
	MinR = 97,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.FreeCompanyLeader,
			Cost = 30,
			Weight = 0, //0 Weight guarentees this will be added
		}
	],
	Troops = [ //weights dont add up to 100 but it doesn't really matter : total weight is of 120
		{
			Weight = 60, //frontline shielded units
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySpearman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanySlayer,
					Cost = 22
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyFootman,
					Cost = 22
				}
			]
		},
		{
			Weight = 10, //just the dog
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 20, //backline archers
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyArcher,
					Cost = 15
				}
				,
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyCrossbow,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyLongbow,
					Cost = 25
				}
			]
		},
		{
			Weight = 20, //backline 2tile range
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyBillman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyPikeman,
					Cost = 20
				}
			]
		},
		{
			Weight = 10, //frontline 2handers
			Types =[
				{
					Type = this.Const.World.Spawn.Troops.FreeCompanyInfantry,
					Cost = 25
				}
			]
		}
	]
}
