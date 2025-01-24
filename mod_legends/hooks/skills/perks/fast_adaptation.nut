::mods_hookExactClass("skills/perks/perk_fast_adaption", function(o) {

	local onTargetHit = o.onTargetHit;
	o.onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity != null && this.isKindOf(_targetEntity, "actor"))
		{
			local actor = this.getContainer().getActor();
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + this.Math.min(3, this.m.Stacks)));
		}

		onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor );
	}
});