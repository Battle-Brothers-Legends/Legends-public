local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Barbarians <-
{
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_01",
	MinR = 48,
	MaxR = 880,
	Fixed = [
		{
			MinR = 150,
			MinCount = 1,
			MaxCount = 2,
			Weight = 70 //percentage chance after min count is met
			Type = this.Const.World.Spawn.Troops.BarbarianDrummer,
			Cost = 20
		}
	],
	Troops = [
		{
			Weight = 80,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BarbarianThrall,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.BarbarianChampion,
					Cost = 35
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Warhound,
					Cost = 10
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BarbarianBeastmaster,
					Cost = 15,
					MaxCount = 2,
					Fixed = [
						{
							Type = this.Const.World.Spawn.Troops.BarbarianUnhold,
							Cost = 50,
							function Weight(scale) {
								local c = 100 - (scale * 100)
								return this.Math.max(20, c);
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.BarbarianUnholdFrost,
							Cost = 70,
							function Weight(scale) {
								local c = 100 - ((1.0 - scale) * 100)
								return this.Math.min(80, c);
							}
						}
					]
				}
			]
		}
	]
}

gt.Const.World.Spawn.BarbarianHunters <-
{
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_03",
	Fixed = [],
	MinR = 56,
	MaxR = 214,
	Troops = [
		{
			Weight = 66,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BarbarianThrall,
					Cost = 12
				}
			]
		},
		{
			Weight = 34,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Warhound,
					Cost = 10
				}
			]
		}
	]
}

gt.Const.World.Spawn.BarbarianKing <-
{
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_06",
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BarbarianChosen,
			Cost = 9999
		}
	],
	Troops = []
}