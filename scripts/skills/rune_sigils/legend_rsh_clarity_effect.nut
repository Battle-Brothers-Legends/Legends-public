this.legend_rsh_clarity_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRshClarity);
		this.m.Description = "Rune Sigil: Clarity";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate (_properties) {
		if (this.getItem() == null)
			return;
		_properties.Vision += this.getItem().getRuneBonus1();
		_properties.XPGainMult *=  (1.0 + ((this.getItem().getRuneBonus2() * 1.0) / 100.0));
	}
});
