this.legend_RSS_durability <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRssDurability);
		this.m.Description = "Rune Sigil: Durability";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onAdded() {
		local item = this.getItem();
		local rune = ::Legends.Runes.get(::Legends.Rune.LegendRssDurability);
		local extraDurability = item.getFlags().getAsInt(rune.Flag);
		item.m.Condition += item.getRuneBonus1() - extraDurability;
		item.m.ConditionMax += item.getRuneBonus1() - extraDurability;
		item.getFlags().set(rune.Flag, item.getRuneBonus1());
		item.updateAppearance();
	}
});
