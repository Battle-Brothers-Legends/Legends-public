::mods_hookExactClass("factions/actions/rebuild_location_action", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (this.Math.rand(1, 100) > 10)
		{
			return;
		}

		if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getID() == "contract.raze_attached_location")
		{
			return;
		}

		this.m.Settlement = _faction.getSettlements()[this.Math.rand(0, _faction.getSettlements().len() - 1)];

		if (_faction.getType() == this.Const.FactionType.NobleHouse && !this.m.Settlement.isMilitary())
		{
			return;
		}

		if (this.m.Settlement.getTile().getDistanceTo(this.World.State.getPlayer().getTile()) <= 15)
		{
			return;
		}

		if (this.m.Settlement.isBuilding())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local numInactive = 0;
		local nogo = false;

		foreach( a in this.m.Settlement.getAttachedLocations() )
		{
			if (a.isActive())
			{
				continue;
			}

			if (a.isBuilding())
			{
				nogo = true;
				break;
			}

			numInactive = ++numInactive;
		}

		if (nogo)
		{
			return;
		}

		if (numInactive == 0)
		{
			return;
		}

		this.m.Score = 1;
	}
});
