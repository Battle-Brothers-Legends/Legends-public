if (!("World" in ::Const))
{
	::Const.World <- {};
}

if (!("Spawn" in ::Const.World))
{
	::Const.World.Spawn <- {};
}

::Const.World.Spawn.Zombies =
{
	Name = "Zombies",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 521,
	MinR = 35,
	Troops = [
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		},
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 40
				}
			]
		}
	]
};

::Const.World.Spawn.ZombiesLight =
{
	Name = "ZombiesLight",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 124,
	MinR = 36,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		}
	]
};

::Const.World.Spawn.ZombiesAndGhouls =
{
	Name = "ZombiesAndGhouls",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 441,
	MinR = 54,
	Troops = [
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		},
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					MinR = 200,
					Cost = 19
				}
			]
		}
	]
};

::Const.World.Spawn.ZombiesOrZombiesAndGhouls =
{
	Name = "ZombiesOrZombiesAndGhouls",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 441,
	MinR = 54,
	Troops = [
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		},
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					MinR = 200,
					Cost = 19
				}
			]
		}
	]
};

::Const.World.Spawn.ZombiesAndGhosts =
{
	Name = "ZombiesAndGhosts",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 441,
	MinR = 54,
	Troops = [
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		},
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 30
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			MinR = 800,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		}
	]
};

::Const.World.Spawn.ZombiesOrZombiesAndGhosts =
{
	Name = "ZombiesOrZombiesAndGhosts",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 441,
	MinR = 54,
	Troops = [
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		},
		{
			Weight = 60,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 5,
			MinR = 800,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		}
	]
};

::Const.World.Spawn.Ghosts =
{
	Name = "Ghosts",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 460,
	MinR = 80,
	Troops = [
		{
			Weight = 80,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			MinR = 800,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		}
	]
};

::Const.World.Spawn.Necromancer =
{
	Name = "Necromancer",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_01",
	MaxR = 706,
	MinR = 102,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.Necromancer,
			Cost = 30,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 25,
			Weight = 0,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieBodyguard,
					MaxR = 200,
					Cost = 6,
					function Weight(scale) {
						local c = 100 - (scale * 100);
						return this.Math.max(0, c);
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeomanBodyguard,
					MinR = 200,
					Cost = 12,
					function Weight(scale) {
						local c = 100 - (scale * 100);
						return this.Math.max(0, c);
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
					MinR = 400,
					Cost = 25,
					function Weight(scale) {
						local c = 100 - ((1.0 - scale) * 100);
						return this.Math.min(100, c);
					}
				}
			]
		}
	],
	Troops = [
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Zombie,
					Cost = 5
				}
			]
		},
		{
			Weight = 65,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					MinR = 200,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Necromancer,
					Cost = 30,
					Roll = true
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
			Weight = 4,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Ghost,
					Cost = 20
				}
			]
		},
		{
			Weight = 4,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonHound,
					MinR = 400,
					Cost = 40
				}
			]
		},
		{
			Weight = 2,
			MinR = 800,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendBanshee,
					Cost = 70
				}
			]
		}
	]
};


::Const.World.Spawn.NecromancerSouthern =
{
	Name = "NecromancerSouthern",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 1.0,
	VisionMult = 0.8,
	Body = "figure_zombie_04",
	MaxR = 706,
	MinR = 102,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.Necromancer,
			Cost = 30,
			MinGuards = 1,
			MaxGuards = 2,
			MaxGuardsWeight = 25,
			Weight = 0,
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
					MinR = 200,
					Cost = 6,
					function Weight(scale) {
						local c = 100 - (scale * 100);
						return this.Math.max(0, c);
					}
				},
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
					MinR = 400,
					Cost = 24,
					function Weight(scale) {
						local c = 100 - ((1.0 - scale) * 100);
						return this.Math.min(100, c);
					}
				}
			]
		}
	],
	Troops = [
		{
			Weight = 30,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieNomad,
					Cost = 10
				}
			]
		},
		{
			Weight = 45,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieYeoman,
					Cost = 10
				}
			]
		},
		{
			Weight = 14,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
					MinR = 250,
					Cost = 20
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ZombieKnight,
					MinR = 400,
					Cost = 30
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Necromancer,
					Cost = 30,
					Roll = true
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.ZombieNomadBodyguard,
							Cost = 6,
							function Weight(scale) {
								local c = 100 - (scale * 100);
								return this.Math.max(0, c);
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.ZombieKnightBodyguard,
							Cost = 24,
							function Weight(scale) {
								local c = 100 - ((1.0 - scale) * 100);
								return this.Math.min(100, c);
							}
						}
					]
				}
			]
		}
	]
};
