::mods_hookExactClass("skills/effects/killing_frenzy_effect", function(o) {
	
	o.resetTime <- function()
	{
		if (this.m.TurnsLeft != 2)
		{
			this.m.TurnsLeft = 2;
			if (this.getContainer().getActor().isPlacedOnMap())
			{
				this.spawnIcon("perk_36", this.getContainer().getActor().getTile());
			}
		}
	}

	o.reset = function()
	{
	}
});