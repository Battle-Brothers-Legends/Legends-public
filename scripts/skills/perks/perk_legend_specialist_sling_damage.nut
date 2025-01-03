this.perk_legend_specialist_sling_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistSlingDamage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null && item.isWeaponType(this.Const.Items.WeaponType.Sling))
		{
			_properties.DamageRegularMin += 4;
			_properties.DamageRegularMax += 12;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.legend_slingstaff_bash")
		{
			_properties.DamageRegularMin -= 4;
			_properties.DamageRegularMax -= 12;
		}
	}

});

