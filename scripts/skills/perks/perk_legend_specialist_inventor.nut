this.perk_legend_specialist_inventor <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponTypes = [
			this.Const.Items.WeaponType.Firearm
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistInventor);
		this.m.IconMini = "perk_spec_firearm_mini";
	}
});
