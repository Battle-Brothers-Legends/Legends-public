this.perk_legend_specialist_prisoner <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.knife",
			"weapon.legend_shiv"
		],
		ApplicableWeaponTypes = [
			::Const.Items.WeaponType.Dagger
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create() {
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistPrisoner);
		this.m.IconMini = "perk_spec_dagger_mini";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties ) {
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill)) {
			_properties.DamageDirectAdd += 0.01 * this.calculateSpecialistBonus(20, _skill.getItem());
		}
	}
});
