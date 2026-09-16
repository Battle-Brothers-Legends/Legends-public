::mods_hookExactClass("factions/contracts/discover_location_action", function(o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = ::World.getTime().SecondsPerDay * 7;
	}

	o.onUpdate = function ( _faction )
	{
		if (::World.State.getRegions().len() == 0)
		{
			return;
		}

		if (!::Const.DLC.Unhold)
		{
			return;
		}

		if (!_faction.isReadyForContract(::Const.Contracts.ContractCategoryMap.discover_location_contract))
		{
			return;
		}

		if (::World.getTime().Days <= 3 && ::Math.rand(1, 100) < 20 || ::Math.rand(1, 100) > 10)
		{
			return;
		}

		local locations = clone ::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getSettlements();
		locations.extend(::World.FactionManager.getFactionOfType(::Const.FactionType.Zombies).getSettlements());
		local myTile = _faction.getSettlements()[0].getTile();
		local lowestDistance = 9000;

		foreach( b in locations )
		{
			if (b.isDiscovered() || b.isLocationType(::Const.World.LocationType.Unique))
			{
				continue;
			}

			if (!::World.State.getRegion(b.getTile().Region).Center.IsDiscovered)
			{
				continue;
			}

			local region = ::World.State.getRegion(b.getTile().Region);

			if (!region.Center.IsDiscovered)
			{
				continue;
			}

			if (region.Discovered < 0.25)
			{
				::World.State.updateRegionDiscovery(region);
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
