this.perk_legend_specialist_pitchfork_damage <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistPitchforkDamage);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		if (item != null)
		{
			if (item.isItemType(this.Const.Items.ItemType.Pitchfork))
			{
				_properties.DamageRegularMin += 9;
				_properties.DamageRegularMax += 24;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Polearm))
			{
				_properties.DamageRegularMin += 3;
				_properties.DamageRegularMax += 8;
			}
		}
	}
});
