::mods_hookExactClass("factions/contracts/discover_location_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (this.World.State.getRegions().len() == 0)
		{
			return;
		}

		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!_faction.isReadyForContract(this.Const.Contracts.ContractCategoryMap.discover_location_contract))
		{
			return;
		}

		if (this.World.getTime().Days <= 3 && this.Math.rand(1, 100) < 20 || this.Math.rand(1, 100) > 10)
		{
			return;
		}

		local locations = clone this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		locations.extend(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());
		local myTile = _faction.getSettlements()[0].getTile();
		local lowestDistance = 9000;

		foreach( b in locations )
		{
			if (b.isDiscovered() || b.isLocationType(this.Const.World.LocationType.Unique))
			{
				continue;
			}

			if (!this.World.State.getRegion(b.getTile().Region).Center.IsDiscovered)
			{
				continue;
			}

			local region = this.World.State.getRegion(b.getTile().Region);

			if (!region.Center.IsDiscovered)
			{
				continue;
			}

			if (region.Discovered < 0.25)
			{
				this.World.State.updateRegionDiscovery(region);
			}

			if (region.Discovered < 0.25)
			{
				continue;
			}

			local d = myTile.getDistanceTo(b.getTile());

			if (d < lowestDistance)
			{
				lowestDistance = d;
			}
		}

		if (lowestDistance >= 20)
		{
			return;
		}

		this.m.Score = 1;
	}
});
