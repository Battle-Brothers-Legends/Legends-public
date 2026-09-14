this.perk_legend_minnesanger <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsToAdjust = [
			::Legends.Active.LegendDrumsOfLife,
			::Legends.Active.LegendDrumsOfWar,
			::Legends.Active.LegendMartialMarch
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMinnesanger);
	}

	function onUpdate( _properties ) {
		foreach(skill in this.m.SkillsToAdjust) {
			_properties.SkillCostAdjustments.push({
				ID = ::Legends.Actives.getID(skill),
				APAdjust = -1,
				FatigueMultAdjust = 0.75
			});
		}
	}
});
