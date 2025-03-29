::mods_hookExactClass("skills/actives/raise_undead", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.Order = this.Const.SkillOrder.Any;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!this.MSU.Tile.canResurrectOnTile(_targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	o.spawnUndead = function ( _user, _tile )
	{
		local p = _tile.Properties.get("Corpse");
		p.Faction = _user.getFaction();
		if (p.Faction == this.Const.Faction.Player)
		{
			p.Faction = this.Const.Faction.PlayerAnimals;
		}
		local e = this.Tactical.Entities.onResurrect(p, true);

		if (e != null)
		{
			e.getSprite("socket").setBrush(_user.getSprite("socket").getBrush().Name);
		}
	}
});