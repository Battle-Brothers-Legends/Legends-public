this.legend_RSH_bravery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.legend_RSH_bravery";
		this.m.Name = "Rune Sigil: Bravery";
		this.m.Description = "Rune Sigil: Bravery";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}


	function onUpdate (_properties)
	{
		_properties.Bravery *= 1.08 + (this.m.Item.RuneMultiplier / 100.0);
		_properties.MoraleCheckBravery[0] += 3.0 + this.m.Item.RuneMultiplier;
		_properties.MoraleCheckBravery[1] += 3.0 + this.m.Item.RuneMultiplier;
		_properties.MoraleCheckBravery[2] += 3.0 + this.m.Item.RuneMultiplier;
	}
});
