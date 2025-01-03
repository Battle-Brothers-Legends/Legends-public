this.perk_legend_darkflight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendDarkflight);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_darkflight"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/legend_darkflight_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_darkflight");
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});
