::mods_hookExactClass("skills/perks/perk_mastery_throwing", function(o) {
	o.m.EligibleSkills <- [
		::Legends.Active.ThrowAxe,
		::Legends.Active.ThrowBalls,
		::Legends.Active.ThrowJavelin,
		::Legends.Active.ThrowSpear,
		::Legends.Active.LegendThrowKnife
	];

	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill.isRanged())
		{
			local d = this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile());
			foreach (skill in this.m.EligibleSkills)
			{
				if (_skill.getID() == ::Legends.Actives.getID(skill))
				{
					if (d <= 2)
					{
						_properties.DamageTotalMult *= 1.3;
					}
					else if (d <= 3)
					{
						_properties.DamageTotalMult *= 1.2;
					}
					break;
				}
			}
		}
	}
});
