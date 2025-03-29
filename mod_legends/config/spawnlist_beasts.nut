::Const.World.Spawn.LegendHexeLeader <-
{
	Name = "LegendHexeLeader",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_hexe_01",
	MinR = 100,
	MaxR = 500,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendHexeLeader,
			Cost = 300,
			MinGuards = 2,
			MaxGuards = 3,
			MaxGuardsWeight = 50,
			Weight = 0, // 0 guarentees this will be added
			Guards = [
				{
					Type = this.Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
					Cost = 250,
					function Weight(scale) {
						return 50;
					}
				}
			]
		}
	],
	Troops = [
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Direwolf,
					Cost = 21
				},
				{
					Type = this.Const.World.Spawn.Troops.DirewolfHIGH,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolf,
					Cost = 400
				},
				{
					Type = this.Const.World.Spawn.Troops.Hyena,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.HyenaHIGH,
					MinR = 400,
					Cost = 20
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Spider,
					Cost = 12
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendRedbackSpider,
					Cost = 250
				},
				{
					Type = this.Const.World.Spawn.Troops.Serpent,
					Cost = 25
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.BanditMarksman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.BanditRaider,
					Cost = 20
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.GhoulLOW,
					Cost = 9
				},
				{
					Type = this.Const.World.Spawn.Troops.Ghoul,
					Cost = 19
				},
				{
					Type = this.Const.World.Spawn.Troops.GhoulHIGH,
					Cost = 35,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.OrcYoungLOW,
					Cost = 35
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcYoung,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcWarriorLOW,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.OrcWarrior,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendOrcElite,
					Cost = 85
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Unhold,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.UnholdBog,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendRockUnhold,
					Cost = 400
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Schrat,
					Cost = 70
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendGreenwoodSchrat,
					Cost = 400
				},
				{
					Type = this.Const.World.Spawn.Troops.SandGolem,
					Cost = 18
				},
				{
					Type = this.Const.World.Spawn.Troops.SandGolemMEDIUM,
					MinR = 200,
					Cost = 40
				}
			]
		},
		{
			Weight = 20,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Hexe,
					Cost = 50,
					MinGuards = 1,
					MaxGuards = 2,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.DirewolfBodyguard,
							Cost = 20,
							function Weight(scale) {
								return 50;
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.SpiderBodyguard,
							Cost = 20,
							function Weight(scale) {
								return 50;
							}
						}
					]
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendHexeLeader,
					MinR = 650,
					Cost = 300,
					MinGuards = 2,
					MaxGuards = 3,
					MaxGuardsWeight = 50,
					Guards = [
						{
							Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolfBodyguard,
							Cost = 400,
							function Weight(scale) {
								return 50;
							}
						},
						{
							Type = this.Const.World.Spawn.Troops.LegendRedbackSpiderBodyguard,
							Cost = 250,
							function Weight(scale) {
								return 50;
							}
						}
					]
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
::Const.World.Spawn.LegendRockUnhold <-
{
	Name = "LegendRockUnhold",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_rock_unhold_01",
	MaxR = 1000,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendRockUnhold,
			Cost = 180,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendRockUnhold,
					Cost = 300
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Unhold,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.UnholdBog,
					Cost = 60
				},
				{
					Type = this.Const.World.Spawn.Troops.UnholdFrost,
					Cost = 60
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
::Const.World.Spawn.LegendSkinGhouls <-
{
	Name = "LegendSkinGhouls",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_skin_ghoul_01", //also has 02 model - not in use but could be for harder groups.
	MaxR = 1000,
	Troops = [
		{
			Weight = 90,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSkinGhoulLOW,
					Cost = 50
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendSkinGhoulMED,
					Cost = 100
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSkinGhoulHIGH,
					Cost = 200,
					Roll = true
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
::Const.World.Spawn.LegendWhiteDirewolf <-
{
	Name = "LegendWhiteDirewolf",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_white_direwolf_01",
	MaxR = 1000, //this may need to be changed i have no idea if this is good or not
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolf,
			Cost = 150,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 90
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendWhiteDirewolf,
					Cost = 400
				}
			]
		},
		{
			Weight = 10
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Direwolf,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.DirewolfHIGH,
					Cost = 25
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
::Const.World.Spawn.LegendRedbackSpider <-
{
	Name = "LegendRedbackSpider",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_redback_spider_01",
	MaxR = 500,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendRedbackSpider,
			Cost = 250,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 90
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendRedbackSpider,
					Cost = 250
				}
			]
		},
		{
			Weight = 10
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Spider,
					Cost = 12
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
//May want to be kept non-changed too
//Probably won't add these to the beast_roamers_action.nut
::Const.World.Spawn.LegendDemonAlp <-
{
	Name = "LegendDemonAlp",
	IsDynamic = true,
	MovementSpeedMult = 1.1,
	VisibilityMult = 0.7,
	VisionMult = 1.3,
	Body = "figure_demonalp_01",
	MaxR = 1000,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendDemonAlp,
			Cost = 105,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 88
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Alp,
					Cost = 30
				}
			]
		},
		{
			Weight = 12
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendDemonAlp,
					Cost = 105
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
::Const.World.Spawn.LegendStollwurm <-
{
	Name = "LegendStollwurm",
	IsDynamic = true,
	MovementSpeedMult = 0.9,
	VisibilityMult = 1.0,
	VisionMult = 1.1,
	Body = "figure_stollwurm_01",
	MaxR = 500,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendStollwurm,
			Cost = 500,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 60
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Lindwurm,
					Cost = 80
				}
			]
		},
		{
			Weight = 40
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendStollwurm,
					Cost = 500
				}
			]
		}
	]
}

//May need MinR && Legend Beast Cost Change
::Const.World.Spawn.LegendGreenwoodSchrat <-
{
	Name = "LegendGreenwoodSchrat",
	IsDynamic = true,
	MovementSpeedMult = 0.8,
	VisibilityMult = 0.9,
	VisionMult = 1.2,
	Body = "figure_greenwood_schrat_01",
	MaxR = 500,
	Fixed = [
		{
			Type = this.Const.World.Spawn.Troops.LegendGreenwoodSchrat,
			Cost = 350,
			Weight = 0
		}
	],
	Troops = [
		{
			Weight = 60
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Schrat,
					Cost = 70
				}
			]
		},
		{
			Weight = 40
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendGreenwoodSchrat,
					Cost = 350
				}
			]
		}
	]
}

::Const.World.Spawn.LegendBasiliskLOW <-
{
	Name = "Basilisks",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_basilisk_01",
	MaxR = 560,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendBasiliskDroneLow,
					Cost = 28
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendBasiliskDrone,
					Cost = 40
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendBasiliskSentry,
					MinR = 200,
					Cost = 50
				}
			]
		}
	]
}

::Const.World.Spawn.LegendBasiliskMED <-
{
	Name = "Basilisks",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_basilisk_01",
	MaxR = 560,
	Troops = [
		{
			Weight = 100,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendBasiliskDrone,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.LegendBasiliskSentry,
					MinR = 200,
					Cost = 40
				}
			]
		}
	]
}
