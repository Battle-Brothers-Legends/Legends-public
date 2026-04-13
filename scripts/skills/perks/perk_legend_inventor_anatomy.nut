this.perk_legend_inventor_anatomy <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendInventorAnatomy);
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
		this.m.IsSerialized = true;
	}
});
