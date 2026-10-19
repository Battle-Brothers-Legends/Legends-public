::mods_hookExactClass("skills/effects/stunned_effect", function (o) {
	o.setTurns = function (_t) {
		if (!::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor())) {
			this.m.TurnsLeft = ::Math.max(1, _t + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	o.getDescription = function () {
		return "Stunned and unable to act.";
	}

	o.getTooltip <- function () {
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=%negative%]Unable to act[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=%negative%]-25%[/color] Melee Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=%negative%]-25%[/color] Ranged Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=%negative%]-25%[/color] Initiative"
			}
		]);
		return tooltip;
	}

	o.onAdded = function () {
		// Legends Stun immunity logic here (Immovable Object, Steel Brow)
		local actor = this.getContainer().getActor();
		local properties = actor.getCurrentProperties();
		local immovableObject = ::Legends.Perks.get(this, ::Legends.Perk.LegendImmovableObject);
		local steelBrow = ::Legends.Perks.get(this, ::Legends.Perk.SteelBrow);
		if (steelBrow != null || (immovableObject != null && immovableObject.m.isGrantingStunImmunity)) {
			if (actor.getTile().IsVisibleForPlayer) {
				local sourceOfImmunity = steelBrow != null ? steelBrow.getName() : immovableObject.getName();
				::Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(actor) + " is immune to Stun due to " + sourceOfImmunity + " and is Dazed instead.");
			}
			this.removeSelf();
			::Legends.Effects.grant(this, ::Legends.Effect.Dazed);
			return;
		}
		// End of Stun immunity logic
		local statusResisted = (properties.IsResistantToAnyStatuses ? ::Math.rand(1, 100) <= 50 : false) || (properties.IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 33 : false);

		if (statusResisted) {
			if (!actor.isHiddenToPlayer()) {
				::Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " shook off being stunned thanks to unnatural physiology.");
			}

			this.removeSelf();
		} else if (!properties.IsImmuneToStun) {
			::Legends.Effects.remove(this, ::Legends.Effect.Shieldwall);
			::Legends.Effects.remove(this, ::Legends.Effect.Spearwall);
			::Legends.Effects.remove(this, ::Legends.Effect.Riposte);
			::Legends.Effects.remove(this, ::Legends.Effect.LegendReturnFavor);
			::Legends.Effects.remove(this, ::Legends.Effect.PossessedUndead);
			::Legends.Effects.remove(this, ::Legends.Effect.LegendValaCurrentlyChanting);
			::Legends.Effects.remove(this, ::Legends.Effect.LegendValaInTrance);
		} else {
			this.m.IsGarbage = true; //yeah tell me about it.
		}
	}

	local onUpdate = o.onUpdate;
	o.onUpdate = function (_properties) {
		onUpdate(_properties);
		if (!_properties.IsImmuneToStun) {
			_properties.MeleeDefenseMult *= 0.75;
			_properties.RangedDefenseMult *= 0.75;
			_properties.InitiativeMult *= 0.75;
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%negative%]-25%[/color] " + ::Legends.S.inlineIcon(["melee_defense", "ranged_defense", "initiative"]) + ", unable to act";
	}
});
