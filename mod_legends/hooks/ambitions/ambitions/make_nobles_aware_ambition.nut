::mods_hookExactClass("ambitions/ambitions/make_nobles_aware_ambition", function(o)
{
	o.onReward = function ()
	{
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/special.png",
			text = "Nobles will now give you contracts"
		});

		if (!this.World.Assets.getOrigin().isFixedLook())
		{
			if (this.World.Assets.getOrigin().getID() == "scenario.southern_quickstart")
			{
				this.World.Assets.updateLook(14);
			}
			else
			{
				this.World.Assets.updateLook(2);
			}
		}
	}

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
