this.legend_patient_hunter_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TimeAdded = 0
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendPatientHunter);
		this.m.Description = "This character has carefully weighed their options and primed an attack with maximum effectiveness.";
		this.m.Icon = "ui/perks/patient_hunter.png";
		this.m.IconMini = "patient_hunter_mini";
		this.m.Overlay = "patient_hunter_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] Damage"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Ranged and Melee Skill"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]5%[/color] of damage ignores armor"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 1.1;
		_properties.RangedSkill += 5;
		_properties.MeleeSkill += 5;
		_properties.DamageDirectMult += 0.05;
		_properties.TargetAttractionMult *= 1.5;
	}

	function onAdded()
	{
		this.m.TimeAdded = this.Time.getVirtualTimeF();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_targetEntity.isAttackable())
			return;

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < this.Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
			this.removeSelf();
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.removeSelf();
	}
});
