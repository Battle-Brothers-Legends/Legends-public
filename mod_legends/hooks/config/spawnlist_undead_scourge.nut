if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.UndeadScourge <-
{
	Name = "UndeadScourge",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skeleton_01",
	MaxR = 1214,
	MinR = 76,
	Troops = [
		{
			Weight = 25,
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
					MinR = 400
					Type = this.Const.World.Spawn.Troops.SkeletonHeavy,
					Cost = 35
				}
			]
		},
		{
			MinR = 250,
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.SkeletonMediumPolearm,
					Cost = 25
				},
				{
					MinR = 400
					Type = this.Const.World.Spawn.Troops.SkeletonHeavyPolearm,
					Cost = 35
				}
			]
		},
		{
			Weight = 5,
			MinR = 600,
			Types = [
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
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					Cost = 12
				},
				{
					MinR = 400,
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					Cost = 25
				}
			]
		},
		{
			Weight = 5
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
					MinR = 600,
					Type = this.Const.World.Spawn.Troops.LegendVampireLord,
					Cost = 70,
					Roll = true
				}
			]
		},
		{
			Weight = 5
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				},
				{
					MinR = 350,
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		},
		{
			Weight = 5
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyLight,
					Cost = 23
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyMedium,
					MinR = 200,
					Cost = 30
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendMummyHeavy,
					MinR = 600,
					Cost = 45
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Necromancer,
					Cost = 30,
					Roll = true,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
							Cost = 12,
							function Weight(scale) {
								local c = 100 - (scale * 100);
								return this.Math.max(0, c);
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
							Cost = 25,
							function Weight(scale) {
								local c = 100 - ((1.0 - scale) * 100);
								return this.Math.min(100, c);
							}
						}
					]
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				}
			]
		},
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
