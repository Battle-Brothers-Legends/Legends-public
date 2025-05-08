::mods_hookExactClass("ambitions/ambitions/visit_settlements_ambition", function(o)
{
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (this.World.Ambitions.getDone() == 0 && (this.World.Assets.getOrigin().getID() != "scenario.deserters" || this.World.Assets.getOrigin().getID() != "scenario.raiders" || this.World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves"))
			return;
		onUpdateScore();
	}

});
