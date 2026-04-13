this.perk_legend_vala_trance_mastery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaTranceMastery);
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}
});
