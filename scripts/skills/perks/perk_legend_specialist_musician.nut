this.perk_legend_specialist_musician <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponTypes = [
			this.Const.Items.WeaponType.Musical
		],
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistMusician);
		this.m.IconMini = "perk_spec_bard_mini";
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.legend_specialist_abstract.onAnySkillUsed(_skill, _targetEntity, _properties);
		if (this.onAnySkillUsedSpecialistChecks(_skill))
		{
			_properties.MeleeDefense += this.calculateSpecialistBonus(10, _skill.getItem());
		}
	}
});
