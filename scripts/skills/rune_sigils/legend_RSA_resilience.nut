this.legend_RSA_resilience <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRsaResilience);
		this.m.Description = "Rune Sigil: Resilience";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate (_properties)
	{
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}
});
