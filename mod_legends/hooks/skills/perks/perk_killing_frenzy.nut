::mods_hookExactClass("skills/perks/perk_killing_frenzy", function(o) {
	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			local effect = this.getContainer().getActor().getSkills().getSkillByID("effects.killing_frenzy");

			if (effect != null)
			{
				effect.resetTime();
			}
			else
			{
				::Legends.Effects.grant(this, ::Legends.Effect.KillingFrenzy);
			}
		}
	}
});