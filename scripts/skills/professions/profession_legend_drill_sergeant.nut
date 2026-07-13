this.profession_legend_drill_sergeant <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendDrillSergeant);
	}

	function onAdded() {
		::World.Assets.m.ProfessionEffect.LegendDrillSergeant = ::Legends.Professions.getProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}

	function onRemoved() {
		::World.Assets.m.ProfessionEffect.LegendDrillSergeant = ::Legends.Professions.getProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}

	function onDeath(_fatalityType) {
		::World.Assets.m.ProfessionEffect.LegendDrillSergeant = ::Legends.Professions.getProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}
});