::mods_hookExactClass("skills/perks/perk_overwhelm", function(o) {

	local onTargetMissed = o.onTargetMissed;
	o.onTargetMissed = function ( _skill, _targetEntity )
	{
		if (!_targetEntity.isAttackable())
			return;
		onTargetMissed( _skill, _targetEntity );
	}
});
