this.perk_legend_specialist_farmhand <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistItemTypes = [
			this.Const.Items.ItemType.Pitchfork
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Polearm
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistFarmhand);
		this.m.IconMini = "perk_spec_bitchfork_mini";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill))
			_properties.DamageArmorMult += 0.01 * this.calculateSpecialistBonus(25, _skill.getItem());
	}
});
