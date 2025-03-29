::mods_hookExactClass("ambitions/ambitions/roster_of_20_ambition", function(o) 
{
	o.onUpdateScore = function ()
	{
		if (this.World.getTime().Days <= 15)
			return;

		if (this.World.Ambitions.getDone() < 2)
			return;

		if (this.World.getPlayerRoster().getSize() >= 20)
		{
			this.m.IsDone = true;
			return;
		}

		if (this.World.Assets.getBrothersMax() < 20)
			return;

		local previous = this.World.Ambitions.getAmbition("ambition.roster_of_16");
		if (previous.getScore() != 0 && !previous.isDone())
			return;

		if (!this.World.Ambitions.getAmbition("ambition.roster_of_16").isDone())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
			return;

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

});
