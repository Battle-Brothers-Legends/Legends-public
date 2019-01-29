this.perk_perfect_focus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.perfect_focus";
		this.m.Name = this.Const.Strings.PerkName.PerfectFocus;
		this.m.Description = this.Const.Strings.PerkDescription.PerfectFocus;
		this.m.Icon = "ui/perks/perk_37.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.perfect_focus"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/perfect_focus"));
		}
	}

	function onUpdated( _properties )
	{
		_properties.TargetAttractionMult *= 1.33000004;
	}

});
