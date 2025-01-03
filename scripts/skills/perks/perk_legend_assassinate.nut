this.perk_legend_assassinate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		//All effects of this perk are contained within hidden_effect.nut
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendAssassinate);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

});

