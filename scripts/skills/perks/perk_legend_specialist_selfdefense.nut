this.perk_legend_specialist_selfdefense <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistSelfdefense);
		this.m.IconMini = "perk_spec_staff_mini";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties ){
		local item = this.getContainer().getActor().getMainhandItem();
		local bonus = 16;
		if (item == null)
			return;
		if (item.isWeaponType(::Const.Items.WeaponType.Staff) && item.isWeaponType(::Const.Items.WeaponType.Sling))
			bonus = 8;
		else if (item.isWeaponType(::Const.Items.WeaponType.Musical))
			bonus = 8;
		if (item.isWeaponType(::Const.Items.WeaponType.Staff) || item.isWeaponType(::Const.Items.WeaponType.MagicStaff) || item.isWeaponType(::Const.Items.WeaponType.Musical)) {
			_properties.MeleeDefense  += bonus;
			_properties.RangedDefense += bonus;
			_properties.MeleeSkill += bonus;
		}
	}
});
