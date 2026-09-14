this.perk_legend_mastery_music <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsToAdjust = [
			::Legends.Active.LegendDrumsOfLife,
			::Legends.Active.LegendDrumsOfWar,
			::Legends.Active.LegendMartialMarch
		]
	},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMasteryMusic);
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInMusic = true;
		foreach(skill in this.m.SkillsToAdjust) {
			_properties.SkillCostAdjustments.push({
				ID = ::Legends.Actives.getID(skill),
				APAdjust = -1,
				FatigueMultAdjust = ::Const.Combat.WeaponSpecFatigueMult
			});
		}
	}

});
