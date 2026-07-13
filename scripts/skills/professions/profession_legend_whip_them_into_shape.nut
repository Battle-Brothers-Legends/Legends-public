this.profession_legend_whip_them_into_shape <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Professions.onCreate(this, ::Legends.Profession.LegendWhipThemIntoShape);
	}

	function onAdded() {
		::World.Assets.m.ProfessionEffect.LegendWhipThemIntoShape = ::Legends.Professions.getProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}

	function onRemoved() {
		::World.Assets.m.ProfessionEffect.LegendWhipThemIntoShape = ::Legends.Professions.getProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}

	function onDeath(_fatalityType) {
		::World.Assets.m.ProfessionEffect.LegendWhipThemIntoShape = ::Legends.Professions.getProfessionEffect(::Const.Professions.LookupMap[this.getID()]);
	}
});
