if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.Mummies <-
{
	Name = "Mummies",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_mummy_01",
	MaxR = 521,
	MinR = 108,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyLight,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyMedium,
					MinR = 200,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyHeavy,
					MinR = 500,
					Cost = 40
				}
			]
		},
		{
			Weight = 30,
			Types = [
				// {
				// 	Type = this.Const.World.Spawn.Troops.VampireLOW,
				// 	Cost = 30
				// },
				// {
				// 	Type = this.Const.World.Spawn.Troops.Vampire,
				// 	MinR = 400,
				// 	Cost = 40
				// },
				{
					MinR = 650,
					Type = this.Const.World.Spawn.Troops.LegendMummyQueen,
					Cost = 70,
					Roll = true
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyPriest,
					Cost = 40,
					Roll = true
				}
			]
		}
	]
};

::Const.World.Spawn.MummiesPatrol <-
{
	Name = "Mummies",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_mummy_01",
	MaxR = 650,
	MinR = 100,
	Troops = [
		{
			Weight = 85,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyLight,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyMedium,
					MinR = 200,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyHeavy,
					MinR = 500,
					Cost = 40
				}
			]
		},{
			Weight = 15,
			Types = [
				// {
				// 	Type = this.Const.World.Spawn.Troops.VampireLOW,
				// 	Cost = 30
				// },
				// {
				// 	Type = this.Const.World.Spawn.Troops.Vampire,
				// 	MinR = 400,
				// 	Cost = 40
				// },
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyPriest,
					Cost = 40,
					Roll = true
				}
			]
		}
		// ,
		// {
		// 	Weight = 22,
		// 	Types = [
		// 		{
		// 			Type = this.Const.World.Spawn.Troops.VampireLOW,
		// 			Cost = 30
		// 		},
		// 		{
		// 			Type = this.Const.World.Spawn.Troops.Vampire,
		// 			MinR = 400,
		// 			Cost = 40
		// 		}
		// 	]
		// },
		// {
		// 	Weight = 3,
		// 	MinR = 650,
		// 	Types = [
		// 		{
		// 			Type = this.Const.World.Spawn.Troops.LegendVampireLord,
		// 			Cost = 70,
		// 			Roll = true
		// 		}
		// 	]
		// }
	]
};