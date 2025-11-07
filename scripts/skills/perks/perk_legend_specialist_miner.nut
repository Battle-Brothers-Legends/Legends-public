this.perk_legend_specialist_miner <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.pickaxe",
			"weapon.military_pick"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Hammer
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.TwoHanded
		],
		ValidEntities = [
			this.Const.EntityType.LegendRockUnhold,
			this.Const.EntityType.SandGolem
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistMiner);
		this.m.IconMini = "perk_spec_pickaxe_mini";
	}
});
