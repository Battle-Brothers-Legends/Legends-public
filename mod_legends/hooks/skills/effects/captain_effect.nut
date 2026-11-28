::mods_hookExactClass("skills/effects/captain_effect", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.IsRemovedAfterBattle = true;
	}

	o.isHidden <- function () {
		return this.m.Difference == 0;
	}

	o.getBonus <- function () {
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || !::Tactical.isActive()) {
			return 0;
		}

		local myTile = actor.getTile();
		local bestBravery = 0;
		foreach (captain in ::Tactical.Entities.getInstancesOfFaction(actor.getFaction()).filter(@(_, _ally)(_ally.getID() != actor.getID() && !::Legends.S.isEntityNullOrDead(_ally) && _ally.isPlacedOnMap() && _ally.getTile().getDistanceTo(myTile) <= 5 && actor.getBravery() < _ally.getBravery() && ::Legends.Perks.has(_ally, ::Legends.Perk.Captain)))) {
			bestBravery = ::Math.maxf(bestBravery, ::Math.minf(captain.getBravery() * 0.15, captain.getBravery() - actor.getBravery()));
		}
		return ::Math.round(bestBravery);
	}

	o.onUpdate <- function (_properties) {
		this.m.Difference = this.getBonus();
		_properties.Bravery += this.m.Difference;
	}

	o.onAfterUpdate = function (_properties) {}

	o.onCombatFinished = @() this.skill.onCombatFinished();

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		return "[color=%positive%]+" + this.m.Difference + "[/color] " + ::Legends.Text.inlineIcons("bravery");
	}
});
