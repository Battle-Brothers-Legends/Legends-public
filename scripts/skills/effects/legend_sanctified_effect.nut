this.legend_sanctified_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 0,
	},

	function create() {
		::Legends.Effects.onCreate(this, ::Legends.Effect.LegendSanctified);
		this.m.Description = "This character is being cleansed by holy light.";
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip() {
		local ret = this.skill.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/immunity.png",
			text = "Immune to Bleeding, Injuries, Poison and Morale checks from taking Damage.",
		});
		return ret;
	}

	function isActorOnTileWithHolyFlame() {
		local actor = this.getContainer().getActor();
		if (::Tactical.isActive() && actor.isPlacedOnMap()) {
			local actorTileEffect = actor.getTile().Properties.Effect;
			return actorTileEffect != null && actorTileEffect.Type == "legend_holy_flame";
		} else {
			return false;
		}
	}

	function onUpdate(_properties) {
		local actor = this.getContainer().getActor();
		if (::Tactical.isActive() && actor.isPlacedOnMap()) {
			if (!this.isActorOnTileWithHolyFlame()) {
				this.removeSelf();
			} else {
				_properties.IsAffectedByLosingHitpoints = false;
				if (!::Legends.Traits.has(actor, ::Legends.Trait.RacialGhost)) {
					_properties.IsAffectedByInjuries = false;
					_properties.IsAffectedByFreshInjuries = false;
					_properties.IsImmuneToBleeding = true;
					_properties.IsImmuneToPoison = true;
				}
			}
		}
	}

	function onNewRound() {
		if (!this.isActorOnTileWithHolyFlame()) {
			this.removeSelf();
		}
	}

	function getActorHoverTooltip(_activeEntity, _stacks = 1) {
		return ::Legends.S.inlineIcon("immunity") + " to Bleeding, Injuries, Poison and Morale checks on " + ::Legends.S.inlineIcon("damage_received");
	}
});
