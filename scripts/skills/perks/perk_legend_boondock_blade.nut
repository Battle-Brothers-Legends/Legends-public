this.perk_legend_boondock_blade <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendBoondockBlade);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isHidden())
		{
			_properties.MeleeDefense += 10;
			_properties.RangedDefense += 10;
			_properties.MeleeSkill += 10;
			_properties.RangedSkill += 10;
		}
	}

});

