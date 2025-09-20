::mods_hookNewObject("entity/tactical/tactical_entity_manager", function(o) {
	o.getActorsByFunction <- function( _function )
	{
		local ret = [];
		foreach (actor in this.getAllInstancesAsArray())
		{
			if (_function(actor)) ret.push(actor);
		}		
		return ret;
	}
	
	o.getAlliedActors <- function( _faction, _tile = null, _distance = null, _atDistance = false )
	{
		if (_tile != null && _tile.ID == 0)
		{
			::logError("The ID of _tile is 0 which means that the actor this tile was fetched from is not placed on map.");
			throw ::FU.Exception.InvalidValue(_tile);
		}

		return this.getActorsByFunction(function(_actor) {
			if (!_actor.isAlliedWith(_faction)) return false;
			if (_tile != null)
			{
				if (!_actor.isPlacedOnMap()) return false;
				local distance = _tile.getDistanceTo(_actor.getTile());
				if (distance > _distance || (_atDistance && distance != _distance)) return false;
			}
			return true;
		});
	}
	
	o.getHostileActors <- function( _faction, _tile = null, _distance = null, _atDistance = false )
	{
		if (_tile != null && _tile.ID == 0)
		{
			::logError("The ID of _tile is 0 which means that the actor this tile was fetched from is not placed on map.");
			throw ::FU.Exception.InvalidValue(_tile);
		}

		return this.getActorsByFunction(function(_actor) {
			if (_actor.isAlliedWith(_faction)) return false;
			if (_tile != null)
			{
				if (!_actor.isPlacedOnMap()) return false;
				local distance = _tile.getDistanceTo(_actor.getTile());
				if (distance > _distance || (_atDistance && distance != _distance)) return false;
			}
			return true;
		});
	}
	
	o.getFactionActors <- function( _faction, _tile = null, _distance = null, _atDistance = false )
	{
		if (_tile == null)
		{
			return clone this.getInstancesOfFaction(_faction);
		}
		else if (_tile.ID == 0)
		{
			::logError("The ID of _tile is 0 which means that the actor this tile was fetched from is not placed on map.");
			throw ::FU.Exception.InvalidValue(_tile);
		}
				
		local actors = this.getInstancesOfFaction(_faction);
		local ret = [];
		foreach (actor in actors)
		{
			if (!actor.isPlacedOnMap()) continue;
			local distance = _tile.getDistanceTo(actor.getTile());
			if (distance > _distance || (_atDistance && distance != _distance)) continue;
			ret.push(actor);			
		}
		return ret;
	}
	
	o.getNonFactionAlliedActors <- function( _faction, _tile = null, _distance = null, _atDistance = false )
	{
		if (_tile != null && _tile.ID == 0)
		{
			::logError("The ID of _tile is 0 which means that the actor this tile was fetched from is not placed on map.");
			throw ::FU.Exception.InvalidValue(_tile);
		}

		return this.getActorsByFunction(function(_actor) {
			if (!_actor.isAlliedWith(_faction) || _actor.getFaction() == _faction) return false;
			if (_tile != null)
			{
				if (!_actor.isPlacedOnMap()) return false;
				local distance = _tile.getDistanceTo(_actor.getTile());
				if (distance > _distance || (_atDistance && distance != _distance)) return false;
			}
			return true;
		});
	}
});
