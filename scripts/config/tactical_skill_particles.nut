local gt = this.getroottable();

if (!("Tactical" in gt.Const))
{
	gt.Const.Tactical <- {};
}

gt.Const.Tactical.GruesomeFeastParticles <- [
	{
		Delay = 0,
		Quantity = 120,
		LifeTimeQuantity = 120,
		SpawnRate = 100,
		Brushes = [
			"blood_red_01",
			"blood_red_02",
			"blood_red_03",
			"blood_red_04",
			"blood_red_05",
			"blood_red_06",
			"blood_red_07"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 110,
				VelocityMax = 220,
				DirectionMin = this.createVec(-0.5, 0.600000024),
				DirectionMax = this.createVec(0.5, 1.20000005),
				SpawnOffsetMin = this.createVec(-30, 5),
				SpawnOffsetMax = this.createVec(-20, 10)
			},
			{
				LifeTimeMin = 1.39999998,
				LifeTimeMax = 1.39999998,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 140,
				ForceMin = this.createVec(0, -100),
				ForceMax = this.createVec(0, -100)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 100,
				ForceMin = this.createVec(0, -160),
				ForceMax = this.createVec(0, -160)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 160,
		LifeTimeQuantity = 160,
		SpawnRate = 100,
		Brushes = [
			"blood_splatter_red_01",
			"blood_splatter_red_02",
			"blood_splatter_red_03",
			"blood_splatter_red_04",
			"blood_splatter_red_05",
			"blood_splatter_red_06",
			"blood_splatter_red_07",
			"blood_splatter_red_08",
			"blood_splatter_red_09"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 150,
				VelocityMax = 300,
				DirectionMin = this.createVec(-0.200000003, 0.300000012),
				DirectionMax = this.createVec(0.0, 0.699999988),
				SpawnOffsetMin = this.createVec(-50, 15),
				SpawnOffsetMax = this.createVec(-20, 30)
			},
			{
				LifeTimeMin = 1.5,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 100,
				VelocityMax = 200,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.200000003,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 100,
				VelocityMax = 200,
				ForceMin = this.createVec(0, -160),
				ForceMax = this.createVec(0, -160)
			}
		]
	}
];
gt.Const.Tactical.KrakenDevourParticles <- [
	{
		Delay = 0,
		Quantity = 200,
		LifeTimeQuantity = 200,
		SpawnRate = 180,
		Brushes = [
			"blood_red_01",
			"blood_red_02",
			"blood_red_03",
			"blood_red_04",
			"blood_red_05",
			"blood_red_06",
			"blood_red_07"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 110,
				VelocityMax = 220,
				DirectionMin = this.createVec(-0.5, 0.600000024),
				DirectionMax = this.createVec(0.5, 1.20000005),
				SpawnOffsetMin = this.createVec(-30, 5),
				SpawnOffsetMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 1.39999998,
				LifeTimeMax = 1.39999998,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 140,
				ForceMin = this.createVec(0, -100),
				ForceMax = this.createVec(0, -100)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 100,
				ForceMin = this.createVec(0, -160),
				ForceMax = this.createVec(0, -160)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 320,
		LifeTimeQuantity = 320,
		SpawnRate = 160,
		Brushes = [
			"blood_splatter_red_01",
			"blood_splatter_red_02",
			"blood_splatter_red_03",
			"blood_splatter_red_04",
			"blood_splatter_red_05",
			"blood_splatter_red_06",
			"blood_splatter_red_07",
			"blood_splatter_red_08",
			"blood_splatter_red_09"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 150,
				VelocityMax = 300,
				DirectionMin = this.createVec(-0.200000003, 0.300000012),
				DirectionMax = this.createVec(0.0, 0.699999988),
				SpawnOffsetMin = this.createVec(-50, 15),
				SpawnOffsetMax = this.createVec(10, 30)
			},
			{
				LifeTimeMin = 1.5,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 100,
				VelocityMax = 200,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.200000003,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 100,
				VelocityMax = 200,
				ForceMin = this.createVec(0, -160),
				ForceMax = this.createVec(0, -160)
			}
		]
	}
];
gt.Const.Tactical.KrakenDevourVictimParticles <- [
	{
		Delay = 0,
		Quantity = 60,
		LifeTimeQuantity = 60,
		SpawnRate = 50,
		Brushes = [
			"blood_red_01",
			"blood_red_02",
			"blood_red_03",
			"blood_red_04",
			"blood_red_05",
			"blood_red_06",
			"blood_red_07"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 110,
				VelocityMax = 220,
				DirectionMin = this.createVec(-0.5, 0.600000024),
				DirectionMax = this.createVec(0.5, 1.20000005),
				SpawnOffsetMin = this.createVec(-20, 5),
				SpawnOffsetMax = this.createVec(20, 10)
			},
			{
				LifeTimeMin = 1.39999998,
				LifeTimeMax = 1.39999998,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 140,
				ForceMin = this.createVec(0, -100),
				ForceMax = this.createVec(0, -100)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 70,
				VelocityMax = 100,
				ForceMin = this.createVec(0, -160),
				ForceMax = this.createVec(0, -160)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 80,
		LifeTimeQuantity = 80,
		SpawnRate = 60,
		Brushes = [
			"blood_splatter_red_01",
			"blood_splatter_red_02",
			"blood_splatter_red_03",
			"blood_splatter_red_04",
			"blood_splatter_red_05",
			"blood_splatter_red_06",
			"blood_splatter_red_07",
			"blood_splatter_red_08",
			"blood_splatter_red_09"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 150,
				VelocityMax = 300,
				DirectionMin = this.createVec(-0.200000003, 0.300000012),
				DirectionMax = this.createVec(0.0, 0.699999988),
				SpawnOffsetMin = this.createVec(-20, 15),
				SpawnOffsetMax = this.createVec(20, 30)
			},
			{
				LifeTimeMin = 1.5,
				LifeTimeMax = 1.5,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 100,
				VelocityMax = 200,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.200000003,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 100,
				VelocityMax = 200,
				ForceMin = this.createVec(0, -160),
				ForceMax = this.createVec(0, -160)
			}
		]
	}
];
gt.Const.Tactical.DarkflightStartParticles <- [
	{
		Delay = 0,
		Quantity = 140,
		LifeTimeQuantity = 140,
		SpawnRate = 300,
		Brushes = [
			"effect_bat_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.300000012,
				LifeTimeMax = 0.400000006,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = -20,
				RotationMax = 20,
				VelocityMin = 70,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.5, -0.200000003),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-25, -30),
				SpawnOffsetMax = this.createVec(25, 30)
			},
			{
				LifeTimeMin = 0.300000012,
				LifeTimeMax = 0.600000024,
				ColorMin = this.createColor("ffffffbf"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = -20,
				RotationMax = 20,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(50, 70),
				ForceMax = this.createVec(100, 100)
			},
			{
				LifeTimeMin = 0.300000012,
				LifeTimeMax = 0.600000024,
				ColorMin = this.createColor("ffffffbf"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = -20,
				RotationMax = 20,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(-100, 70),
				ForceMax = this.createVec(-150, 100)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.200000003,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = -20,
				RotationMax = 20,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(50, 80)
			}
		]
	}
];
gt.Const.Tactical.DarkflightEndParticles <- [
	{
		Delay = 0,
		Quantity = 140,
		LifeTimeQuantity = 140,
		SpawnRate = 300,
		Brushes = [
			"effect_bat_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 160,
				RotationMax = 170,
				VelocityMin = 70,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.5, -0.800000012),
				DirectionMax = this.createVec(0.5, -0.5),
				SpawnOffsetMin = this.createVec(-25, 60),
				SpawnOffsetMax = this.createVec(25, 120)
			},
			{
				LifeTimeMin = 0.300000012,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ffffffbf"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 160,
				RotationMax = 170,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(50, -90),
				ForceMax = this.createVec(100, -150)
			},
			{
				LifeTimeMin = 0.300000012,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ffffffbf"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 160,
				RotationMax = 170,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(-100, -80),
				ForceMax = this.createVec(-150, -140)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 160,
				RotationMax = 170,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, -50),
				ForceMax = this.createVec(50, -80)
			}
		]
	}
];
gt.Const.Tactical.RaiseUndeadParticles <- [
	{
		Delay = 0,
		Quantity = 200,
		LifeTimeQuantity = 200,
		SpawnRate = 200,
		Brushes = [
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("031c0200"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, 0.5),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-50, -30),
				SpawnOffsetMax = this.createVec(50, 20),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.699999988,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("000000ff"),
				ColorMax = this.createColor("031c02ff"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.400000006, 0.600000024),
				DirectionMax = this.createVec(0.400000006, 0.600000024),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.200000003,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("031c0200"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 20,
		LifeTimeQuantity = 20,
		SpawnRate = 20,
		Brushes = [
			"effect_skull_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("031c0200"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, 0.5),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-50, -40),
				SpawnOffsetMax = this.createVec(50, 10),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.699999988,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("0000007f"),
				ColorMax = this.createColor("031c027f"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.400000006, 0.600000024),
				DirectionMax = this.createVec(0.400000006, 0.600000024),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.200000003,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("031c0200"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			}
		]
	}
];
gt.Const.Tactical.RaiseFromGroundParticles <- [
	{
		Delay = 200,
		Quantity = 140,
		LifeTimeQuantity = 140,
		SpawnRate = 120,
		Brushes = [
			"dust_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 40,
				VelocityMax = 60,
				DirectionMin = this.createVec(-0.699999988, 0.200000003),
				DirectionMax = this.createVec(0.699999988, 0.200000003),
				SpawnOffsetMin = this.createVec(-45, -45),
				SpawnOffsetMax = this.createVec(45, 5)
			},
			{
				LifeTimeMin = 1.5,
				LifeTimeMax = 2.5,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 40,
				VelocityMax = 60,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.100000001,
				LifeTimeMax = 0.100000001,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 20,
				VelocityMax = 40,
				ForceMin = this.createVec(0, -20),
				ForceMax = this.createVec(0, -20)
			}
		]
	}
];
gt.Const.Tactical.MiasmaParticles <- [
	{
		Delay = 0,
		Quantity = 100,
		LifeTimeQuantity = 0,
		SpawnRate = 18,
		Brushes = [
			"miasma_effect_02",
			"miasma_effect_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.75,
				LifeTimeMax = 1.25,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, 0.5),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-50, -40),
				SpawnOffsetMax = this.createVec(50, 20),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 4.0,
				LifeTimeMax = 6.0,
				ColorMin = this.createColor("9d82172d"),
				ColorMax = this.createColor("f5e6aa2d"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.400000006, 0.600000024),
				DirectionMax = this.createVec(0.400000006, 0.600000024),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			}
		]
	},
	{
		Delay = 0,
		Quantity = 10,
		LifeTimeQuantity = 0,
		SpawnRate = 4,
		Brushes = [
			"effect_skull_01",
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, 0.5),
				DirectionMax = this.createVec(0.5, 0.5),
				SpawnOffsetMin = this.createVec(-50, -40),
				SpawnOffsetMax = this.createVec(50, 10),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 4.0,
				LifeTimeMax = 6.0,
				ColorMin = this.createColor("9d82174f"),
				ColorMax = this.createColor("f5e6aa4f"),
				ScaleMin = 1.0,
				ScaleMax = 1.25,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.400000006, 0.600000024),
				DirectionMax = this.createVec(0.400000006, 0.600000024),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("9d821700"),
				ColorMax = this.createColor("f5e6aa00"),
				ScaleMin = 1.0,
				ScaleMax = 1.25,
				VelocityMin = 10,
				VelocityMax = 30,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			}
		]
	}
];
gt.Const.Tactical.ShadowParticles <- [
	{
		Delay = 0,
		Quantity = 50,
		LifeTimeQuantity = 0,
		SpawnRate = 10,
		Brushes = [
			"effect_lightning_01",
			"effect_lightning_02",
			"effect_lightning_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.75,
				LifeTimeMax = 1.25,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("00000000"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.5, -0.5),
				DirectionMax = this.createVec(0.5, -0.5),
				SpawnOffsetMin = this.createVec(-50, 0),
				SpawnOffsetMax = this.createVec(50, 40),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 4.0,
				LifeTimeMax = 6.0,
				ColorMin = this.createColor("0000002d"),
				ColorMax = this.createColor("0000002d"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.400000006, -0.600000024),
				DirectionMax = this.createVec(0.400000006, -0.600000024),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("00000000"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				VelocityMin = 10,
				VelocityMax = 30,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			}
		]
	},
	{
		Delay = 0,
		Quantity = 50,
		LifeTimeQuantity = 0,
		SpawnRate = 8,
		Brushes = [
			"miasma_effect_02",
			"miasma_effect_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.75,
				LifeTimeMax = 1.25,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("00000000"),
				ScaleMin = 0.5,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -10,
				TorqueMax = 10,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.25, -0.25),
				DirectionMax = this.createVec(0.25, -0.25),
				SpawnOffsetMin = this.createVec(-50, 0),
				SpawnOffsetMax = this.createVec(50, 40),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 4.0,
				LifeTimeMax = 6.0,
				ColorMin = this.createColor("00000030"),
				ColorMax = this.createColor("00000030"),
				ScaleMin = 0.75,
				ScaleMax = 1.25,
				VelocityMin = 10,
				VelocityMax = 30,
				DirectionMin = this.createVec(-0.200000003, -0.300000012),
				DirectionMax = this.createVec(0.200000003, -0.300000012),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			},
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("00000000"),
				ColorMax = this.createColor("00000000"),
				ScaleMin = 0.75,
				ScaleMax = 1.25,
				VelocityMin = 10,
				VelocityMax = 30,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10),
				FlickerEffect = false
			}
		]
	}
];
