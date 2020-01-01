this.perk_legend_peaceful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_peaceful";
		this.m.Name = this.Const.Strings.PerkName.LegendPeaceful;
		this.m.Description = this.Const.Strings.PerkDescription.LegendPeaceful;
		this.m.Icon = "ui/perks/peaceful_circle.png";
		this.m.IconDisabled = "ui/perks/peaceful_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
	}



});
