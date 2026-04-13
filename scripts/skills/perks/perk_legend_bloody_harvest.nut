this.perk_legend_bloody_harvest <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendBloodyHarvest);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack())
		{
			local bonus = this.Math.round(_skill.getFatigueCost() * 0.5);
			_properties.DamageTotalMult *= 1.0 + 0.01 * bonus;
			_properties.MeleeSkill += bonus;
			_properties.RangedSkill += bonus;
			if (!_skill.isUsingHitchance())
				return;
			if (!_skill.isRanged())
			{
				_skill.m.HitChanceBonus += bonus;
			}
			else if (_skill.isRanged())
			{
				if (::MSU.isIn("AdditionalAccuracy", _skill.m, true)) {
					_skill.m.AdditionalAccuracy += bonus;
				} else {
					::logError("AdditionalAccuracy not found in skill")
				}
			}
		}
	}

});

