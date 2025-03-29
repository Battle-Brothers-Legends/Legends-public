::Const.LegendMod.Hex <- {};

::Const.LegendMod.Hex.Directions <- {
	North = 0,
	NorthEast = 1,
	SouthEast = 2,
	South = 3,
	SouthWest = 4,
	NorthWest = 5
}

::Const.LegendMod.Hex.Neighbors <- [
	[0,1],
	[1,0],
	[1,-1],
	[0,-1],
	[-1,0],
	[-1,1]
];

::Const.LegendMod.Hex.getAdjacentHexCoords <- function ( _coords, _i )
{
	// _coords must be a table with keys X and Y representing hex coordinates
	return {
		X = _coords.X + ::Const.LegendMod.Hex.Neighbors[_i][0], 
		Y = _coords.Y + ::Const.LegendMod.Hex.Neighbors[_i][1]
	};
}

// Convert Y-value in square coodinates system to Y-value in hexagonal coordinates system
::Const.LegendMod.Hex.getHexFromSquareY <- function ( _x, _y )
{
	return _y - _x / 2; // integer division because we want the floor
}

// Note: the _center parameter and the so-called "coordinate tables" used in multiple functions in this script are expected to be a table containing the following:
// {
// 	X = integer, // representing a hexagonal X-coordinate
// 	Y = integer, // representing a hexagonal Y-coordinate
// }

// Developed based on notes from https://www.redblobgames.com/grids/hexagons/#rings
// Traverse a circle of radius _radius around _center (X and Y hexagonal coordinates)
// Returns an array of the coordinate tables representing all the tiles that were traversed
::Const.LegendMod.Hex.traverseCircle <- function ( _center, _radius, _minSquareX = null, _minSquareY = null, _maxSquareX = null, _maxSquareY = null)
{
	if (_radius < 0)
	{
		::logError(format("_radius (%s) must be at least 0. Returning result of _radius=0 instead.", _radius.tostring()));
		return [_center];
	}

	if (_radius == 0)
	{
		return [_center];
	}

	local path = []; // store the path of coords taken to traverse the full circle
	local garbage = []; // to later remove any coords that fall outside of the allowed range
	local start = _center; // expect a table with keys X and Y representing hex coordinates
	for (local i = 0; i < _radius; i++)
	{
		start = ::Const.LegendMod.Hex.getAdjacentHexCoords(start, ::Const.LegendMod.Hex.Directions.SouthWest);
	}

	local next = start;
	for (local i = 0; i < 6; i++)
	{
		for (local j = 0; j < _radius; j++)
		{
			next = ::Const.LegendMod.Hex.getAdjacentHexCoords(next, i);
			
			if ( (_minSquareX != null && next.X < _minSquareX) || (_minSquareY != null && next.Y < ::Const.LegendMod.Hex.getHexFromSquareY(next.X, _minSquareY)) || (_maxSquareX != null && next.X > _maxSquareX) || (_maxSquareY != null && next.Y > ::Const.LegendMod.Hex.getHexFromSquareY(next.X, _maxSquareY) ))
			{
				// Exceeded the bounds; don't add to the path but continue traversing
				continue;
			}
			else
			{
				path.push(next);
			}	
		}
	}

	return path;
}

// Traverses all tiles in circles of radii between _minRadius and _maxRadius around _center coordinates,
// then return a table with the following:
// {
// 		R0 = [], // Array containing the coordinate table of the center tile (if applicable)
// 		R1 = [], // Array containing the coordinate tables of all tiles in a circle of radius 1 around _center
// 		... // RN keys depending on the range of _minRadius to _maxRadius, where N is the radius of the circle that was traversed
// 		Count = integer, // The total number of tiles
// 		MinR = integer, // The minimum radius, ie of the smallest circle that was traversed
// 		MaxR = integer // The maximum radius, ie of the largest circle that was traversed
// }
::Const.LegendMod.Hex.getCoordsWithinRadius <- function ( _center, _maxRadius, _minRadius = 0, _minSquareX = null, _minSquareY = null, _maxSquareX = null, _maxSquareY = null)
{
	if (_minRadius > _maxRadius)
	{
		::logError(format("_minRadius of %s should not be greater than _maxRadius of %s", _minRadius.tostring(), _maxRadius.tostring()));
	}

	local ret = {};
	local count = 0;

	for (local i = _minRadius; i <= _maxRadius; i++)
	{
		ret["R" + i] <- ::Const.LegendMod.Hex.traverseCircle( _center, i, _minSquareX, _minSquareY, _maxSquareX, _maxSquareY);
		count += ret["R" + i].len();
	}

	ret["Count"] <- count;
	ret["MinR"] <- _minRadius;
	ret["MaxR"] <- _maxRadius;

	return ret;
}

// Calculate the total number of hexes within a circular area with radius = _radius
::Const.LegendMod.Hex.getTotalHexesWithinRadius <- function ( _radius )
{
	return 1 + 3 * _radius * ( _radius + 1 );
}

// ------------- World ------------------
::Const.LegendMod.Hex.World <- {};

// Return an array of World Tiles within _radius of _centerTile
::Const.LegendMod.Hex.World.getTilesWithinRadius <- function ( _centerTile, _maxRadius, _minRadius = 0, _minSquareX = 0, _minSquareY = 0, _maxSquareX = null, _maxSquareY = null)
{
	// World-safe default limits
	if (_maxSquareX == null)
	{
		_maxSquareX = ::World.getMapSize().X - 1;
	}

	if (_maxSquareY == null)
	{
		_maxSquareY = ::World.getMapSize().Y - 1;
	}

	// Actual logic
	local ret = [];
	local center = {
		X = _centerTile.Coords.X,
		Y = _centerTile.Coords.Y,
	}
	local coordsTable = ::Const.LegendMod.Hex.getCoordsWithinRadius( center, _maxRadius, _minRadius, _minSquareX, _minSquareY, _maxSquareX, _maxSquareY );
	for (local i = _minRadius; i <= _maxRadius; i++)
	{
		foreach( coords in coordsTable["R" + i] )
		{
			ret.push(::World.getTile(coords.X, coords.Y))
		}
	}

	return ret;
}

// Return an array of World Tiles of types that match the input terrain types in _types within _radius of _centerTile
::Const.LegendMod.Hex.World.getTilesWithinRadiusOfTypes <- function ( _centerTile, _types, _maxRadius, _minRadius = 0, _minSquareX = 0, _minSquareY = 0, _maxSquareX = null, _maxSquareY = null)
{
	// World-safe default limits
	if (_maxSquareX == null)
	{
		_maxSquareX = ::World.getMapSize().X - 1;
	}

	if (_maxSquareY == null)
	{
		_maxSquareY = ::World.getMapSize().Y - 1;
	}

	// Actual logic
	local ret = [];
	local tiles = ::Const.LegendMod.Hex.World.getTilesWithinRadius( _centerTile, _maxRadius, _minRadius, _minSquareX, _minSquareY, _maxSquareX, _maxSquareY );
	foreach (t in tiles)
	{
		if (_types.find(t.Type) != null)
		{
			ret.push(t);
		}
	}
	return ret;
}

// Return an array of coordinates (tables with X and Y keys) whose corresponding tiles match the input terrain types in _types within _radius of _center coordinates
::Const.LegendMod.Hex.World.getCoordsWithinRadiusOfTypes <- function ( _center, _types, _maxRadius, _minRadius = 0, _minSquareX = 0, _minSquareY = 0, _maxSquareX = null, _maxSquareY = null)
{
	// World-safe default limits
	if (_maxSquareX == null)
	{
		_maxSquareX = ::World.getMapSize().X - 1;
	}

	if (_maxSquareY == null)
	{
		_maxSquareY = ::World.getMapSize().Y - 1;
	}

	local ret = [];
	local coordsTable = ::Const.LegendMod.Hex.getCoordsWithinRadius( _center, _maxRadius, _minRadius, _minSquareX, _minSquareY, _maxSquareX, _maxSquareY );
	for (local i = _minRadius; i <= _maxRadius; i++)
	{
		foreach( coords in coordsTable["R" + i] )
		{
			if (_types.find(::World.getTile(coords.X, coords.Y).Type) != null)
			{
				ret.push(coords);
			}
		}
	}

	return ret;
}

// Returns a table where the Data field is an array storing Tiles organized by _radius (distance from _centerTile) and Type (see)
// Example of what the Data field might look like with radius=2, assuming no tiles have been added yet:
	// [
	// 	// i=0: Center Tile
	// 	// Array of length ::Const.World.TerrainType.COUNT containing arrays containing Tiles
	// 	[
	// 		[], // Tiles where Type = 0
	// 		[], // Tiles where Type = 1
	// 		...
	// 		[], // Tiles where Type = (total number of Terrain Types)
	// 	], 
	// 	// i=1: Tiles along the path of a circle where radius=1
	// 	// Array of length ::Const.World.TerrainType.COUNT containing arrays containing Tiles
	// 	[
	// 		[], // Tiles where Type = 0
	// 		[], // Tiles where Type = 1
	// 		...
	// 		[], // Tiles where Type = (total number of Terrain Types)
	// 	],	
	// 	// i=2: Tiles along the path of a circle where radius=2
	// 	// Array of length ::Const.World.TerrainType.COUNT containing arrays containing Tiles
	// 	[
	// 		[], // Tiles where Type = 0
	// 		[], // Tiles where Type = 1
	// 		...
	// 		[], // Tiles where Type = (total number of Terrain Types)
	// 	],
	// ]
// The output table also contains some functions to extract desired data from Data
::Const.LegendMod.Hex.World.getTilesWithinRadiusOrganizedByRadiusAndType <- function ( _centerTile, _radius, _minSquareX = 0, _minSquareY = 0, _maxSquareX = null, _maxSquareY = null )
{
	// World-safe default limits
	if (_maxSquareX == null)
	{
		_maxSquareX = ::World.getMapSize().X - 1;
	}

	if (_maxSquareY == null)
	{
		_maxSquareY = ::World.getMapSize().Y - 1;
	}

	// Actual logic begins
	local data = array(_radius + 1); // each entry in this array represents a ring around the center tile; index 0 is the center tile
	local center = {
		X = _centerTile.Coords.X,
		Y = _centerTile.Coords.Y,
	}

	// For each ring, store an array where the index corresponds to a TerrainType, and the value is an array of all Tiles of that TerrainType
	for (local i = 0; i <= _radius; i++)
	{
		local types = array(::Const.World.TerrainType.COUNT).map(function(val){return []});

		// Traverse the ring at radius=i and organize according to Tile type
		local path = ::Const.LegendMod.Hex.traverseCircle(center, i, _minSquareX, _minSquareY, _maxSquareX, _maxSquareY);
		foreach (coords in path)
		{
			local tile = ::World.getTile(coords.X, coords.Y);
			types[tile.Type].push(tile);
		}

		data[i] = types;
	}

	local ret = {
		
		Data = data,

		// Return an array where:
		// The index is the radius. (index = 0 is the center tile)
		// The value is an array containing Tiles whose Type match those in _types
		filterByTypes = function(_types)
		{
			return this.Data.map(
				function(arr)
				{
					local tiles = [];
					for (local i = 0; i < arr.len(); i++)
					{
						if (_types.find(i) != null)
						{
							tiles.extend(arr[i]);
						}
					}
					return tiles;
				}
			);
		},

		// Return an array of all Tiles whose Type match those in _types, between _minRadius and _maxRadius inclusively
		getTilesOfTypesBetweenRadius = function(_types, _maxRadius, _minRadius = 0)
		{
			local data = this.filterByTypes(_types);
			_maxRadius = ::Math.min(data.len()-1, _maxRadius);
			_minRadius = ::Math.max(0, _minRadius);
			local slice = data.slice(_minRadius, _maxRadius + 1);
			local ret = [];
			foreach(arr in slice)
			{
				ret.extend(arr);
			}
			return ret;
		}

		// Return a float representing the proportion of Tiles whose Type match those in _types, between _minRadius and _maxRadius inclusively, out of all Tiles in the range
		getProportionOfTypesBetweenRadius = function(_types, _maxRadius, _minRadius = 0)
		{
			local data = this.filterByTypes(_types);
			_maxRadius = ::Math.min(data.len()-1, _maxRadius);
			_minRadius = ::Math.max(0, _minRadius);
			local total = _minRadius == 0 ? (::Const.LegendMod.Hex.getTotalHexesWithinRadius(_maxRadius)) : (::Const.LegendMod.Hex.getTotalHexesWithinRadius(_maxRadius) - ::Const.LegendMod.Hex.getTotalHexesWithinRadius(_minRadius - 1));
			local valid = this.getTilesOfTypesBetweenRadius(_types, _maxRadius, _minRadius).len();
			return valid / (total * 1.0);
		}

		// Return an integer of the total number of tiles whose Type match those in _types, between _minRadius and _maxRadius inclusively
		getCountOfTypesBetweenRadius = function(_types, _maxRadius, _minRadius = 0)
		{
			return this.getTilesOfTypesBetweenRadius(_types, _maxRadius, _minRadius).len();
		}
	}

	return ret;
}