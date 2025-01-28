this.legend_RSH_bravery <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRshBravery);
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
		if (this.getItem() == null)
		{
			return;
		}
		_properties.Bravery *= (1.0 + ((this.getItem().getRuneBonus1() * 1.0) / 100.0));
		_properties.MoraleCheckBravery[0] += this.getItem().getRuneBonus2();
		_properties.MoraleCheckBravery[1] += this.getItem().getRuneBonus2();
		_properties.MoraleCheckBravery[2] += this.getItem().getRuneBonus2();
	}
});
