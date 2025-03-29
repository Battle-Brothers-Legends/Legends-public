::mods_hookExactClass("skills/actives/barbarian_fury_skill", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
		{
			return false;
		}

		local target = _targetTile.getEntity();
		if (::MSU.isNull(target) || !target.isAlive())
			return false;

		if (!target.isAlliedWith(this.getContainer().getActor()))
			return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}
});
