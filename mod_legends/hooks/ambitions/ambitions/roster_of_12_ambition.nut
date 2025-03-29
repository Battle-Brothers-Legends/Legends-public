::mods_hookExactClass("ambitions/ambitions/roster_of_12_ambition", function(o) 
{
	o.onUpdateScore = function ()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.militia" || this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
			return;

		if (this.World.Ambitions.getDone() < 1 && this.World.Assets.getOrigin().getID() != "scenario.deserters" && this.World.Assets.getOrigin().getID() != "scenario.raiders")
			return;

		if (this.World.Assets.getBrothersMax() < 12)
			return;

		local previous = this.World.Ambitions.getAmbition("ambition.legend_roster_of_6");
		if (previous.getScore() != 0 && !previous.isDone())
			return;

		if (this.World.getPlayerRoster().getSize() >= 12)
		{
			this.m.IsDone = true;
			return;
		}


		this.m.Score = 1 + this.Math.rand(0, 5);
	}

});
