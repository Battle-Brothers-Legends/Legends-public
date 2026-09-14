this.legend_staff_riposte_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_staff_riposte";
		this.m.Name = "Staff Riposte";
		this.m.Icon = "skills/status_effect_33.png";
		// this.m.IconMini = "status_effect_33_mini";
		this.m.Overlay = "status_effect_33";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is prepared to immediately counter-attack on any failed attempt to attack them in melee.";
	}

	function onUpdate( _properties )
	{
		_properties.IsRiposting = true;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != this.getContainer().getActor().getID())
		{
			if (!this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
			{
				_properties.MeleeSkill -= 10;
			}
		}
	}

});

