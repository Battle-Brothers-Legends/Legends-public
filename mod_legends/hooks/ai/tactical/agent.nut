::mods_hookBaseClass("ai/tactical/agent", function ( o )
{
	while(!("ID" in o.m)) o=o[o.SuperName];

	o._mod_legend <- true;// only override the methods once per base instance
	o.m.PriorityTarget <- null;

	o.setPriorityTarget <- function(_entity)
	{
		this.m.PriorityTarget = _entity;
	}

	o.getPriorityTarget <- function ()
	{
		return this.m.PriorityTarget;
	}

	o.getVisibleOpponents <- function()
	{
		this.getStrategy().compileKnownOpponents();
		local knownOpponents = this.getKnownOpponents();

		local entityRet = [];

		if (knownOpponents.len() == 0)
		{
			return [];
		}

		foreach( opponent in knownOpponents )
		{
			if (!opponent.Actor.isNull() && opponent.Actor.isAlive() && opponent.Actor.isPlacedOnMap() && opponent.Actor.get().getTile().getDistanceTo(this.getActor().getTile()) <= this.getActor().getCurrentProperties().getVision())
			{
				// this.logWarning("Tile Added: " + opponent.Actor.get().getTile())
				entityRet.push(opponent.Actor.get());
			}
		}

		return entityRet;
	}
});
