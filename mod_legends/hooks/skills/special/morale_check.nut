::mods_hookExactClass("skills/special/morale_check", function(o)
{
	o.onUpdate = function ( _properties )
	{
		this.m.IsHidden = this.m.Container.getActor().getMoraleState() == this.Const.MoraleState.Steady;
		this.m.Name = this.Const.MoraleStateName[this.m.Container.getActor().getMoraleState()];

		switch(this.m.Container.getActor().getMoraleState())
		{
		case this.Const.MoraleState.Confident:
			this.m.Icon = "skills/status_effect_14.png";
			this.m.IconMini = "status_effect_14_mini";
			_properties.MeleeSkillMult *= 1.1;
			_properties.RangedSkillMult *= 1.1;
			_properties.MeleeDefenseMult *= 1.1;
			_properties.RangedDefenseMult *= 1.1;
			break;

		case this.Const.MoraleState.Wavering:
			this.m.Icon = "skills/status_effect_02_c.png";
			this.m.IconMini = "status_effect_02_c_mini";
			_properties.BraveryMult *= 0.9;
			_properties.MeleeSkillMult *= 0.9;
			_properties.RangedSkillMult *= 0.9;
			_properties.MeleeDefenseMult *= 0.9;
			_properties.RangedDefenseMult *= 0.9;
			break;

		case this.Const.MoraleState.Breaking:
			this.m.Icon = "skills/status_effect_02_b.png";
			this.m.IconMini = "status_effect_02_b_mini";
			_properties.BraveryMult *= 0.8;
			_properties.MeleeSkillMult *= 0.8;
			_properties.RangedSkillMult *= 0.8;
			_properties.MeleeDefenseMult *= 0.8;
			_properties.RangedDefenseMult *= 0.8;
			break;

		case this.Const.MoraleState.Fleeing:
			this.m.Icon = "skills/status_effect_02_a.png";
			this.m.IconMini = "status_effect_02_a_mini";
			_properties.BraveryMult *= 0.7;
			_properties.MeleeSkillMult *= 0.7;
			_properties.RangedSkillMult *= 0.7;
			_properties.MeleeDefenseMult *= 0.7;
			_properties.RangedDefenseMult *= 0.7;
			_properties.InitiativeForTurnOrderAdditional -= 1000;
			break;

		case this.Const.MoraleState.Ignore:
			this.m.Icon = "";
			this.m.IconMini = "";
			this.m.Name = "";
			this.m.IsHidden = true;
			break;
		}
	}
});
