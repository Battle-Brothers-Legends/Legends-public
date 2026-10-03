this.legend_rsw_unbreaking_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendRswUnbreaking);
		this.m.Description = "Rune Sigil: Unbreaking";
		this.m.Type = ::Const.SkillType.Special | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}


	function onTargetKilled( _targetEntity, _skill ) {
		if (this.getItem() == null)
			return;
		local item = this.getItem();
		local condition = item.getCondition();
		local conditionMax = item.getConditionMax();
		local bonusMin = item.getRuneBonus1();
		local bonusMax = item.getRuneBonus2();
		local repair = ::Math.rand(bonusMin, bonusMax);

		if ((conditionMax - condition) > repair ) {
			item.setCondition(condition + repair)
		}
		else {
			item.setCondition(conditionMax);
		}
	}

});
