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
});
