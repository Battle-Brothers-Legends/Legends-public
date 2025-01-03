this.perk_legend_specialist_lute_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistLuteSkill);
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
			if (item.isWeaponType(this.Const.Items.WeaponType.Musical))
			{
				_properties.MeleeSkill += 10;
				_properties.MeleeDefense += 10;
				_properties.DamageArmorMult += 0.5;
			}
		}
	}

});
