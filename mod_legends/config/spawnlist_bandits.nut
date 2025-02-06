::Const.World.Spawn.BanditArmy <- //legend_bandit_army_contract only!!
{
	Name = "BanditArmy",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_bandit_01",
	MinR = 145,
	MaxR = 600,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BanditWarlord,
			Weight = 100, //100 Weight guarentees this will be added
			Cost = 1, //dictates cost taken from minR
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader, //no. 1
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditLeader, //no. 2
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.LegendPeasantMonk, //stops morale shenanigans
			Weight = 75,
			Cost = 2,
			//Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditVeteran,
			Weight = 100,
			Cost = 1,
			Roll = true
		},
		{
			Type = this.Const.World.Spawn.Troops.BanditMarksman,
			Weight = 45,
			Cost = 2,
			//Roll = true
		}
	],
	Troops =
	[
		{
			Weight = 65,
			Types = [
				// {
				// 	Type = this.Const.World.Spawn.Troops.BanditThug,
				// 	Cost = 8
				// },
				{
					Type = this.Const.World.Spawn.Troops.BanditRaiderLOW,
					Cost = 16
				},
				{
					//MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					MinR = 320,
					Cost = 20
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.BanditVeteran,
					Cost = 30
				}
			]
		},
		{
			Weight = 20,
			Types =
			[
				// {
				// 	Type = this.Const.World.Spawn.Troops.BanditMarksmanLOW,
				// 	Cost = 8
				// },
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.MasterArcher,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Wardog,
					Cost = 5
				}
			]
		},
		{
			Weight = 5,
			Types =
			[
				{
					Type = this.Const.World.Spawn.Troops.BanditLeader,
					Cost = 25,
					Roll = true
				},
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.HedgeKnight,
					Cost = 50,
					Roll = true
				}
			]
		},
		{
			Weight = 2,
			Types =
			[
				{
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.Swordmaster,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
}

::Const.World.Spawn.BanditVermes <- //unused
{
	Name = "BanditsVermes",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_werewolf_01",
	Fixed = [],
	//MinR = 75,
	MaxR = 475,
	Troops =
	[
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditVermes,
					Cost = 7
				}
			]
		}
	]
}
