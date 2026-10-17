this.legend_demon_hound_bite_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendDemonHoundBite);
		this.m.Description = "Bitten and cursed by a Höllenhund.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-70%[/color] Fatigue Recovery"
			}
		]);
		return tooltip;
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onUpdate(_properties) {
		_properties.FatigueRecoveryRateMult *= 0.3;
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function resetTime() {
		this.m.TurnsLeft = ::Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-70%[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_down");
	}
});
