this.perk_legend_summon_falcon <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSummonFalcon);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendFalcon))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_falcon_skill"));
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendFalcon);
	}


});
