::mods_hookExactClass("skills/actives/swallow_whole_skill", function(o)
{
	o.onVerifyTarget = function ( _originTile, _targetTile )
	{
		local brothers = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);
		if (brothers.len() == 1)
		{
			return false;
		}

		local target = _targetTile.getEntity();
		if (target == null)
		{
			return false;
		}
		if (target.getFlags().has("IsSummoned"))
		{
			return false;
		}

		return this.skill.onVerifyTarget(_originTile, _targetTile) && _targetTile.getEntity().isPlayerControlled() && !_targetTile.getEntity().getCurrentProperties().IsImmuneToKnockBackAndGrab;
	}

	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		ret = onUse( _user, _targetTile );
		if (ret && !_targetTile.getEntity().getSkills().hasSkill("effects.legend_break_stance"))
				_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/legend_break_stance_effect"));
	}

});
