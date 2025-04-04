this.legend_camp_discover_location_action <- this.inherit("scripts/factions/faction_action", {
	m = {},
	function create()
	{
		this.m.ID = "legend_camp_discover_location_action";
		this.m.Cooldown = this.World.getTime().SecondsPerDay * 12;
		this.m.IsStartingOnCooldown = false;
		this.m.IsSettlementsRequired = false;
		this.faction_action.create();
	}

	function onUpdate( _faction )
	{
		if (this.World.State.getRegions().len() == 0)
			return;

		if (!this.Const.DLC.Unhold)
			return;

		if (!_faction.isReadyForContract())
			return;

		local locations = clone this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		locations.extend(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getSettlements());
		local myTile = _faction.getSettlements()[0].getTile();
		local lowestDistance = 9000;

		foreach( b in locations )
		{
			if (b.isDiscovered() || b.isLocationType(this.Const.World.LocationType.Unique))
				continue;

			if (!this.World.State.getRegion(b.getTile().Region).Center.IsDiscovered)
				continue;

			local region = this.World.State.getRegion(b.getTile().Region);

			if (!region.Center.IsDiscovered)
				continue;

			if (region.Discovered < 0.25)
				this.World.State.updateRegionDiscovery(region);

			if (region.Discovered < 0.25)
				continue;

			local d = myTile.getDistanceTo(b.getTile());

			if (d < lowestDistance)
				lowestDistance = d;
		}

		if (lowestDistance >= 20)
			return;

		this.m.Score = 1;
	}

	function onClear()
	{
	}

	function onExecute( _faction )
	{
		if (_faction.getType() != ::Const.FactionType.FreeCompany)
			return;
		local contract = this.new("scripts/contracts/contracts/legend_camp_discover_location_contract");
		contract.setFaction(_faction);
		contract.setEmployerID(_faction.getRandomCharacter().getID());
//		contract.setHome(::World.Camp);
//		contract.setOrigin(::World.Camp);
		contract.setup();
		this.World.Contracts.addContract(contract);
	}

});

