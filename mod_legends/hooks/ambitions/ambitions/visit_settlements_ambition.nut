::mods_hookExactClass("ambitions/ambitions/visit_settlements_ambition", function(o)
{
	local onUpdateScore = o.onUpdateScore;
	o.onUpdateScore = function ()
	{
		if (::World.Ambitions.getDone() == 0 && (::World.Assets.getOrigin().getID() != "scenario.deserters" || ::World.Assets.getOrigin().getID() != "scenario.raiders" || ::World.Assets.getOrigin().getID() != "scenario.legend_escaped_slaves"))
			return;
		onUpdateScore();
	}

});
