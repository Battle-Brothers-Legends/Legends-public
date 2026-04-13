::Legends.Maps.markVisited <- function(_target) {
	if (_target == null)
		return;
	if (typeof _target == "table") {
		::World.Flags.add("LegendsMap-" + _target.Target);
	} else {
		::World.Flags.add("LegendsMap-" + _target);
	}
}

::Legends.Maps.isVisited <- function (_target) {
	if (_target == null)
		return false;
	if (typeof _target == "table") {
		return ::World.Flags.has("LegendsMap-" + _target.Target);
	} else {
		return ::World.Flags.has("LegendsMap-" + _target);
	}
}

::Legends.Maps.getAll <- function() {
	return ::World.Assets.getStash().getItems()
		.filter(@(idx, item) item != null && (item.m.ID == ::Legends.Maps.Type.Legendary || item.m.ID == ::Legends.Maps.Type.Named));
}

::Legends.Maps.removeLegendary <- function(_target) {
	foreach(map in ::Legends.Maps.getAll().filter(@(idx, item) item.m.ID == ::Legends.Maps.Type.Legendary && item.m.Target == _target))
		::World.Assets.getStash().remove(map);
}

::Legends.Maps.removeNamed <- function(_target) {
	foreach(map in ::Legends.Maps.getAll().filter(@(idx, item) item.m.ID == ::Legends.Maps.Type.Named && !::Legends.S.isNull(item.m.Target) && item.m.Target.getID() == _target))
		::World.Assets.getStash().remove(map);
}

::Legends.Maps.getVisitedLegendaryLocations <- function() {
	return ::Legends.Maps.Locations.filter(@(idx, location) ::Legends.Maps.isVisited(location));
}

::Legends.Maps.getNotVisitedLegendaryLocations <- function() {
	return ::Legends.Maps.Locations.filter(@(idx, location) !::Legends.Maps.isVisited(location));
}

::Legends.Maps.getSpawnedLegendaryLocation <- function(_target) {
	local locations = ::Legends.Maps.getSpawnedLegendaryLocations().filter(@(idx, location) location.getTypeID() == _target);
	if (locations.len() == 0)
		return null;
	return locations[0];
}

::Legends.Maps.getSpawnedLegendaryLocations <- function() {
	return ::World.EntityManager.m.Locations.filter(@(idx, location) location != null && location.isLocationType(::Const.World.LocationType.Unique));
}

/*
* Called when location is destroyed. Removes already completed maps from stash.
*/
::Legends.Maps.cleanUpOnLocationDestroyed <- function(_location) {
	foreach (location in ::Legends.Maps.Locations) {
		if (_location.m.TypeID == location.Target) {
			::Legends.Maps.markVisited(_location.getTypeID());
			::Legends.Maps.removeLegendary(_location.getTypeID());
			return;
		}
	}
	::Legends.Maps.removeNamed(_location.getID());
}

/*
* Removes already completed maps from stash.
*/
::Legends.Maps.cleanUp <- function() {
	local visitedLocations = ::Legends.Maps.getVisitedLegendaryLocations();
	local maps = ::Legends.Maps.getAll().filter(@(idx, item) item.m.ID == ::Legends.Maps.Type.Legendary);
	foreach (map in maps) {
		foreach (location in visitedLocations) {
			if (map.m.Target == location) {
				::World.Assets.getStash().remove(map);
			}
		}
	}
}

::Legends.Maps.generateLegendary <- function() {
	local filteredLocations = [];
	local spawnedLocations = ::Legends.Maps.getSpawnedLegendaryLocations();
	local locations = ::Legends.Maps.Locations;
	foreach (spawned in spawnedLocations) {
		local spawnedLocation = null;
		foreach (location in locations) {
			if (spawned.m.TypeID == location.Target) {
				spawnedLocation = location;
				break;
			}
		}
		if (spawnedLocation != null) {
			filteredLocations.push(spawnedLocation);
		}
	}
	// filter out visited locations
	local visitedLocations = ::Legends.Maps.getVisitedLegendaryLocations();
	foreach(visited in visitedLocations) {
		foreach(location in filteredLocations) {
			if (location.Target == visited) {
				local idx = filteredLocations.find(location);
				if (idx != null)
					filteredLocations.remove(idx);
				break;
			}
		}
	}
	// filter out owned maps
	local ownedMaps = ::Legends.Maps.getAll().filter(@(idx, item) item.m.ID == ::Legends.Maps.Type.Legendary);
	foreach (owned in ownedMaps) {
		foreach (location in filteredLocations) {
			if (location.Target == owned.m.Target) {
				local idx = filteredLocations.find(location);
				if (idx != null)
					filteredLocations.remove(idx);
				break;
			}
		}
	}

	if (filteredLocations.len() == 0) {
		return { Target = "x", Name = null }
	} else {
		return filteredLocations[::Math.rand(0, filteredLocations.len() - 1)];
	}
}
