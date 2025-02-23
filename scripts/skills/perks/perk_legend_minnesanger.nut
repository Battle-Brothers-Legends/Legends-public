this.perk_legend_minnesanger <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_minnesanger";
		this.m.Name = this.Const.Strings.PerkName.LegendMinnesanger;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMinnesanger;
		this.m.Icon = "ui/perks/sling_01.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});
