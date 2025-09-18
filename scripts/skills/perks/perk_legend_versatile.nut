this.perk_legend_versatile <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeBonus = false,
		RangedBonus = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendVersatile);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnEnd()
	{
		this.m.MeleeBonus = false;
		this.m.RangedBonus = false;
	}

	function onUpdate(_properties)
	{
		if (this.m.MeleeBonus)
			_properties.MeleeDamageMult *= 1.5;
		
		if (this.m.RangedBonus)
			_properties.MeleeDamageMult *= 1.5;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_skill == null)
			return;

		if (_skill.isRanged() && !this.m.MeleeBonus)
			this.m.MeleeBonus = true;

		if (!_skill.isRanged() && !this.m.RangedBonus)
			this.m.RangedBonus = true;

		if (_skill.isRanged() && this.m.RangedBonus)
			this.m.RangedBonus = false;

		if (!_skill.isRanged() && this.m.MeleeBonus)
			this.m.MeleeBonus = false;
	}
});
