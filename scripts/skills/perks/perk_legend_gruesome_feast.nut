this.perk_legend_gruesome_feast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendGruesomeFeast);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_gruesome_feast"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_gruesome_feast_skill"));
		}
	}

	function onRemoved()
	{
		if (!this.m.Container.hasSkill("perk.legend_item_gruesome_feast"))
		{
			this.m.Container.removeByID("actives.legend_gruesome_feast");
		}
	}

});
