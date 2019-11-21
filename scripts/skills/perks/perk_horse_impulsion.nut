this.perk_legend_horse_impulsion <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_horse_impulsion";
		this.m.Name = this.Const.Strings.PerkName.LegendHorseImpulsion;
		this.m.Description = this.Const.Strings.PerkDescription.LegendHorseImpulsion;
		this.m.Icon = "ui/perks/perk_08.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativlMult *= 1.25;
	}

});

