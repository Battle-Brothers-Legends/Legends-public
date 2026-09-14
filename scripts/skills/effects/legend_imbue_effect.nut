this.legend_imbue_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		ImbueAmount = 0,
		Range = 4
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendImbueEffect);
		this.m.Icon = "ui/perks/mage_legend_magic_imbue_circle.png";
		this.m.IconMini = "perk_37_mini";
		this.m.Overlay = "perk_37";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been imbued with magical strength. Hit chance and damage are increased by [color=%positive%]" + this.m.ImbueAmount + "%[/color] for [color=%negative%]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function setImbueAmount( _amount )
	{
		this.m.ImbueAmount = _amount;
	}

	function onUpdate( _properties )
	{
	}

	function applyEffect()
	{
		(100 + this.m.ImbueAmount) / 100.0;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onCombatFinished()
	{
		this.removeSelf();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.MeleeSkill += this.m.ImbueAmount;
		_properties.RangedSkill += this.m.ImbueAmount;
		_properties.DamageTotalMult *= (100 + this.m.ImbueAmount) / 100.0;
	}

});

