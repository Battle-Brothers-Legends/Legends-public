::Const.World.HolyFlameParticles <- [
	{
		Delay = 0,
		Quantity = 60,
		LifeTime = 50000,
		SpawnRate = 60,
		Brushes = [
			"effect_sanctify_01",
			"effect_sanctify_02",
			"effect_sanctify_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.1,
				ColorMin = this.createColor("ffe7cf00"),
				ColorMax = this.createColor("ffeacf00"),
				ScaleMin = 0.3,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.5),
				DirectionMax = this.createVec(0.4, 0.5),
				SpawnOffsetMin = this.createVec(-70, -30),
				SpawnOffsetMax = this.createVec(70, 20),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ff813dff"),
				ColorMax = this.createColor("fec19fff"),
				ScaleMin = 0.6,
				ScaleMax = 0.6,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("fc6a52f0"),
				ColorMax = this.createColor("fcaa52f0"),
				ScaleMin = 0.6,
				ScaleMax = 0.6,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("d8380000"),
				ColorMax = this.createColor("d8380000"),
				ScaleMin = 0.6,
				ScaleMax = 0.6,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];

::Const.World.TransformParticles <- [
	{
		Delay = 0,
		Quantity = 60,
		LifeTime = 50000,
		SpawnRate = 60,
		Brushes = [
			"effect_transform_01",
			"effect_transform_02",
			"effect_transform_03"
		],
		Stages = [
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.1,
				ColorMin = this.createColor("ffe7cf00"),
				ColorMax = this.createColor("ffeacf00"),
				ScaleMin = 0.3,
				ScaleMax = 0.5,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.5),
				DirectionMax = this.createVec(0.4, 0.5),
				SpawnOffsetMin = this.createVec(-70, -30),
				SpawnOffsetMax = this.createVec(70, 20),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ff813dff"),
				ColorMax = this.createColor("fec19fff"),
				ScaleMin = 0.6,
				ScaleMax = 0.6,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("fc6a52f0"),
				ColorMax = this.createColor("fcaa52f0"),
				ScaleMin = 0.6,
				ScaleMax = 0.6,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("d8380000"),
				ColorMax = this.createColor("d8380000"),
				ScaleMin = 0.6,
				ScaleMax = 0.6,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];


::Const.World.CampSmokeParticles <- [
	{
		Delay = 0,
		Quantity = 40,
		LifeTime = 10000,
		SpawnRate = 4,
		Brushes = [
			"ash_01",
			"ash_02"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 0.7,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.3, 0.4),
				DirectionMax = this.createVec(0.0, 0.4),
				SpawnOffsetMin = this.createVec(0, 25),
				SpawnOffsetMax = this.createVec(0, 25)
			},
			{
				LifeTimeMin = 6.0,
				LifeTimeMax = 8.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.3,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];
::Const.World.CampFireParticles <- [
	{
		Delay = 0,
		Quantity = 20,
		LifeTime = 10000,
		SpawnRate = 20,
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
				ScaleMin = 0.2,
				ScaleMax = 0.4,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 30,
				VelocityMax = 60,
				DirectionMin = this.createVec(-0.4, 0.5),
				DirectionMax = this.createVec(0.4, 0.5),
				SpawnOffsetMin = this.createVec(-3, 25),
				SpawnOffsetMax = this.createVec(-3, 25),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ff813dff"),
				ColorMax = this.createColor("fec19fff"),
				ScaleMin = 0.2,
				ScaleMax = 0.4,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 30,
				VelocityMax = 60,
				DirectionMin = this.createVec(-0.4, 0.6),
				DirectionMax = this.createVec(0.4, 0.6),
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.2,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("fc6a52f0"),
				ColorMax = this.createColor("fcaa52f0"),
				ScaleMin = 0.2,
				ScaleMax = 0.4,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 30,
				VelocityMax = 60,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.1,
				LifeTimeMax = 0.3,
				ColorMin = this.createColor("d8380000"),
				ColorMax = this.createColor("d8380000"),
				ScaleMin = 0.2,
				ScaleMax = 0.4,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 30,
				VelocityMax = 60,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];
::Const.World.SmelterSmokeParticles <- [
	{
		Delay = 0,
		Quantity = 40,
		LifeTime = 10000,
		SpawnRate = 4,
		Brushes = [
			"ash_01",
			"ash_02"
		],
		Stages = [
			{
				LifeTimeMin = 0.5,
				LifeTimeMax = 0.7,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 0.5,
				ScaleMax = 0.75,
				RotationMin = 0,
				RotationMax = 359,
				VelocityMin = 60,
				VelocityMax = 100,
				DirectionMin = this.createVec(-0.3, 0.4),
				DirectionMax = this.createVec(0.0, 0.4),
				SpawnOffsetMin = this.createVec(-30, 25),
				SpawnOffsetMax = this.createVec(30, 25)
			},
			{
				LifeTimeMin = 6.0,
				LifeTimeMax = 8.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 0.3,
				LifeTimeMax = 0.5,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];
::Const.World.BlizzardParticles <- [
	{
		Delay = 0,
		Quantity = 75,
		LifeTime = 1000,
		SpawnRate = 100,
		Brushes = [
			"snow_wind"
		],
		Stages = [
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 2.0,
				ScaleMax = 2.0,
				RotationMin = 0,
				RotationMax = 0,
				VelocityMin = 60,
				VelocityMax = 120,
				DirectionMin = this.createVec(-0.5, -0.3),
				DirectionMax = this.createVec(-0.5, -0.3),
				SpawnOffsetMin = this.createVec(-600, -600),
				SpawnOffsetMax = this.createVec(600, 600)
			},
			{
				LifeTimeMin = 46.0,
				LifeTimeMax = 46.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 2.0,
				ScaleMax = 2.0,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 10.0,
				LifeTimeMax = 10.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 2.0,
				ScaleMax = 2.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 2.0,
				ScaleMax = 2.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	},
	{
		Delay = 0,
		Quantity = 150,
		LifeTime = 1000,
		SpawnRate = 200,
		Brushes = [
			"snow_particle_01"
		],
		Stages = [
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				RotationMin = 0,
				RotationMax = 359,
				TorqueMin = -20,
				TorqueMax = 20,
				VelocityMin = 80,
				VelocityMax = 120,
				DirectionMin = this.createVec(-0.5, -0.3),
				DirectionMax = this.createVec(-0.5, -0.3),
				SpawnOffsetMin = this.createVec(-600, -600),
				SpawnOffsetMax = this.createVec(600, 600)
			},
			{
				LifeTimeMin = 46.0,
				LifeTimeMax = 46.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 60,
				VelocityMax = 100,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 10.0,
				LifeTimeMax = 10.0,
				ColorMin = this.createColor("ffffffff"),
				ColorMax = this.createColor("ffffffff"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			},
			{
				LifeTimeMin = 1.0,
				LifeTimeMax = 1.0,
				ColorMin = this.createColor("ffffff00"),
				ColorMax = this.createColor("ffffff00"),
				ScaleMin = 1.0,
				ScaleMax = 1.0,
				VelocityMin = 0,
				VelocityMax = 0,
				ForceMin = this.createVec(0, 0),
				ForceMax = this.createVec(0, 0)
			}
		]
	}
];

