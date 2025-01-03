this.perk_legend_prepared_for_anything <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Const.Perks.setup(this.m, ::Const.Perks.PerkDefs.LegendPreparedForAnything);
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}


	function onCombatStarted()
	{
		local actors = this.Tactical.Entities.getInstancesOfFaction(this.Const.Faction.Player);

		foreach( a in actors )
		{
			if (!a.getSkills().hasSkill("perk.bags_and_belts"))
			{
				a.getSkills().add(this.new("scripts/skills/perks/perk_bags_and_belts"));
			}
		}
	}

});
