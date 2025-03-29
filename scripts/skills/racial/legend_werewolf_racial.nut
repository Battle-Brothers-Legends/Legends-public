this.legend_werewolf_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.legend_werewolf";
		this.m.Name = "Blind Rage";
		this.m.Description = "TODO";
		this.m.Icon = "skills/status_effect_01.png";
		this.m.Type = this.Const.SkillType.Racial;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		local healthMissing = _properties.Hitpoints - this.getContainer().getActor().getHitpoints();
		local additionalDamage = this.Math.floor(healthMissing * 0.25);
		if(::Legends.isLegendaryDifficulty())
		{
			local additionalDamage = this.Math.floor(healthMissing * 0.5);
		}


		if (additionalDamage > 0)
		{
			_properties.DamageRegularMin += additionalDamage;
			_properties.DamageRegularMax += additionalDamage;
		}
	}

});

