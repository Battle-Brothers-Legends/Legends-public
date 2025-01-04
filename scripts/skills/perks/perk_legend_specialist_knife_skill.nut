this.perk_legend_specialist_knife_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendSpecialistKnifeSkill);
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
			if (item.getID() == "weapon.knife" || item.getID() == "weapon.legend_shiv")
			{
				_properties.MeleeSkill += 12;
				_properties.DamageDirectAdd += 0.4;
			}
			else if (item.isWeaponType(this.Const.Items.WeaponType.Dagger))
			{
				_properties.MeleeSkill += 3;
				_properties.DamageDirectAdd += 0.1;
			}
		}
	}

});
