this.perk_legend_specialist_woodsman <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.woodcutters_axe",
			"weapon.legend_saw"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Axe
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.TwoHanded
		],
		ValidEntities = [
			this.Const.EntityType.Schrat,
			this.Const.EntityType.LegendGreenwoodSchrat,
			this.Const.EntityType.SchratSmall,
			this.Const.EntityType.LegendGreenwoodSchratSmall
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistWoodsman);
		this.m.IconMini = "perk_spec_woodsman_mini";
	}
});
