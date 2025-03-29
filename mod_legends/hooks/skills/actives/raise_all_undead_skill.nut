::mods_hookExactClass("skills/actives/raise_all_undead_skill", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (this.MSU.Tile.canResurrectOnTile(_targetTile, true))
		{
			return false;
		}

		return true;
	}
});
