::mods_hookExactClass("factions/contracts/root_out_undead_action", function(o) 
{
	o.onUpdate = function ( _faction )
	{
		if (!_faction.isReadyForContract())
		{
			return;
		}

		if (_faction.getPlayerRelation() <= 25)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		if (this.Math.rand(1, 100) > 30)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		this.m.Score = 1;
		
		if (this.World.Assets.getOrigin().getID() == "scenario.legends_inquisition")
		{
		this.m.Score = 10;
		}
	}
});
