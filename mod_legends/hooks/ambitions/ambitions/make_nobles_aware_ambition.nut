::mods_hookExactClass("ambitions/ambitions/make_nobles_aware_ambition", function(o) {
	o.onUpdateScore = function ()
	{
		if (::World.Ambitions.getDone() < 2 && !::World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() < 800)
		{
			return;
		}

		if (!::World.Ambitions.getAmbition("ambition.battle_standard").isDone() && !::World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			return;
		}

		if (::World.Assets.getBusinessReputation() >= 1050 && ::World.FactionManager.isGreaterEvil() || !::World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 10;
	}

});
