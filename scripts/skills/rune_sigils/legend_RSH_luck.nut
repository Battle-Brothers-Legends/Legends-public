this.legend_RSH_luck <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRshLuck);
		this.m.Description = "Rune Sigil: Luck";
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

		_properties.RerollDefenseChance += this.getItem().getRuneBonus1();
	}
});
