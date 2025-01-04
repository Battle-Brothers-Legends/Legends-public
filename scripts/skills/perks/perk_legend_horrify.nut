this.perk_legend_horrify <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendHorrify);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_horrific_scream"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_horrific_scream"));
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasSkill("perk.legend_item_horrify"))
		{
			this.m.Container.removeByID("actives.legend_horrific_scream");
		}
	}

});
