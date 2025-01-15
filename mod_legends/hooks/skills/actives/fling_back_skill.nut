::mods_hookExactClass("skills/actives/fling_back_skill", function(o)
{
	local onPerformAttack = o.onPerformAttack;
	o.onPerformAttack = function ( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local target = _targetTile.getEntity();
		if (target == null)
			return false;

		if (target.getCurrentProperties().IsImmuneToKnockBackAndGrab)
			return false;

		if (!target.getSkills().hasSkill("effects.legend_break_stance"))
			target.getSkills().add(this.new("scripts/skills/effects/legend_break_stance_effect"));

		return onPerformAttack( _tag );
	}
});
