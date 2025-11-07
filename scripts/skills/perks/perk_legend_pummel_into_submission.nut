this.perk_legend_pummel_into_submission <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendPummelIntoSubmission);
		this.m.Order = this.Const.SkillOrder.First + 2;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatigueDealtPerHitMult += 1.0;

		if (::Legends.S.skillEntityAliveCheck(_targetEntity)) {
			return;
		}

		local fatDamage = this.Const.Combat.FatigueReceivedPerHit * _properties.FatigueDealtPerHitMult + _targetEntity.getFatigueMax() * _properties.FatigueDealtAsPercentOfMaxFatigue;
		local p = _targetEntity.getCurrentProperties();
		fatDamage *= p.FatigueEffectMult;
		local overflow = this.Math.round(_targetEntity.getFatigue() + fatDamage * p.FatigueReceivedPerHitMult * _properties.FatigueLossOnAnyAttackMult) - _targetEntity.getFatigueMax();
		if (overflow > 0)
		{
			_properties.DamageRegularMin += overflow;
			_properties.DamageRegularMax += overflow;
		}
	}
});
