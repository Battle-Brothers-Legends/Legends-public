this.perk_legend_carnage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendCarnage);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
			return;

		if (_targetEntity.getSkills().hasEffect(::Legends.Effect.Bleeding) || _targetEntity.getSkills().hasEffect(::Legends.Effect.LegendGrazedEffect) && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			_properties.DamageRegularMin *= 1.2;
			_properties.DamageRegularMax *= 1.2;
		}
	}

	function onAdded()
	{
		if (!this.getContainer().getActor().isPlayerControlled())
		{
			return;
		}
		if (!this.getContainer().hasActive(::Legends.Active.LegendPrepareBleed))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrepareBleed);
		}
		if (!this.getContainer().hasActive(::Legends.Active.LegendPrepareGraze))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendPrepareGraze);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrepareBleed);
		::Legends.Actives.remove(this, ::Legends.Active.LegendPrepareGraze);
	}

});
