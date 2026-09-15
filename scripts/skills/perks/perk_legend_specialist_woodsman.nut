this.perk_legend_specialist_woodsman <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.woodcutters_axe",
			"weapon.legend_saw"
		],
		ApplicableWeaponTypes = [
			::Const.Items.WeaponType.Axe
		],
		ApplicableItemTypes = [
			::Const.Items.ItemType.TwoHanded
		],
		ValidEntities = [
			::Const.EntityType.Schrat,
			::Const.EntityType.LegendGreenwoodSchrat,
			::Const.EntityType.SchratSmall,
			::Const.EntityType.LegendGreenwoodSchratSmall
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
