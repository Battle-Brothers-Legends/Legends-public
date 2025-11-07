this.perk_legend_double_strike <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendDoubleStrike);
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();

		if (!_targetEntity.isAlliedWith(actor) && !actor.getSkills().hasEffect(::Legends.Effect.DoubleStrike))
		{
			::Legends.Effects.grant(actor, ::Legends.Effect.DoubleStrike);
		}
	}

});

