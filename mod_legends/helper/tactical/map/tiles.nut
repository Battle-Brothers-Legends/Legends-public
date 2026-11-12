::Legends.Tactical <- {};
::Legends.Tactical.Tiles <- {};

::Legends.Tactical.Tiles.spawnWall <- function (_tile) {
	_tile.Level = 8;
	_tile.clear();
	_tile.spawnObject("entity/tactical/objects/wall");
}
