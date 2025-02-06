::Const.World.Spawn.Barbarians =
{
	Name = "Barbarians",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_01",
	MinR = 48,
	MaxR = 880,
	Fixed = [
		{
			MinR = 300,
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
					Cost = 15
				},
				{
					MinR = 250,
					Type = this.Const.World.Spawn.Troops.BarbarianMarauder,
					Cost = 22
				},
				{
					MinR = 500,
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
			MinR = 650,
			Types = [
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
				}
			]
		}
	]
}

::Const.World.Spawn.BarbarianHunters =
{
	Name = "BarbarianHunters",
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

::Const.World.Spawn.BarbarianKing =
{
	Name = "BarbarianKing",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_wildman_06",
	MaxR = 500,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.BarbarianChosen,
			Weight = 0,
			Cost = 50
		}
	],
	Troops = []
}
