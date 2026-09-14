this.perk_legend_specialist_inquisition <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_wooden_stake",
			"weapon.legend_hand_crossbow",
			"weapon.goblin_crossbow"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Crossbow
		],
		ValidEntities = [
			this.Const.EntityType.Hexe,
			this.Const.EntityType.Alp
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistInquisition);
		this.m.IconMini = "perk_spec_xbow_mini";
	}
});
