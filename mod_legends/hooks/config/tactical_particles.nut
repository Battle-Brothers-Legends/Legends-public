foreach (particle in ::Const.Tactical.DustParticles)
{
	particle.Quantity = 60;
	particle.LifeTimeQuantity = 60;
	particle.SpawnRate = 1200;
}

// i'm not hooking this
::Const.Tactical.BloodEffects = [
	[],
	[
		{
			Delay = 0,
			Quantity = 20,
			LifeTimeQuantity = 20,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_red_01",
				"blood_splatter_red_02",
				"blood_splatter_red_05",
				"blood_splatter_red_06",
				"blood_splatter_red_07",
				"blood_splatter_red_08",
				"blood_splatter_red_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.001,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 150,
					VelocityMax = 450,
					DirectionMin = this.createVec(-0.1, 0.7),
					DirectionMax = this.createVec(0.1, 0.7),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.7,
					LifeTimeMax = 1.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 20,
			LifeTimeQuantity = 20,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_dark_01",
				"blood_splatter_dark_05",
				"blood_splatter_dark_06",
				"blood_splatter_dark_07",
				"blood_splatter_dark_08",
				"blood_splatter_dark_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.05,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 150,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.2, 0.6),
					DirectionMax = this.createVec(0.2, 0.6),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 3,
			LifeTimeQuantity = 3,
			SpawnRate = 1200,
			Brushes = [
				"blood_splatter_bones_04",
				"blood_splatter_bones_05",
				"blood_splatter_bones_06"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 100,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.7),
					DirectionMax = this.createVec(0.2, 0.7),
					SpawnOffsetMin = this.createVec(-15, -15),
					SpawnOffsetMax = this.createVec(15, 15)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 100,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -175),
					ForceMax = this.createVec(0, -175)
				},
				{
					LifeTimeMin = 0.01,
					LifeTimeMax = 0.03,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[],
	[
		{
			Delay = 0,
			Quantity = 20,
			LifeTimeQuantity = 20,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_green_01",
				"blood_splatter_green_02",
				"blood_splatter_green_05",
				"blood_splatter_green_06",
				"blood_splatter_green_07",
				"blood_splatter_green_08",
				"blood_splatter_green_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 100,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.6),
					DirectionMax = this.createVec(0.2, 0.6),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 3,
			LifeTimeQuantity = 3,
			SpawnRate = 1200,
			Brushes = [
				"blood_splatter_wood_04",
				"blood_splatter_wood_05",
				"blood_splatter_wood_06"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.6,
					ScaleMax = 0.6,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 100,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.7),
					DirectionMax = this.createVec(0.2, 0.7),
					SpawnOffsetMin = this.createVec(-15, -15),
					SpawnOffsetMax = this.createVec(15, 15)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 100,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -175),
					ForceMax = this.createVec(0, -175)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 15,
			LifeTimeQuantity = 15,
			SpawnRate = 400,
			Brushes = [
				"sand_dust_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					SpawnOffsetMin = this.createVec(-35, -15),
					SpawnOffsetMax = this.createVec(35, 20)
				},
				{
					LifeTimeMin = 2.0,
					LifeTimeMax = 3.0,
					ColorMin = this.createColor("eeeeeeee"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -100),
					ForceMax = this.createVec(0, -100)
				}
			]
		}
	]
];

// or this
::Const.Tactical.BloodSplatters = [
	[],
	[
		{
			Delay = 0,
			Quantity = 40,
			LifeTimeQuantity = 40,
			SpawnRate = 160,
			Brushes = [
				"blood_splatter_red_01",
				"blood_splatter_red_02",
				"blood_splatter_red_05",
				"blood_splatter_red_06",
				"blood_splatter_red_07",
				"blood_splatter_red_08",
				"blood_splatter_red_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 100,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.1, 0.69),
					DirectionMax = this.createVec(0.1, 0.69),
					SpawnOffsetMin = this.createVec(10, 0),
					SpawnOffsetMax = this.createVec(10, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.03,
					LifeTimeMax = 0.06,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		},
		{
			Delay = 600,
			Quantity = 30,
			LifeTimeQuantity = 30,
			SpawnRate = 120,
			Brushes = [
				"blood_splatter_red_01",
				"blood_splatter_red_02",
				"blood_splatter_red_05",
				"blood_splatter_red_06",
				"blood_splatter_red_07",
				"blood_splatter_red_08",
				"blood_splatter_red_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.4,
					LifeTimeMax = 0.4,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.03,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 100,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.1, 0.6),
					DirectionMax = this.createVec(0.1, 0.6),
					SpawnOffsetMin = this.createVec(-5, 10),
					SpawnOffsetMax = this.createVec(-5, 10)
				},
				{
					LifeTimeMin = 3.0,
					LifeTimeMax = 4.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.03,
					LifeTimeMax = 0.06,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		},
		{
			Delay = 1200,
			Quantity = 30,
			LifeTimeQuantity = 30,
			SpawnRate = 120,
			Brushes = [
				"blood_splatter_red_01",
				"blood_splatter_red_02",
				"blood_splatter_red_05",
				"blood_splatter_red_06",
				"blood_splatter_red_07",
				"blood_splatter_red_08",
				"blood_splatter_red_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 100,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.1, 0.6),
					DirectionMax = this.createVec(0.1, 0.6),
					SpawnOffsetMin = this.createVec(-20, 20),
					SpawnOffsetMax = this.createVec(-20, 20)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 60,
			LifeTimeQuantity = 60,
			SpawnRate = 240,
			Brushes = [
				"blood_splatter_dark_01",
				"blood_splatter_dark_05",
				"blood_splatter_dark_06",
				"blood_splatter_dark_07",
				"blood_splatter_dark_08",
				"blood_splatter_dark_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 50,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.1, 0.8),
					DirectionMax = this.createVec(0.1, 0.8),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0),
					ForceMin = this.createVec(-20, 0),
					ForceMax = this.createVec(-20, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 1.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.3,
					ScaleMax = 0.6,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(-20, 0),
					ForceMax = this.createVec(-20, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.8,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(-20, -150),
					ForceMax = this.createVec(-20, -150)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 80,
			LifeTimeQuantity = 80,
			SpawnRate = 1200,
			Brushes = [
				"dust_01",
				"dust_02"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					SpawnOffsetMin = this.createVec(-20, -20),
					SpawnOffsetMax = this.createVec(20, 20)
				},
				{
					LifeTimeMin = 2.0,
					LifeTimeMax = 3.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -100),
					ForceMax = this.createVec(0, -100)
				}
			]
		},
		{
			Delay = 0,
			Quantity = 12,
			LifeTimeQuantity = 12,
			SpawnRate = 1200,
			Brushes = [
				"blood_splatter_bones_04",
				"blood_splatter_bones_05",
				"blood_splatter_bones_06"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 70,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.8),
					DirectionMax = this.createVec(0.2, 0.8),
					SpawnOffsetMin = this.createVec(-15, -15),
					SpawnOffsetMax = this.createVec(15, 15)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					VelocityMin = 70,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -175),
					ForceMax = this.createVec(0, -175)
				},
				{
					LifeTimeMin = 0.05,
					LifeTimeMax = 0.05,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 400,
			LifeTimeQuantity = 400,
			SpawnRate = 250,
			Brushes = [
				"effect_fire_01",
				"effect_fire_02",
				"effect_fire_03"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("f8fbff00"),
					ColorMax = this.createColor("f8fbff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					SpawnOffsetMin = this.createVec(-25, -15),
					SpawnOffsetMax = this.createVec(25, 20),
					ForceMin = this.createVec(0, 50),
					ForceMax = this.createVec(0, 80)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.5,
					ColorMin = this.createColor("ddecffff"),
					ColorMax = this.createColor("f8fbffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					ForceMin = this.createVec(0, 50),
					ForceMax = this.createVec(0, 80)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.5,
					ColorMin = this.createColor("8abbf8f0"),
					ColorMax = this.createColor("c4dcf9f0"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 50),
					ForceMax = this.createVec(0, 80)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("3a89e900"),
					ColorMax = this.createColor("559ef700"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 50),
					ForceMax = this.createVec(0, 80)
				}
			]
		},
		{
			Delay = 0,
			Quantity = 150,
			LifeTimeQuantity = 150,
			SpawnRate = 160,
			Brushes = [
				"ash_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					SpawnOffsetMin = this.createVec(-35, -30),
					SpawnOffsetMax = this.createVec(35, 15)
				},
				{
					LifeTimeMin = 2.0,
					LifeTimeMax = 3.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 10)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -80),
					ForceMax = this.createVec(0, -80)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 40,
			LifeTimeQuantity = 40,
			SpawnRate = 160,
			Brushes = [
				"blood_splatter_green_01",
				"blood_splatter_green_02",
				"blood_splatter_green_05",
				"blood_splatter_green_06",
				"blood_splatter_green_07",
				"blood_splatter_green_08",
				"blood_splatter_green_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 100,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.1, 0.7),
					DirectionMax = this.createVec(0.1, 0.7),
					SpawnOffsetMin = this.createVec(10, 0),
					SpawnOffsetMax = this.createVec(10, 0)
				},
				{
					LifeTimeMin = 1.0,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		},
		{
			Delay = 600,
			Quantity = 30,
			LifeTimeQuantity = 30,
			SpawnRate = 120,
			Brushes = [
				"blood_splatter_green_01",
				"blood_splatter_green_02",
				"blood_splatter_green_05",
				"blood_splatter_green_06",
				"blood_splatter_green_07",
				"blood_splatter_green_08",
				"blood_splatter_green_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 90,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.1, 0.6),
					DirectionMax = this.createVec(0.1, 0.6),
					SpawnOffsetMin = this.createVec(-5, 10),
					SpawnOffsetMax = this.createVec(-5, 10)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		},
		{
			Delay = 1200,
			Quantity = 30,
			LifeTimeQuantity = 30,
			SpawnRate = 120,
			Brushes = [
				"blood_splatter_green_01",
				"blood_splatter_green_02",
				"blood_splatter_green_05",
				"blood_splatter_green_06",
				"blood_splatter_green_07",
				"blood_splatter_green_08",
				"blood_splatter_green_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 90,
					VelocityMax = 225,
					DirectionMin = this.createVec(-0.1, 0.6),
					DirectionMax = this.createVec(0.1, 0.6),
					SpawnOffsetMin = this.createVec(-20, 20),
					SpawnOffsetMax = this.createVec(-20, 20)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 225,
					VelocityMax = 225,
					ForceMin = this.createVec(-30, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 140,
			LifeTimeQuantity = 140,
			SpawnRate = 1200,
			Brushes = [
				"dust_01",
				"dust_02"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					SpawnOffsetMin = this.createVec(-60, -50),
					SpawnOffsetMax = this.createVec(60, 20)
				},
				{
					LifeTimeMin = 2.0,
					LifeTimeMax = 3.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -100),
					ForceMax = this.createVec(0, -100)
				}
			]
		},
		{
			Delay = 0,
			Quantity = 16,
			LifeTimeQuantity = 16,
			SpawnRate = 1200,
			Brushes = [
				"blood_splatter_wood_04",
				"blood_splatter_wood_05",
				"blood_splatter_wood_06"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 70,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.8),
					DirectionMax = this.createVec(0.2, 0.8),
					SpawnOffsetMin = this.createVec(-30, 10),
					SpawnOffsetMax = this.createVec(30, 50)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					VelocityMin = 70,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -175),
					ForceMax = this.createVec(0, -175)
				},
				{
					LifeTimeMin = 0.05,
					LifeTimeMax = 0.05,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.66,
					ScaleMax = 0.66,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 60,
			LifeTimeQuantity = 60,
			SpawnRate = 700,
			Brushes = [
				"sand_dust_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.2,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.5,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 60,
					VelocityMax = 100,
					DirectionMin = this.createVec(-0.4, 0.6),
					DirectionMax = this.createVec(0.4, 0.6),
					SpawnOffsetMin = this.createVec(-60, -50),
					SpawnOffsetMax = this.createVec(60, 20)
				},
				{
					LifeTimeMin = 2.0,
					LifeTimeMax = 3.0,
					ColorMin = this.createColor("eeeeeeee"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 60,
					VelocityMax = 100,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.2,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -100),
					ForceMax = this.createVec(0, -100)
				}
			]
		}
	]
];
::Const.Tactical.DecapitateSplatters = [
	[],
	[
		{
			Delay = 0,
			Quantity = 80,
			LifeTimeQuantity = 80,
			SpawnRate = 50,
			Brushes = [
				"blood_splatter_red_01",
				"blood_splatter_red_02",
				"blood_splatter_red_05",
				"blood_splatter_red_06",
				"blood_splatter_red_07",
				"blood_splatter_red_08",
				"blood_splatter_red_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.008, 0.8),
					DirectionMax = this.createVec(0.008, 0.9),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.33,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(-10, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -200),
					ForceMax = this.createVec(0, -200)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 60,
			LifeTimeQuantity = 60,
			SpawnRate = 40,
			Brushes = [
				"blood_splatter_dark_01",
				"blood_splatter_dark_05",
				"blood_splatter_dark_06",
				"blood_splatter_dark_07",
				"blood_splatter_dark_08",
				"blood_splatter_dark_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.01, 0.7),
					DirectionMax = this.createVec(0.01, 0.7),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.33,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(-10, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	this.Const.Tactical.BloodSplatters[3],
	this.Const.Tactical.BloodSplatters[4],
	[
		{
			Delay = 0,
			Quantity = 80,
			LifeTimeQuantity = 80,
			SpawnRate = 50,
			Brushes = [
				"blood_splatter_green_01",
				"blood_splatter_green_02",
				"blood_splatter_green_05",
				"blood_splatter_green_06",
				"blood_splatter_green_07",
				"blood_splatter_green_08",
				"blood_splatter_green_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.008, 0.8),
					DirectionMax = this.createVec(0.008, 0.9),
					SpawnOffsetMin = this.createVec(0, 0),
					SpawnOffsetMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.33,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(-10, 0),
					ForceMax = this.createVec(-10, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -200),
					ForceMax = this.createVec(0, -200)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	this.Const.Tactical.BloodSplatters[6],
	this.Const.Tactical.BloodSplatters[7]
];
::Const.Tactical.SmashSplatters = [
	[],
	[
		{
			Delay = 0,
			Quantity = 160,
			LifeTimeQuantity = 160,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_red_01",
				"blood_splatter_red_02",
				"blood_splatter_red_05",
				"blood_splatter_red_06",
				"blood_splatter_red_07",
				"blood_splatter_red_08",
				"blood_splatter_red_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.7),
					DirectionMax = this.createVec(0.2, 0.7),
					SpawnOffsetMin = this.createVec(-5, 5),
					SpawnOffsetMax = this.createVec(-5, 5)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.33,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	[
		{
			Delay = 0,
			Quantity = 1600,
			LifeTimeQuantity = 160,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_dark_01",
				"blood_splatter_dark_05",
				"blood_splatter_dark_06",
				"blood_splatter_dark_07",
				"blood_splatter_dark_08",
				"blood_splatter_dark_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.7),
					DirectionMax = this.createVec(0.2, 0.7),
					SpawnOffsetMin = this.createVec(-5, 5),
					SpawnOffsetMax = this.createVec(-5, 5)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.33,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	this.Const.Tactical.BloodSplatters[3],
	this.Const.Tactical.BloodSplatters[4],
	[
		{
			Delay = 0,
			Quantity = 160,
			LifeTimeQuantity = 160,
			SpawnRate = 400,
			Brushes = [
				"blood_splatter_green_01",
				"blood_splatter_green_02",
				"blood_splatter_green_05",
				"blood_splatter_green_06",
				"blood_splatter_green_07",
				"blood_splatter_green_08",
				"blood_splatter_green_09"
			],
			Stages = [
				{
					LifeTimeMin = 0.3,
					LifeTimeMax = 0.3,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.01,
					ScaleMax = 0.01,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = 10,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 150,
					DirectionMin = this.createVec(-0.2, 0.7),
					DirectionMax = this.createVec(0.2, 0.7),
					SpawnOffsetMin = this.createVec(-5, 5),
					SpawnOffsetMax = this.createVec(-5, 5)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.0,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.33,
					ScaleMax = 0.75,
					VelocityMin = 150,
					VelocityMax = 150,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff7f"),
					ColorMax = this.createColor("ffffff7f"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, -180),
					ForceMax = this.createVec(0, -180)
				},
				{
					LifeTimeMin = 0.02,
					LifeTimeMax = 0.04,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					VelocityMin = 0,
					VelocityMax = 0,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				}
			]
		}
	],
	this.Const.Tactical.BloodSplatters[6],
	this.Const.Tactical.BloodSplatters[7]
];
::Const.Tactical.TerrainDropdownParticles = [
	[],
	[],
	[],
	[],
	[],
	[
		{
			ApplyOnRain = false,
			Delay = 0,
			Quantity = 9,
			LifeTimeQuantity = 9,
			SpawnRate = 1200,
			Brushes = [
				"dust_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 40,
					VelocityMax = 60,
					DirectionMin = this.createVec(-0.7, 0.2),
					DirectionMax = this.createVec(0.7, 0.2),
					SpawnOffsetMin = this.createVec(-35, -40),
					SpawnOffsetMax = this.createVec(35, 0)
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
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 20,
					VelocityMax = 40,
					ForceMin = this.createVec(0, -50),
					ForceMax = this.createVec(0, -50)
				}
			]
		}
	],
	[],
	[],
	[],
	[
		{
			ApplyOnRain = true,
			Delay = 0,
			Quantity = 40,
			LifeTimeQuantity = 40,
			SpawnRate = 1200,
			Brushes = [
				"swamp_splatter_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.5,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = -20,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 90,
					DirectionMin = this.createVec(-0.6, 0.4),
					DirectionMax = this.createVec(0.6, 0.4),
					SpawnOffsetMin = this.createVec(-10, -40),
					SpawnOffsetMax = this.createVec(10, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.75,
					ScaleMax = 1.5,
					VelocityMin = 60,
					VelocityMax = 90,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 0.75,
					VelocityMin = 50,
					VelocityMax = 50,
					ForceMin = this.createVec(0, -60),
					ForceMax = this.createVec(0, -60)
				}
			]
		}
	],
	[],
	[
		{
			ApplyOnRain = false,
			Delay = 0,
			Quantity = 9,
			LifeTimeQuantity = 9,
			SpawnRate = 1200,
			Brushes = [
				"dust_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 40,
					VelocityMax = 60,
					DirectionMin = this.createVec(-0.7, 0.2),
					DirectionMax = this.createVec(0.7, 0.2),
					SpawnOffsetMin = this.createVec(-35, -40),
					SpawnOffsetMax = this.createVec(35, 0)
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
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 20,
					VelocityMax = 40,
					ForceMin = this.createVec(0, -50),
					ForceMax = this.createVec(0, -50)
				}
			]
		}
	],
	[],
	[],
	[],
	[],
	[],
	[
		{
			ApplyOnRain = false,
			Delay = 0,
			Quantity = 7,
			LifeTimeQuantity = 7,
			SpawnRate = 600,
			Brushes = [
				"sand_dust_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.5,
					ScaleMax = 0.75,
					RotationMin = 0,
					RotationMax = 359,
					VelocityMin = 40,
					VelocityMax = 60,
					DirectionMin = this.createVec(-0.7, 0.2),
					DirectionMax = this.createVec(0.7, 0.2),
					SpawnOffsetMin = this.createVec(-35, -40),
					SpawnOffsetMax = this.createVec(35, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.5,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 40,
					VelocityMax = 60,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("eeeeee00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 1.0,
					ScaleMax = 1.0,
					VelocityMin = 20,
					VelocityMax = 40,
					ForceMin = this.createVec(0, -50),
					ForceMax = this.createVec(0, -50)
				}
			]
		}
	],
	[
		{
			ApplyOnRain = true,
			Delay = 0,
			Quantity = 40,
			LifeTimeQuantity = 40,
			SpawnRate = 600,
			Brushes = [
				"swamp_splatter_01"
			],
			Stages = [
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					RotationMin = 0,
					RotationMax = 359,
					TorqueMin = -20,
					TorqueMax = 20,
					VelocityMin = 60,
					VelocityMax = 90,
					DirectionMin = this.createVec(-0.6, 0.4),
					DirectionMax = this.createVec(0.6, 0.4),
					SpawnOffsetMin = this.createVec(-10, -40),
					SpawnOffsetMax = this.createVec(10, 0)
				},
				{
					LifeTimeMin = 1.5,
					LifeTimeMax = 2.5,
					ColorMin = this.createColor("ffffffff"),
					ColorMax = this.createColor("ffffffff"),
					ScaleMin = 0.75,
					ScaleMax = 1.0,
					VelocityMin = 60,
					VelocityMax = 90,
					ForceMin = this.createVec(0, 0),
					ForceMax = this.createVec(0, 0)
				},
				{
					LifeTimeMin = 0.1,
					LifeTimeMax = 0.1,
					ColorMin = this.createColor("ffffff00"),
					ColorMax = this.createColor("ffffff00"),
					ScaleMin = 0.75,
					ScaleMax = 0.75,
					VelocityMin = 50,
					VelocityMax = 50,
					ForceMin = this.createVec(0, -60),
					ForceMax = this.createVec(0, -60)
				}
			]
		}
	]
];
::Const.Tactical.BurnParticles = [
	{
		Delay = 100,
		Quantity = 230,
		LifeTimeQuantity = 230,
		SpawnRate = 300,
		Brushes = [
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.1,
				ColorMin = this.createColor("ffe7cf00"),
				ColorMax = this.createColor("ffeacf00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-50, -30),
				SpawnOffsetMax = this.createVec(50, 20),
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ff813dff"),
				ColorMax = this.createColor("fec19fff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("fc6a52f0"),
				ColorMax = this.createColor("fcaa52f0"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("d8380000"),
				ColorMax = this.createColor("d8380000"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			}
		]
	},
	{
		Delay = 100,
		Quantity = 80,
		LifeTimeQuantity = 80,
		SpawnRate = 170,
		Brushes = [
			"ash_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-35, -30),
				SpawnOffsetMax = this.createVec(35, 15)
			},
			{
				LifeTimeMin = 2.0,
				LifeTimeMax = 3.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			}
		]
	}
];
::Const.Tactical.FireParticles = [
	{
		Delay = 0,
		Quantity = 230,
		LifeTimeQuantity = 0,
		SpawnRate = 156,
		Brushes = [
			"effect_fire_01",
			"effect_fire_02",
			"effect_fire_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.1,
				ColorMin = this.createColor("ffe7cf00"),
				ColorMax = this.createColor("ffeacf00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-50, -45),
				SpawnOffsetMax = this.createVec(50, 5),
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ff813dff"),
				ColorMax = this.createColor("fec19fff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("fc6a52f0"),
				ColorMax = this.createColor("fcaa52f0"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("d8380000"),
				ColorMax = this.createColor("d8380000"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 50),
				ForceMax = this.createVec(0, 80)
			}
		]
	},
	{
		Delay = 100,
		Quantity = 40,
		LifeTimeQuantity = 0,
		SpawnRate = 21,
		Brushes = [
			"ash_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-35, -45),
				SpawnOffsetMax = this.createVec(35, 0)
			},
			{
				LifeTimeMin = 2.0,
				LifeTimeMax = 3.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			}
		]
	}
];
::Const.Tactical.LightningParticles = [
	{
		Delay = 0,
		Quantity = 10,
		LifeTimeQuantity = 10,
		SpawnRate = 300,
		Brushes = [
			"effect_lightning_01",
			"effect_lightning_02",
			"effect_lightning_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.1,
				ColorMin = this.createColor("fffffff00"),
				ColorMax = this.createColor("fffffff00"),
				ScaleMin = 0.25,
				ScaleMax = 0.5,
				RotationMin = -10,
				RotationMax = 10,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.1, -0.9),
				DirectionMax = this.createVec(0.1, -0.9),
				SpawnOffsetMin = this.createVec(-10, 90),
				SpawnOffsetMax = this.createVec(10, 140),
				ForceMin = this.createVec(0, -50),
				ForceMax = this.createVec(0, -80)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("fffffffe0"),
				ColorMax = this.createColor("ffffffff0"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = -10,
				RotationMax = 10,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.2, -0.9),
				DirectionMax = this.createVec(0.2, -0.9),
				ForceMin = this.createVec(0, -50),
				ForceMax = this.createVec(0, -80)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("ffffffe0"),
				ColorMax = this.createColor("ffffffe0"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = -10,
				RotationMax = 10,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, -50),
				ForceMax = this.createVec(0, -80)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				RotationMin = -10,
				RotationMax = 10,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, -50),
				ForceMax = this.createVec(0, -80)
			}
		]
	},
	{
		Delay = 100,
		Quantity = 80,
		LifeTimeQuantity = 80,
		SpawnRate = 170,
		Brushes = [
			"ash_01"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.2,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				SpawnOffsetMin = this.createVec(-35, -30),
				SpawnOffsetMax = this.createVec(35, 15)
			},
			{
				LifeTimeMin = 2.0,
				LifeTimeMax = 3.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 10)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.75,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, -80),
				ForceMax = this.createVec(0, -80)
			}
		]
	}
];
