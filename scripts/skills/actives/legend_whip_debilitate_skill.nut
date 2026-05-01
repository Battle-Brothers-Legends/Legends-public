this.legend_whip_debilitate_skill <- this.inherit("scripts/skills/actives/legend_debilitate_skill", {
	m = {},
	function create() {
		this.legend_debilitate_skill.create();
		::Legends.Actives.onCreate(this, ::Legends.Active.LegendWhipDebilitate);
		this.m.Description = "Crack your whip for weak attack over a significant distance which aims to weaken your opponent.";
		this.m.MaxRange = 3;
		this.m.SoundOnUse = [
			"sounds/combat/whip_01.wav",
			"sounds/combat/whip_02.wav",
			"sounds/combat/whip_03.wav"
		];
	}
});

