this.perk_legend_specialist_inventor <- this.inherit("scripts/skills/legend_specialist_abstract", {
	m = {
		SpecialistWeaponTypes = [
			this.Const.Items.WeaponType.Firearm
		],
		BonusMelee = 12,
		BonusRanged = 12,
		BonusDamage = 10
	},
	function create()
	{
		this.legend_specialist_abstract.create();
		::Const.Perks.setup(this.m, ::Legends.Perk.LegendSpecialistInventor);
		this.m.IconMini = "perk_spec_firearm_mini";
	}

	function onAfterUpdate(_properties)
	{
		local skills = this.getContainer().getAllSkillsOfType(this.Const.SkillType.Active);
		foreach (skill in skills)
		{
			if (this.m.Skills.find(::Legends.Actives.getID(::Legends.Active.ReloadHandgonne)))
			{
				skill.m.ActionPointCost -= 1;
			}
		}
	}
});
