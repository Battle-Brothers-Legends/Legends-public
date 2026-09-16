::mods_hookExactClass("ambitions/ambitions/roster_of_20_ambition", function(o) 
{
	o.onUpdateScore = function ()
	{
		if (::World.getTime().Days <= 15)
			return;

		if (::World.Ambitions.getDone() < 2)
			return;

		if (::World.getPlayerRoster().getSize() >= 20)
		{
			this.m.IsDone = true;
			return;
		}

		if (::World.Assets.getBrothersMax() < 20)
			return;

		local previous = ::World.Ambitions.getAmbition("ambition.roster_of_16");
		if (previous.getScore() != 0 && !previous.isDone())
			return;

		if (!::World.Ambitions.getAmbition("ambition.roster_of_16").isDone())
		{
			return;
		}

		if (!::World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
			return;

		this.m.Score = 1 + ::Math.rand(0, 5);
	}

});
