this.legend_compromised_armor_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendCompromisedArmor);
		this.m.Description = "This character has their armor compromised from a recent strike. Increase damage ignoring armor by 20%.";
		this.m.Icon = "skills/legend_compromised_armor.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.Overlay = "status_effect_78";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription() {
		return "This character has their armor compromised from a recent strike. Increase damage ignoring armor and armor damage done by [color=%positive%]20%[/color]."
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedDirectMult *= 1.2;
		_properties.DamageReceivedArmorMult *= 1.2;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onWaitTurn()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}
});

