::mods_hookExactClass("skills/actives/rotation", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;

		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();

		if (!target.isAlive() && ::MSU.isNull(target))
			return false;

		if (target.getCurrentProperties().IsStunned)
			return false;

		if (target.getCurrentProperties().IsRooted)
			return false;

		if (!target.getCurrentProperties().IsMovable)
			return false;

		if (target.getCurrentProperties().IsImmuneToRotation)
			return false;

		local canRotate = target.isAlliedWith(this.getContainer().getActor()) || this.getContainer().hasPerk(::Legends.Perk.LegendTwirl);
		local setting = ::Legends.Mod.ModSettings.getSetting("AiRotation").getValue();
		if (!canRotate)
			return false;

		if (actor.getFaction() != this.Const.Faction.Player && target.getFaction() == this.Const.Faction.Player)
		{
			if (setting == "Disabled" || (setting && !canRotate))
			{
				return false;
			}
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}
});
