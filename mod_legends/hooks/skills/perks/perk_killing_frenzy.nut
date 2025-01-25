::mods_hookExactClass("skills/perks/perk_killing_frenzy", function(o) {
	o.onTargetKilled = function ( _targetEntity, _skill )
	{
		if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			local effect = ::Legends.Effects.get(this, ::Legends.Effect.KillingFrenzy);

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
