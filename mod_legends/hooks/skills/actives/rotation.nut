::mods_hookExactClass("skills/actives/rotation", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;
		
		local target = _targetTile.getEntity();

		if (!target.isAlive() && ::MSU.isNull(target))
			return false;

		if (!target.isPlayerControlled() && target.getFaction() != this.Const.Faction.PlayerAnimals)
			return false;

		if (!target.isAlliedWith(this.getContainer().getActor()) && !this.getContainer().hasSkill("perk.legend_twirl"))
			return false;

		return this.skill.onVerifyTarget(_originTile, _targetTile) && !target.getCurrentProperties().IsStunned && !target.getCurrentProperties().IsRooted && target.getCurrentProperties().IsMovable && !target.getCurrentProperties().IsImmuneToRotation;
	}
});
