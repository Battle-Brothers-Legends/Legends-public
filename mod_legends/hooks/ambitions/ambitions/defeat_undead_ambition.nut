::mods_hookExactClass("ambitions/ambitions/defeat_undead_ambition", function(o) 
{
	o.onUpdateScore = function ()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition" && ::World.FactionManager.isUndeadScourge())
		{
			this.m.Score = 100; //  effectively guarantee that this ambition is available during the Undead crisis for the Inquisition origin
			return;
		}

		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		this.m.Score = 10;
	}

});
