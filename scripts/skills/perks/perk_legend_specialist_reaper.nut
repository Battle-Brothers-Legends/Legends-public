this.perk_legend_specialist_reaper <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_grisly_scythe",
			"weapon.legend_scythe",
			"weapon.warscythe",
			"weapon.named_warscythe"
		],
		BonusMelee = 15,
		BonusDamage = 15
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistReaper);
		this.m.IconMini = "perk_spec_scythe_mini";
	}
});
