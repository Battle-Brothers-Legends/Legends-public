::Const.World.Spawn.EscapedSlavesManhunters <-
{
	Name = "EscapedSlavesManhunters",
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
					Type = this.Const.World.Spawn.Troops.EscapedSlavesManhunter,
					Cost = 15
				},
				{
					MinR = 220,
					Type = this.Const.World.Spawn.Troops.EscapedSlavesManhunterVeteran,
					Cost = 20
				}
			]
		},
		{
			Weight = 40,
			Types = [
				{
					MaxR = 400,
					Type = this.Const.World.Spawn.Troops.EscapedSlavesManhunterRanged,
					Cost = 20
				},
				{
					MinR = 240,
					Type = this.Const.World.Spawn.Troops.EscapedSlavesManhunterVeteranRanged,
					Cost = 28
				}
			]
		}
	]
}
