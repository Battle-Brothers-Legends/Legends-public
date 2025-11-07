this.perk_legend_wheel_maintenance <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWheelMaintenance);
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
