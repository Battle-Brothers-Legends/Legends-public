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
		if (!this.m.Container.hasSkill("actives.legend_enthrall"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_enthrall_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_enthrall");
	}

});
