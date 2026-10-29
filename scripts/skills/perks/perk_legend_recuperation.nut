this.perk_legend_recuperation <- this.inherit("scripts/skills/skill", {
	m = {},

	function create() {
		::Legends.Perks.onCreate(this, ::Legends.Perk.LegendRecuperation);
	}

	function onUpdate(_properties) {
		_properties.AdditionalHealingDays -= 1;
	}

	function onCombatFinished() {
		local actor = this.getContainer().getActor();
		if (actor.isAlive() && actor.getHitpointsPct() < 1.0) {
			
			local hp = this.getBonus(actor);
			actor.setHitpoints(::Math.min(actor.getHitpointsMax(), hp + actor.getHitpoints()));
			actor.setDirty(true);
		}
	}

	function getBonus(_actor = null) {
		local actor = _actor != null ? _actor : this.getContainer().getActor();
		return ::Math.floor((actor.getHitpointsMax() - actor.getHitpoints()) * 0.3);
	}

	function getDynamicTooltip(_actor = null) {
		return [
			{
				id = 3,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=%positive%]" + this.getBonus(_actor) + "[/color] healed at the end of combat"
			}
		];
	}
});
