this.legend_RSW_unbreaking <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswUnbreaking);
		this.m.Description = "Rune Sigil: Unbreaking";
		this.m.Icon = "ui/rune_sigils/legend_rune_sigil.png";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}


	function onTargetKilled( _targetEntity, _skill )
	{
		if (this.getItem() == null)
		{
			return;
		}
		local item = this.getItem();
		local condition = item.getCondition();
		local conditionMax = item.getConditionMax();
		local bonusMin = item.getRuneBonus1();
		local bonusMax = item.getRuneBonus2();
		local repair = this.Math.rand(bonusMin, bonusMax);

		if ((conditionMax - condition) > repair )
		{
		item.setCondition(condition + repair)
		}
		else
		{
		item.setCondition(conditionMax);
		}
	}

});
