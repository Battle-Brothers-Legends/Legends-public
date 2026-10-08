this.perk_legend_vala_chant_mastery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendValaChantMastery);
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsHidden = true;
	}
});
