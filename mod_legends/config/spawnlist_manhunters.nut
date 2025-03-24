::Const.World.Spawn.LegendManhunters <-
{
	Name = "LegendManhunters",
	IsDynamic = true,
	MovementSpeedMult = 1.0,
	VisibilityMult = 1.0,
	VisionMult = 1.0,
	Body = "figure_nomad_01",
	MaxR = 530,
	MinR = 55,
	Troops = [
		{
			Weight = 60,
			Types = [
				{
					MaxR = 380,
					Type = this.Const.World.Spawn.Troops.LegendManhunter,
					Cost = 15
				},
				{
					MinR = 220,
					Type = this.Const.World.Spawn.Troops.LegendManhunterVeteran,
					Cost = 20
				}
			]
		},
		{
			Weight = 40,
			Types = [
				{
					MaxR = 400,
					Type = this.Const.World.Spawn.Troops.LegendManhunterRanged,
					Cost = 20
				},
				{
					MinR = 240,
					Type = this.Const.World.Spawn.Troops.LegendManhunterVeteranRanged,
					Cost = 28
				}
			]
		}
	]
}
