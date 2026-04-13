this.perk_legend_vala_spiritual_bond <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaSpiritualBond);
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}
});
