this.perk_legend_mastery_poison <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecPoison);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendPoisonWeapon))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_poison_weapon_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendPoisonWeapon);
	}

	function onUpdate( _properties )
	{
		_properties.IsImmuneToPoison = true;
	}

});
