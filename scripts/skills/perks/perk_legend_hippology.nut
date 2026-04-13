this.perk_legend_hippology <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendHippology);
	}

	function onAdded() {
		::World.Assets.m.HasVeterinarian++;
	}

	function onRemoved() {
		::World.Assets.m.HasVeterinarian--;
	}

	function onDeath(_fatalityType) {
		::World.Assets.m.HasVeterinarian--;
	}

});

