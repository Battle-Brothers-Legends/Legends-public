this.perk_legend_wheel_maintenance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendWheelMaintenance);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	// handled in party.nut
	// function onUpdate(_properties)
	// {
	// 	for( local i = 0; i < this.World.Assets.m.TerrainTypeSpeedMult.len(); i = ++i )
	// 	{
	// 		this.World.Assets.m.TerrainTypeSpeedMult[i] *= 1.05;
	// 	}
	// }

});
