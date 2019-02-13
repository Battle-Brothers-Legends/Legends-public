this.perk_legend_possess_undead <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_possess_undead";
		this.m.Name = this.Const.Strings.PerkName.LegendPossessUndead;
		this.m.Description = this.Const.Strings.PerkDescription.LegendPossessUndead;
		this.m.Icon = "skills/posess56_square.png";
		this.m.IconDisabled = "ui/perks/posess56_square_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_possess_undead"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_possess_undead_skill"));
		}
	}
	
	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_possess_undead");
	}

});
