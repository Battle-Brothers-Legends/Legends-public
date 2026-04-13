this.perk_legend_vala_chanting_mastery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaChantMastery);
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}
});
