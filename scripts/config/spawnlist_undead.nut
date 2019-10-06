local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.UndeadArmy <-
{
	Name = "UndeadArmy",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skeleton_01",
	MaxR = 625,
	MinR = 52,
	Troops = [
		{
			Weight = 50,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonLight,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					MinR = 0.60 * 625,
					Cost = 35
				}
			]
		},
		{
			Weight = 35,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					MinR = 0.60 * 625,
					Cost = 35
				}
			]
		},
		{
			Weight = 3,
			MinR = 0.75 * 625,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonPriest,
					Cost = 40
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
				}
			]
		},
		{
			Weight = 5
			MinR = 0.20 * 625,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					MinR = 1.0 * 625,
					Cost = 60
				}
			]
		},
		{
			Weight = 5,
			MinR = 0.15 * 625,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					Cost = 20
				}
			]
		}
	]
}

gt.Const.World.Spawn.Vampires <-
{
	Name = "Vampires",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_vampire_02",
	MaxR = 340,
	MinR = 40,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			MinR = 300,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					Cost = 60
				}
			]
		}
	]
}

gt.Const.World.Spawn.VampiresAndSkeletons <-
{
	Name = "VampiresAndSkeletons",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_vampire_01",
	MaxR = 521,
	MinR = 108,
	Troops = [
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonLight,
					Cost = 13
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMedium,
					MinR = 0.5 * 521,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					MinR = 1.0 * 521,
					Cost = 35
				}
			]
		},
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.VampireLOW,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.Vampire,
					Cost = 40
				},
				{
					MinR = 300,
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					Cost = 60
				}
			]
		}
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					Cost = 20
				}
			]
		}
	]
}