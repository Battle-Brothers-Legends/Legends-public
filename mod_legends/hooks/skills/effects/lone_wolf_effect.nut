::mods_hookExactClass("skills/effects/lone_wolf_effect", function (o) {
	o.onUpdate = function (_properties) {
		if (!this.getContainer().getActor().isPlacedOnMap()) {
			this.m.IsHidden = true;
			return;
		}

		local actor = this.getContainer().getActor();
		local myTile = actor.getTile();
		local isAlone = (::Tactical.Entities.getInstancesOfFaction(actor.getFaction()).filter(@(_, _ally)(_ally.getID() != actor.getID() && _ally.isPlacedOnMap() && _ally.getTile().getDistanceTo(myTile) <= 2)).len() == 0);

		if (isAlone) {
			this.m.IsHidden = false;
			_properties.MeleeSkillMult *= 1.15;
			_properties.RangedSkillMult *= 1.15;
			_properties.MeleeDefenseMult *= 1.15;
			_properties.RangedDefenseMult *= 1.15;
			_properties.BraveryMult *= 1.15;
			_properties.MovementAPCostAdditional -= 1;
		} else {
			this.m.IsHidden = true;
		}
	}

	o.getActorHoverTooltip <- function (_activeEntity, _stacks = 1) {
		"[color=%positive%]+15%[/color] " + ::Legends.S.inlineIcon(["melee_skill", "ranged_skill", "melee_defense", "ranged_defense", "bravery"]);
	}
});
