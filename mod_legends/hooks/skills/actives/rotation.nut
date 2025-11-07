::mods_hookExactClass("skills/actives/rotation", function(o)
{
	local create = o.create;
	o.create = function ()
	{
		create();
		this.m.FatigueCost = 20;
	}

	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		if (!_targetTile.IsOccupiedByActor)
			return false;

		local target = _targetTile.getEntity();
		local actor = this.getContainer().getActor();
		local setting = ::Legends.Mod.ModSettings.getSetting("AiRotation").getValue();

		if (actor.getFaction() != this.Const.Faction.Player && setting == "Disabled")
			return false;

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
			if (setting == "Limited" || (setting && !canRotate))
			{
				return false;
			}
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile);
	}

	o.onAfterUpdate = function (_properties)
	{ // fix vanilla bullshit with hard setting fat cost in onAfterUpdate
		_properties.SkillCostAdjustments.push({
			ID = this.m.ID,
			APAdjust = this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion") ? -1 : 0,
			FatigueMultAdjust = _properties.IsFleetfooted ? 0.5 : 1.0
		});
	}
});
