this.legend_magic_skill <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0,
		DamageInitiativeMin = 0,
		DamageInitiativeMax = 0,
		DamageInitiativeCutoff = 100
	},

	function create()
	{

	}

	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function onUpdate( _properties )
	{
		_properties.DamageInitiativeMin = this.m.DamageInitiativeMin;
		_properties.DamageInitiativeMax = this.m.DamageInitiativeMax;
		_properties.DamageInitiativeCutoff = this.m.DamageInitiativeCutoff;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin = _properties.getInitiativeMinDamage();
			_properties.DamageRegularMax = _properties.getInitiativeMaxDamage();
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.MeleeSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

});
