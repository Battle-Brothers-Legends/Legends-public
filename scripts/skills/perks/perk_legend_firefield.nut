this.perk_legend_miasma <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_miasma";
		this.m.Name = this.Const.Strings.PerkName.LegendMiasma;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMiasma;
		this.m.Icon = "skills/active_100.png";
		this.m.IconDisabled = "skills/active_100_sw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_firefield_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_firefield_skill"));
		}
	}

});
