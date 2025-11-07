this.perk_legend_specialist_selfdefense <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_staff",
			"weapon.legend_tipstaff",
			"weapon.legend_staff_vala",
			"weapon.legend_named_staff_vala",
			"weapon.legend_staff_gnarled"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Staff
		],
		ExcludedWeaponTypes = [
			this.Const.Items.WeaponType.Musical,
			this.Const.Items.WeaponType.Sling
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistSelfdefense);
		this.m.IconMini = "perk_spec_staff_mini";
	}

	function onUpdate( _properties )
	{
		local item = this.getContainer().getActor().getMainhandItem();
		local bonus = 16;
		if (item == null)
			return;
		if (item.isWeaponType(this.Const.Items.WeaponType.Staff) && item.isWeaponType(this.Const.Items.WeaponType.Sling))
			bonus = 8;
		else if (item.isWeaponType(this.Const.Items.WeaponType.MagicStaff) && item.isWeaponType(this.Const.Items.WeaponType.Sword))
			bonus = 8;
		else if (item.isWeaponType(this.Const.Items.WeaponType.Musical))
			bonus = 8;
		if (item.isWeaponType(this.Const.Items.WeaponType.Staff) || item.isWeaponType(this.Const.Items.WeaponType.MagicStaff) || item.isWeaponType(this.Const.Items.WeaponType.Musical))
		{
			_properties.MeleeDefense  += bonus;
			_properties.RangedDefense += bonus;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
	}
});
