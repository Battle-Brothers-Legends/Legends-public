::mods_hookExactClass("factions/actions/send_undead_army_action", function (o) {
	o.m.TimeBetweenSpawns <- 150.0;
	
	o.onUpdate = function (_faction) {
		if (!::World.FactionManager.isUndeadScourge() || ::World.FactionManager.getGreaterEvilStrength() < 15.0) {
			return;
		}

		if (_faction.getSettlements().len() < 6) {
			return;
		}

		if (_faction.getUnits().len() >= 10) {
			return;
		}

		this.m.Score = ::World.Assets.getOrigin().getID() == "scenario.legends_inquisition" ? 15 : 10;
	}

	o.onExecute = function (_faction) {
		local potential_origins = [];

		foreach (s in _faction.getSettlements()) {
			if (s.getLastSpawnTime() + this.getTimeBetweenSpawns() > ::Time.getVirtualTimeF()) {
				continue;
			}

			potential_origins.push({
				D = s,
				P = s.getResources()
			});
		}

		if (potential_origins.len() == 0) {
			return;
		}

		local origin = this.pickWeightedRandom(potential_origins);
		local myTile = origin.getTile();
		local activeContract = ::World.Contracts.getActiveContract();
		local settlements = ::World.EntityManager.getSettlements();
		local lowest_distance = 99999;
		local best_settlement;

		foreach (s in settlements) {
			if (activeContract != null && (activeContract.getHome().getID() == s.getID() || activeContract.getOrigin().getID() == s.getID())) {
				continue;
			}

			local d = myTile.getDistanceTo(s.getTile()) + (s.hasSituation("situation.razed") ? 20 : 0);
			if (d <= lowest_distance && !s.isIsolatedFromLocation(origin)) {
				if (s.isSouthern()) {
					local skip = true;

					foreach (l in s.getAttachedLocations()) {
						if (l.isActive() && l.isUsable()) {
							skip = false;
							break;
						}
					}

					if (skip) {
						continue;
					}
				}

				lowest_distance = d;
				best_settlement = s;
			}
		}

		if (best_settlement == null) {
			return;
		}

		local locations = best_settlement.getAttachedLocations();
		local targets = [];

		foreach (l in locations) {
			if (l.isActive() && l.isUsable()) {
				targets.push(l);
			}
		}

		local nearestUndead = this.getNearestLocationTo(origin, ::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).getSettlements());
		local difficulty = ::Math.rand(80, 120) * this.getScaledDifficultyMult() * ::Const.World.Scaling.getDistanceScaling(this, best_settlement.getTile(), true);
		local party = ::World.FactionManager.getFactionOfType(::Const.FactionType.Undead).spawnEntity(myTile, "Undead", false, ::Const.World.Spawn.UndeadScourge, difficulty);
		party.getSprite("banner").setBrush(nearestUndead.getBanner());
		party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
		party.setFootprintType(::Const.World.FootprintsType.Undead);
		party.setSlowerAtNight(false);
		party.setUsingGlobalVision(false);
		party.setLooting(false);
		party.getFlags().set("IsRandomlySpawned", true);
		party.getLoot().ArmorParts = ::Math.rand(0, 15);
		local c = party.getController();
		c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);

		if (targets.len() != 0) {
			local target = targets[::Math.rand(0, targets.len() - 1)];
			local move = ::new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local raid = ::new("scripts/ai/world/orders/raid_order");
			raid.setTime(40.0);
			raid.setTargetTile(target.getTile());
			c.addOrder(raid);
			local back = ::new("scripts/ai/world/orders/move_order");
			back.setDestination(myTile);
			c.addOrder(back);
			c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
		} else {
			local target = best_settlement;
			local move = ::new("scripts/ai/world/orders/move_order");
			move.setDestination(target.getTile());
			c.addOrder(move);
			local destroy = ::new("scripts/ai/world/orders/convert_order");
			destroy.setTime(60.0);
			destroy.setTargetTile(target.getTile());
			destroy.setTargetID(target.getID());
			c.addOrder(destroy);
			local back = ::new("scripts/ai/world/orders/move_order");
			back.setDestination(myTile);
			c.addOrder(back);
			c.addOrder(::new("scripts/ai/world/orders/despawn_order"));
		}

		return true;
	}
});
