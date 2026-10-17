this.legend_baffled_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendBaffled);
		this.m.Description = "Confused after receiving a blow.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=%negative%]-15%[/color] Damage"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=%negative%]-15%[/color] Max Fatigue"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-15%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	function onAdded() {
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? ::Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 33 : false;

		if (statusResisted) {
			if (!actor.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " shook off being baffled thanks to unnatural physiology");
			}

			this.removeSelf();
		} else {
			this.m.TurnsLeft = ::Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
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
		if (!actor.getCurrentProperties().IsImmuneToDaze) {
			_properties.DamageTotalMult *= 0.85;
			_properties.InitiativeMult *= 0.85;
			_properties.StaminaMult *= 0.85;

			if (actor.hasSprite("status_stunned") && !this.getContainer().hasEffect(::Legends.Effect.Stunned)) {
				actor.getSprite("status_stunned").setBrush("bust_dazed");
				actor.getSprite("status_stunned").Visible = true;
				actor.setDirty(true);
			}
		} else {
			this.removeSelf();
		}
	}

	function onTurnEnd() {
		if (--this.m.TurnsLeft <= 0) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return "[color=%negative%]-15%[/color] " + ::Legends.S.inlineIcon("damage_dealt") + ::Legends.S.inlineIcon("fatigue") + ::Legends.S.inlineIcon("initiative");
	}
});
