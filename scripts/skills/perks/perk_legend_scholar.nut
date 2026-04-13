this.perk_legend_scholar <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendScholar);
	}

	function onAdded() {
		::World.Assets.m.HasScholars++;
	}

	function onRemoved() {
		::World.Assets.m.HasScholars--;
	}

	function onDeath(_fatalityType) {
		::World.Assets.m.HasScholars--;
	}

});
