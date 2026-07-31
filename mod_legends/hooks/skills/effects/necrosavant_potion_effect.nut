::mods_hookExactClass("skills/effects/necrosavant_potion_effect", function(o) {
	local onTargetHit = o.onTargetHit;
	o.onTargetHit = function ( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (::Legends.S.isEntityNullOrDead(_targetEntity))
			return;

		if ( _targetEntity.getCurrentProperties().IsImmuneToBleeding)
			return;

		onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
	}
});
