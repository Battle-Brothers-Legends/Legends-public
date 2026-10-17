this.legend_second_wind_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Counter = 3,
		ApplicableEffects = [
			::Legends.Effect.Charmed,
			::Legends.Effect.Dazed,
			::Legends.Effect.Sleeping,
			::Legends.Effect.Staggered,
			::Legends.Effect.Stunned,
			::Legends.Effect.LegendBaffled
		]
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSecondWind);
		this.m.Description = "Has had a second wind and may not have another this combat.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		if (this.m.Counter > 0) {
			tooltip.extend([
				{
					id = 11,
					type = "text",
					icon = "ui/icons/turns_left.png",
					text = "Duration: " + this.m.Counter + " turns"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/fatigue_recovery_up.png",
					text = "[color=%positive%]+5[/color] Fatigue Recovery per turn."
				}
			]);
		}
		return tooltip;
	}

	function onUpdate(_properties) {
		if (this.m.Counter > 0) {
			_properties.FatigueRecoveryRate += 5;
		}
	}

	function onTurnStart() {
		this.m.Counter -= 1;
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		if (::Legends.S.isEntityNullOrDead(actor)) {
			return;
		}

		actor.setFatigue(0);
		foreach (effect in this.m.ApplicableEffects.filter(@(_, _effect)(::Legends.Effects.has(actor, _effect)))) {
			::Legends.Effects.remove(actor, effect);
		}

		if (!actor.isHiddenToPlayer()) {
			actor.playSound(::Const.Sound.ActorEvent.Fatigue, ::Const.Sound.Volume.Actor * actor.getSoundVolume(::Const.Sound.ActorEvent.Fatigue));
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		if (this.m.Counter > 0) {
			return "[color=%positive%]+5[/color] " + ::Legends.S.inlineIcon("fatigue_recovery_up");
		}
		return null;
	}
});
