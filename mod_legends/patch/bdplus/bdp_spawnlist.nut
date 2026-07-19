// add Indemnifier to southern city parties
::Const.World.Spawn.Southern.Troops.push({
	Weight = 10,
	Types = [{
		Type = ::Const.World.Spawn.Troops.Indemnifier,
		Cost = 25
	}]
});

::Const.World.Spawn.Crownlings <- {
	Name = "Crownlings",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_crownling_01",
	MaxR = 600,
	Troops =
	[
		{
			Weight = 50,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.CrownlingLow,
					MaxR = 150,
					Cost = 7
				},
				{
					Type = ::Const.World.Spawn.Troops.Crownling,
					MinR = 120,
					Cost = 18
				},
				{
					Type = ::Const.World.Spawn.Troops.CrownlingRanged,
					Cost = 12
				}
			]
		},
		{
			Weight = 5,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.DesertStalker,
					MinR = 250,
					Cost = 25
				}
			]
		},
		{
			Weight = 10,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.DesertDevil,
					MinR = 300,
					Cost = 35
				}
			]
		},
		{
			Weight = 9,
			Types = [
				{
					Type = ::Const.World.Spawn.Troops.Executioner,
					MinR = 300,
					Cost = 35
				}
			]
		}
	]
};
