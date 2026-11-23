// FU town context: lets code that isn't inside a town work with one.
//
// Two layers:
// - ::FU.Town.forLocation(_location) / getContext(_town) build a snapshot of what a
//   location usually wants to know about its town (situations, relation, prices).
//   New features should take this context and pass it around explicitly.
// - ::FU.withTown(_town, _fn) / ::FU.GetTown() let existing code that reads
//   World.State.getCurrentTown() act as if it were in _town, for the duration of
//   _fn only. The native getCurrentTown can't be replaced, so that code has to read
//   ::FU.GetTown() instead.
//
// Functions refer to ::FU.Town rather than `this` so the ::FU aliases work.
// Example: local context = ::FU.Town.forLocation(location);
//          local price = ::FU.Town.getBuyPrice(item, context);
// Re-query when accepting a purchase; relations and situations can change prices.

::FU.Town <- {
	Overrides = [],

	function isValid( _town )
	{
		try { return _town != null && !_town.isNull() && _town.isAlive(); }
		catch (error) {}
		try { return _town != null && _town.isAlive(); }
		catch (error) { return false; }
	}

	// The town set by the innermost withTown, otherwise the town the player is in.
	function get()
	{
		local overrides = ::FU.Town.Overrides;
		if (overrides.len() != 0) return overrides.top();
		return ::FU.Safe.GetCurrentTown();
	}

	// Runs _fn with GetTown() returning _town. Always restores the previous town,
	// including when _fn throws, and supports nesting. Only covers code that runs
	// inside _fn: it can't span an event screen or anything the player does later.
	function with( _town, _fn )
	{
		local overrides = ::FU.Town.Overrides;
		overrides.push(_town);
		local depth = overrides.len();
		local result;
		try { result = _fn(); }
		catch (error)
		{
			overrides.resize(depth - 1);
			throw error;
		}
		overrides.resize(depth - 1);
		return result;
	}

	// The closest living settlement to _tile, or null. _maxDistance is in tiles.
	function nearest( _tile, _maxDistance = null )
	{
		local best = null;
		local bestDistance = null;
		local towns;
		try { towns = ::World.EntityManager.getSettlements(); }
		catch (error) { return null; }
		foreach (town in towns)
		{
			if (!::FU.Town.isValid(town)) continue;
			local distance = town.getTile().getDistanceTo(_tile);
			if (_maxDistance != null && distance > _maxDistance) continue;
			if (bestDistance == null || distance < bestDistance)
			{
				best = town;
				bestDistance = distance;
			}
		}
		return best;
	}

	// Civilian towns answer to their settlement faction. Military settlements
	// and city-states answer to their owner, as in the town's entry rules.
	function getFaction( _town )
	{
		if (!::FU.Town.isValid(_town)) return null;
		if (_town.isMilitary() || _town.isSouthern())
		{
			local owner = _town.getOwner();
			if (owner != null) return owner;
		}
		local faction = _town.getFactionOfType(::Const.FactionType.Settlement);
		if (faction == null) faction = _town.getFactionOfType(::Const.FactionType.OrientalCityState);
		return faction != null ? faction : _town.getOwner();
	}

	// Query the item's own pricing implementation, including subclass and mod
	// adjustments. The snapshot identifies the town; its prices are read live.
	function getBuyPrice( _item, _context )
	{
		if (_context == null || !::FU.Town.isValid(_context.Town)) return null;
		return ::FU.Town.with(_context.Town, @() _item.getBuyPrice());
	}

	function getSellPrice( _item, _context )
	{
		if (_context == null || !::FU.Town.isValid(_context.Town)) return null;
		return ::FU.Town.with(_context.Town, @() _item.getSellPrice());
	}

	// Snapshot of a town. Price multipliers are read when it's built, so build a new
	// one for each screen or decision rather than keeping it across days.
	function getContext( _town, _source = "explicit" )
	{
		if (!::FU.Town.isValid(_town)) return null;
		local situations = [];
		foreach (situation in _town.getSituations()) situations.push(situation.getID());
		local relation = null;
		local isAllied = false;
		local faction = ::FU.Town.getFaction(_town);
		if (faction != null)
		{
			relation = faction.getPlayerRelation();
			isAllied = faction.isAlliedWithPlayer();
		}
		return {
			Town = _town,
			Faction = faction,
			Source = _source,
			ID = _town.getID(),
			Name = _town.getName(),
			IsMilitary = _town.isMilitary(),
			IsSouthern = _town.isSouthern(),
			Situations = situations,
			Relation = relation,
			IsAlliedWithPlayer = isAllied,
			BuyPriceMult = _town.getBuyPriceMult(),
			SellPriceMult = _town.getSellPriceMult(),
			FoodPriceMult = _town.getFoodPriceMult(),
			function hasSituation( _id ) { return this.Situations.find(_id) != null; }
		};
	}

	// Context for a world location: its own settlement when it has one (attached
	// locations), otherwise the nearest town within _maxDistance tiles.
	function forLocation( _location, _maxDistance = null )
	{
		local parent = null;
		try { parent = _location.getSettlement(); }
		catch (error) {}
		if (::FU.Town.isValid(parent)) return ::FU.Town.getContext(parent, "parent");
		local town = ::FU.Town.nearest(_location.getTile(), _maxDistance);
		return town == null ? null : ::FU.Town.getContext(town, "nearest");
	}
};

::FU.GetTown <- ::FU.Town.get;
::FU.withTown <- ::FU.Town.with;
