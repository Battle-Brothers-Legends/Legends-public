this.perk_legend_patient_hunter <- this.inherit("scripts/skills/skill", {
	m = {
		IsEffectActive = false
	},
	function create()
	{
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendPatientHunter);
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
	
	function activate()
	{
		this.m.IsEffectActive = true;
	}
	
	function isHidden()
	{
		return !this.m.IsEffectActive;
	}
	
	function getDescription()
	{
		return "This character has carefully weighed their options and primed an attack with maximum effectiveness.";
	}
	
	function getTooltip()
	{
		local tooltip = [
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
		return tooltip;
	}
	
	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.IsEffectActive = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.IsEffectActive)
		{
			_properties.DamageTotalMult *= 1.1;
			_properties.RangedSkill += 5;
			_properties.MeleeSkill += 5;
			_properties.DamageDirectAdd += 0.05;
			_properties.TargetAttractionMult *= 1.5;
		}
	}

	function onWaitTurn()
	{
		this.activate();
	}
});
