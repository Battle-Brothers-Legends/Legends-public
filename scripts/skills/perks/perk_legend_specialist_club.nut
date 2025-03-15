this.perk_legend_specialist_club <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.wooden_stick",
			"weapon.bludgeon"
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.OneHanded
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Mace
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistClub);
		this.m.IconMini = "perk_spec_mace_mini";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (onAnySkillUsedSpecialistChecks(_skill))
			_properties.FatigueDealtPerHitMult += 1.0;
	}
});
