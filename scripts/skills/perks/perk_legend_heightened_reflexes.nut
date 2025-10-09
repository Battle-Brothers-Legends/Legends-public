this.perk_legend_heightened_reflexes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendHeightenedReflexes);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		local item = _skill.getItem();

		if (item != null && item.isItemType(this.Const.Items.ItemType.Defensive) && !item.isItemType(this.Const.Items.ItemType.Weapon))
			return;

		_properties.DamageTotalMult *= 1.0 + this.Math.floor(this.getContainer().getActor().getInitiative() * 0.0015);
	}
});

