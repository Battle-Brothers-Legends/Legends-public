this.perk_legend_athlete <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendAthlete);
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return 1.0 - 0.002 * actor.getFatigueMax();
	}

	function onUpdate(_properties) {
		_properties.FatigueEffectMult *= this.getBonus();
	}

	function getDynamicTooltip(_actor = null) {
		return [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%positive%]" + ::Math.round(this.getBonus(_actor) * 100) + "%[/color] Fatigue cost multiplier"
			}
		];
	}
});
