::mods_hookExactClass("events/events/mountains_are_dangerous_event", function(o) {
	o.onUpdateScore = function () {
		if (::World.State.getPlayer().getTile().Type != this.Const.World.TerrainType.Mountains || ::World.Assets.m.ProfessionEffect.LegendTrailblazer > 0)	{
			return;
		}

		this.m.Score = 25;
	}
})