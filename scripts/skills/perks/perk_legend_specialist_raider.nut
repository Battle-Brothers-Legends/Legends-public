this.perk_legend_specialist_raider <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.crude_axe",
			"weapon.throwing_axe"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Axe
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.OneHanded
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistRaider);
		this.m.IconMini = "perk_spec_raider_mini";
	}
});
