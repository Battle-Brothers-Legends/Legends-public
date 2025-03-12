this.perk_legend_specialist_herbalist <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.sickle",
			"weapon.goblin_notched_blade",
			"weapon.legend_named_sickle"
		],
		ApplicableItemTypes = [
			this.Const.Items.ItemType.OneHanded
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Sword
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistHerbalist);
		this.m.IconMini = "perk_spec_sickle_mini.png";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (onAnySkillUsedSpecialistChecks(_skill))
			_properties.DamageDirectMult += 0.01 * this.calculateSpecialistBonus(25, _skill.getItem());
	}
});
