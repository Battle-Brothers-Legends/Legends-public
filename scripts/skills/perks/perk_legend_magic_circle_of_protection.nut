// TODO Edit strings.nut
this.perk_legend_magic_circle_of_protection <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendMagicCircleOfProtection);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendMagicCircleOfProtection))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendMagicCircleOfProtection);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendMagicCircleOfProtection);
	}

});
