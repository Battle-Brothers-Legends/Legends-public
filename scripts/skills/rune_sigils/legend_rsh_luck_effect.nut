this.legend_rsh_luck_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRshLuck);
		this.m.Description = "Rune Sigil: Luck";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate (_properties) {
		if (this.getItem() == null)
			return;

		_properties.RerollDefenseChance += this.getItem().getRuneBonus1();
	}
});
