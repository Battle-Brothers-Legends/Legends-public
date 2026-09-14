::mods_hookExactClass("skills/actives/footwork", function (o) {
	o.m.IsFootwork <- false;
	o.m.IsQuickStep <- true;

	local create = o.create;
	o.create = function () {
		create();
		this.m.Description = "Use skillful footwork to leave a Zone of Control without triggering attacks of opportunity or alternatively moving quickly to an adjacent tile.";
	}
	o.onAfterUpdate = function (_properties) {
		if (this.getContainer().getActor().getSkills().hasPerk(::Legends.Perk.LegendBackflip) && this.m.IsFootwork) {
			this.m.MaxRange = 2;
		}
		if (this.m.IsFootwork) {
			this.m.FatigueCost = 15;
			this.m.ActionPointCost = 1;
		} else if (this.m.IsFootwork) {
			this.m.FatigueCost = 20;
			this.m.ActionPointCost = 3;
		}

		_properties.SkillCostAdjustments.push({
			// fix vanilla bullshit with hard setting fat cost in onAfterUpdate
			ID = this.m.ID,
			APAdjust = ::Legends.Effects.has(this.getContainer(), ::Legends.Effect.GoblinGruntPotion) ? -1: 0,
			FatigueMultAdjust = _properties.IsFleetfooted ? 0.5: 1.0
		});
	}

	o.onUpdate <- function (_properties) {
		local actor = this.getContainer().getActor();
		this.m.IsFootwork = false;
		if (::Tactical.isActive() && actor.getTile().hasZoneOfControlOtherThan(actor.getAlliedFactions())) {
			local myTile = actor.getTile();

			for (local i = 0; i < 6; i++) {
				if (myTile.hasNextTile(i)) {
					local nextTile = myTile.getNextTile(i);

					if (nextTile.IsOccupiedByActor && ::Math.abs(nextTile.Level - myTile.Level) <= 1) {
						local entity = nextTile.getEntity();

						if (!entity.getCurrentProperties().IsStunned && !entity.isAlliedWith(actor)) {
							this.m.isFootwork = true;
							break;
						}
					}
				}
			}
		}
		this.m.IsQuickStep = !this.m.IsFootwork;
	}

	o.isUsable = function () {
		if (this.skill.isUsable() && !this.getContainer().getActor().getCurrentProperties().IsRooted) {
			return true;
		}
		return false;
	}
});
