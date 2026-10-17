this.legend_choked_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendChoked);
		this.m.Description = "Choked out and exhausted.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-15[/color] Fatigue recovered per turn"
			}
		]);
		return tooltip;
	}

	function onAdded() {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function onRefresh() {
		this.m.TurnsLeft = ::Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_87", this.getContainer().getActor().getTile());
	}

	function onRemoved() {
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned)) {
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (!actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned)) {
			actor.getSprite("status_stunned").setBrush("bust_dazed");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

	function onTurnStart() {
		local actor = this.getContainer().getActor();
		actor.setFatigue(actor.m.Fatigue + 15);
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-15[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_down");
	}
});
