this.perk_legend_specialist_herbalist <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.sickle",
			"weapon.goblin_notched_blade",
			"weapon.legend_named_sickle"
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.OneHanded
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Sword
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistHerbalist);
		this.m.IconMini = "perk_spec_sickle_mini";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill) && _properties.ThresholdToInflictInjuryMult != 1.0)
			_properties.DamageRegularMult *= 1.0 + 0.01 * this.calculateSpecialistBonus(30, _skill.getItem()) * (1.0 - _properties.ThresholdToInflictInjuryMult);
	}
});
