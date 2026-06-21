::mods_hookExactClass("skills/effects/stunned_effect", function (o) {

	o.setTurns = function (_t) {
		if (!::MSU.isNull(this.getContainer()) && !::MSU.isNull(this.getContainer().getActor())) {
			this.m.TurnsLeft = this.Math.max(1, _t + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	function getTooltip() {
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
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
		];
	}

	o.onAdded = function () {
		// Legends Stun immunity logic here (Composure, Immovable Object, Steel Brow)
		local composure = ::Legends.Perks.get(this, ::Legends.Perk.LegendComposure);
		local immovableObject = ::Legends.Perks.get(this, ::Legends.Perk.LegendImmovableObject);
		local steelBrow = ::Legends.Perks.get(this, ::Legends.Perk.SteelBrow);
		if (composure != null || (immovableObject != null && immovableObject.m.isGrantingStunImmunity)) {
    		if (this.getContainer().getActor().getTile().IsVisibleForPlayer) {
        		local sourceOfImmunity = composure != null ? composure.getName() : immovableObject.getName();
        		this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is immune to Stun due to " + sourceOfImmunity + ".");
    		}
    		this.removeSelf();
    		return;
		}

		if (steelBrow != null) {
    		if (this.getContainer().getActor().getTile().IsVisibleForPlayer) {
        		this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " is immune to Stun due to " + steelBrow.getName() + " and is Dazed instead.");
    		}
    		this.removeSelf();
    		::Legends.Effects.grant(this, ::Legends.Effect.Dazed);
			return;
		}
		// End of Stun immunity logic
		local statusResisted = this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses
			? this.Math.rand(1, 100) <= 50
			: false;
		statusResisted = statusResisted
			|| this.getContainer().getActor().getCurrentProperties().IsResistantToPhysicalStatuses
			? this.Math.rand(1, 100) <= 33
			: false;

		if (statusResisted) {
			if (!this.getContainer().getActor().isHiddenToPlayer()) {
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shook off being stunned thanks to unnatural physiology.");
			}

			this.removeSelf();
		} else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun) {
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

	function onUpdate(_properties) {
		_properties.MeleeDefenseMult *= 0.75;
		_properties.RangedDefenseMult *= 0.75;
		_properties.InitiativeMult *= 0.75;
	}
});
