this.perk_legend_whip_them_in_shape <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendWhipThemInShape);
	}

	function onAdded() {
		::World.Assets.m.HasDrillSergeant++;
	}

	function onRemoved() {
		::World.Assets.m.HasDrillSergeant--;
	}

	function onDeath(_fatalityType) {
		::World.Assets.m.HasDrillSergeant--;
	}
});
