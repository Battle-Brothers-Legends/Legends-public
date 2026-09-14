this.perk_legend_specialist_cultist <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponIds = [
			"weapon.legend_cat_o_nine_tails"
		],
		ApplicableWeaponTypes = [
			this.Const.Items.WeaponType.Flail,
			this.Const.Items.WeaponType.Whip
		],
		BonusMelee = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendSpecialistCultist);
		this.m.IconMini = "perk_spec_cultist_mini";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill))
			_properties.HitChance[this.Const.BodyPart.Head] += this.calculateSpecialistBonus(15, _skill.getItem());
	}
});
