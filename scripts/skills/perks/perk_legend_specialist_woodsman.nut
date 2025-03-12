this.perk_legend_specialist_woodsman <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.woodcutters_axe",
			"weapon.legend_saw"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Axe
		],
		ValidEntities = [
			this.Const.EntityType.Schrat,
			this.Const.EntityType.LegendGreenwoodSchrat
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistWoodsman);
		this.m.IconMini = "perk_spec_woodsman_mini.png";
	}
});
