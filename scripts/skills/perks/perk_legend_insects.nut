this.perk_legend_insects <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendInsects);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.insects_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/insects_skill"));
		}
	}
		function onRemoved()
	{
		this.m.Container.removeByID("actives.insects_skill");
	}

});
