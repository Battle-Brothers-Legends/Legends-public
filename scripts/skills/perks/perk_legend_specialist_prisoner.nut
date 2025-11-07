this.perk_legend_specialist_prisoner <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.knife",
			"weapon.legend_shiv"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Dagger
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistPrisoner);
		this.m.IconMini = "perk_spec_dagger_mini";
	}
});
