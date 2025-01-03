this.perk_legend_specialist_pitchfork_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistPitchforkSkill);
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
				_properties.MeleeSkill += 12;
				_properties.DamageArmorMult += 0.25;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Polearm))
			{
				_properties.MeleeSkill += 3;
				_properties.DamageArmorMult += 0.08;
			}
		}
	}
});
