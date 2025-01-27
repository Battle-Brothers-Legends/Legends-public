this.perk_legend_enthrall <- this.inherit("scripts/skills/skill", {
	m = {
		RangeIncrease = 1
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendEnthrall);
		this.m.Icon = "ui/perks/possess56.png";
		this.m.IconDisabled = "ui/perks/possess56_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasActive(::Legends.Active.LegendEnthrall))
		{
			::Legends.Actives.grant(this, ::Legends.Active.LegendEnthrall);
		}
	}

	function onRemoved()
	{
		::Legends.Actives.remove(this, ::Legends.Active.LegendEnthrall);
	}

});
