::mods_hookExactClass("ambitions/ambitions/make_nobles_aware_ambition", function(o) 
{
	o.onUpdateScore = function ()
	{
		if (this.World.Ambitions.getDone() < 2 && !this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 800)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.battle_standard").isDone() && !this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() >= 1050 && this.World.FactionManager.isGreaterEvil() || !this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 10;
	}

});
