this.legend_RSW_power <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswPower);
		this.m.Description = "Rune Sigil: Power";
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
		_properties.DamageTotalMult *= (1.0 + ((this.getItem().getRuneBonus1() * 1.0) / 100.0));
		_properties.DamageRegularMax += this.getItem().getRuneBonus2();
	}
});
