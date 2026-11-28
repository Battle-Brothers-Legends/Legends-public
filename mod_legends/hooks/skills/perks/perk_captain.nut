::mods_hookExactClass("skills/perks/perk_captain", function (o) {
	o.create = function () {
		::Legends.Perks.onCreate(this, ::Legends.Perk.Captain);
	}

	o.refreshEffect <- function () {
		foreach (entity in ::Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction()).filter(@(_, _entity)(!::Legends.S.isEntityNullOrDead(_entity) && ::Legends.Effects.has(_entity, ::Legends.Effect.Captain)))) {
			entity.getSkills().update();
			entity.setDirty(true);
		}
	}

	o.onMovementFinished <- @() this.refreshEffect();

	o.applyAura <- function () {
		local actor = this.getContainer().getActor();
		foreach (ally in ::Tactical.Entities.getInstancesOfFaction(actor.getFaction()).filter(@(_, _ally)(_ally.getID() != actor.getID() && _ally.isPlacedOnMap()))) {
			::Legends.Effects.grant(ally, ::Legends.Effect.Captain);
		}
	}

	o.onDeath <- @(_fatalityType) this.refreshEffect();
});
