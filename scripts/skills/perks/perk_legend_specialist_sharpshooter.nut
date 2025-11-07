this.perk_legend_specialist_sharpshooter <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.war_bow"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Bow
		],
		ExcludedItemTypes = [],
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistSharpshooter);
		this.m.IconMini = "perk_spec_longbow_mini";
	}
});
