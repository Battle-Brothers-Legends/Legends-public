this.perk_legend_minnesanger <- this.inherit("scripts/skills/skill", {
	m = {
		SkillsToAdjust = [
			::Legends.Active.LegendSongOfLife,
			::Legends.Active.LegendWarChant,
			::Legends.Active.LegendMartialMarch
		]
	},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendMinnesanger);
	}

	function onAfterUpdate(_properties) {
		foreach (skill in this.m.SkillsToAdjust) {
			_properties.SkillCostAdjustments.push({
				ID = ::Legends.Actives.getID(skill),
				APAdjust = -1,
				FatigueMultAdjust = ::Const.Combat.WeaponSpecFatigueMult
			});
		}
	}
});
