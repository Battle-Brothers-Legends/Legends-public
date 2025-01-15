::mods_hookExactClass("skills/actives/serpent_hook_skill", function(o)
{	
	local onUse = o.onUse;
	o.onUse = function ( _user, _targetTile )
	{
		ret = onUse( _user, _targetTile );
		if (ret && !_targetTile.getEntity().getSkills().hasSkill("effects.legend_break_stance"))
			_targetTile.getEntity().getSkills().add(this.new("scripts/skills/effects/legend_break_stance_effect"));
	}
});
