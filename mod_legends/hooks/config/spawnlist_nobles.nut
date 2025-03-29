::Const.World.Spawn.Noble = 
{
	Name = "Noble",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_noble_01",
	MinR = 75,
	MaxR = 555,
	Fixed = [
		{
			Weight = 100 //percentage chance after min count is met
			Type = this.Const.World.Spawn.Troops.StandardBearer,
			Cost = 20
		}
	],
	Troops = [
		{
			Weight = 45,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.NobleEliteFootman,
					Cost = 25
				}
			]
		},
		{
			Weight = 25,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.NoblePollax,
					Cost = 40
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 25
				},
				{
					Type = this.Const.World.Spawn.Troops.NobleSureshot,
					Cost = 50
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 30
				}
			]
		},
		{
			Weight = 3,
			MinR = 0.5 * 270,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 3,
			MinR = 0.5 * 360,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Knight,
					Cost = 80,
					Roll = true
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.ArmoredWardog,
					Cost = 8
				}
			]
		},
		{
			Weight = 3,
			MinR = 0.5 * 180,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendNobleGuard,
					Cost = 60
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.5 * 270,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 60
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.5 * 270,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 70
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 360,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 80
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 440,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendManAtArms,
					Cost = 100
				}
			]
		}
	]
};

::Const.World.Spawn.NobleCaravan = 
{
	Name = "NobleCaravan",
	IsDynamic = true,
	MovementSpeedMult = 0.5,
	VisibilityMult = 1.0,
	VisionMult = 0.25,
	Body = "cart_01",
	MinR = 110,
	MaxR = 365,
	Fixed = [
		{
			MinCount = 1,
			MaxCount = 3,
			Weight = 30 //percentage chance after min count is met
			Type = this.Const.World.Spawn.Troops.CaravanDonkey,
			Cost = 0
		}
	],
	Troops = [
		{
			Weight = 62,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Footman,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.NobleEliteFootman,
					Cost = 30
				}
			]
		},
		{
			Weight = 17,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Billman,
					Cost = 15
				},
				{
					Type = this.Const.World.Spawn.Troops.NoblePollax,
					Cost = 40
				}
			]
		},
		{
			Weight = 15,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Arbalester,
					Cost = 20
				},
				{
					Type = this.Const.World.Spawn.Troops.NobleSureshot,
					Cost = 50
				}
			]
		},
		{
			Weight = 2,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Greatsword,
					Cost = 25
				}
			]
		},
		{
			Weight = 2,
			MinR = 0.6 * 300,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.Sergeant,
					Cost = 40,
					Roll = true
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendHalberdier,
					Cost = 60
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendFencer,
					Cost = 80
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 365,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendSlinger,
					Cost = 80
				}
			]
		},
		{
			Weight = 1,
			MinR = 0.5 * 500,
			Types = [
				{
					Type = this.Const.World.Spawn.Troops.LegendManAtArms,
					Cost = 100
				}
			]
		}
	]
};
