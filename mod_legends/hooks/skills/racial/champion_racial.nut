::mods_hookExactClass("skills/racial/champion_racial", function(o)
{
	o.onUpdate = function ( _properties )
	{
		_properties.BraveryMult *= 1.5;
		_properties.StaminaMult *= 1.5;
		_properties.MeleeSkillMult *= 1.15;
		_properties.RangedSkillMult *= 1.15;
		_properties.MeleeDefenseMult *= 1.25;
		_properties.RangedDefenseMult *= 1.25;
		_properties.InitiativeMult *= 1.15;
		_properties.HitpointsMult *= 1.35;

		if (this.getContainer().getActor().getBaseProperties().MeleeDefense >= 20 || this.getContainer().getActor().getBaseProperties().RangedDefense >= 20 || this.getContainer().getActor().getBaseProperties().MeleeDefense >= 15 && this.getContainer().getActor().getBaseProperties().RangedDefense >= 15)
		{
			_properties.MeleeDefenseMult *= 1.25;
			_properties.RangedDefenseMult *= 1.25;
		}
		else
		{
			_properties.HitpointsMult *= 1.35;
		}
	}
});
