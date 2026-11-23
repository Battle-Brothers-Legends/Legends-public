::mods_hookExactClass("factions/actions/send_military_army_action", function (o) {
	local create = o.create;
	o.create = function () {
		create();
		this.m.Cooldown = 120.0;
	}

	o.onExecute = function (_faction) {
		local potential_origins = [];

		foreach (s in _faction.getSettlements()) {
			if (!s.isMilitary()) {
				continue;
			}

			if (s.getLastSpawnTime() + 300.0 > this.Time.getVirtualTimeF()) {
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

		if (origin == null) {
            return;
        }

		local myTile = origin.getTile();
		local spawnpoints = [];
		spawnpoints.push(myTile);

		foreach (a in origin.getAttachedLocations()) {
			if (a.isActive() && a.isMilitary()) {
				spawnpoints.push(a.getTile());
			}
		}

		local activeContract = this.World.Contracts.getActiveContract();
		local settlements = this.World.EntityManager.getSettlements();
		local lowest_distance = 99999;
		local best_settlement;

		foreach (s in settlements) {
			if (s.isMilitary()) {
				continue;
			}

			if (this.World.FactionManager.isAllied(_faction.getID(), s.getFaction())) {
				continue;
			}

			if (activeContract != null	&& (activeContract.getHome().getID() == s.getID() || activeContract.getOrigin().getID() == s.getID()))	{
				continue;
			}

			if (this.World.FactionManager.isHolyWar() && s.getActiveAttachedLocations() == 0) {
				continue;
			}

			local d = myTile.getDistanceTo(s.getTile());

			if (s.hasSituation("situation.conquered")) {
				d = d + 10;
			}

			if (d <= lowest_distance && !s.isIsolatedFromLocation(origin)) {
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

		for (local i = 0; i != this.Math.min(2, spawnpoints.len()); i = ++i) {
			local party = this.getFaction().spawnEntity(spawnpoints[i], origin.getName() + " Company", true, this.Const.World.Spawn.Noble, this.Math.rand(80, 120) * this.getScaledDifficultyMult());
			party.getSprite("body").setBrush(party.getSprite("body").getBrush().Name + "_" + _faction.getBannerString());
			party.setDescription("Professional soldiers in service to local lords.");
			party.setFootprintType(this.Const.World.FootprintsType.Nobles);
			party.getFlags().set("IsRandomlySpawned", true);
			party.getLoot().Money = this.Math.rand(50, 200);
			party.getLoot().ArmorParts = this.Math.rand(0, 25);
			party.getLoot().Medicine = this.Math.rand(0, 3);
			party.getLoot().Ammo = this.Math.rand(0, 30);
			local r = this.Math.rand(1, 4);

			if (r == 1) {
				party.addToInventory("supplies/bread_item");
			} else if (r == 2) {
				party.addToInventory("supplies/roots_and_berries_item");
			} else if (r == 3) {
				party.addToInventory("supplies/dried_fruits_item");
			} else if (r == 4) {
				party.addToInventory("supplies/ground_grains_item");
			}

			local c = party.getController();

			if (targets.len() != 0) {
				local target = targets[this.Math.rand(0, targets.len() - 1)];
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(target.getTile());
				c.addOrder(move);
				local raid = this.new("scripts/ai/world/orders/raid_order");
				raid.setTime(40.0);
				raid.setTargetTile(target.getTile());
				c.addOrder(raid);
				local back = this.new("scripts/ai/world/orders/move_order");
				back.setDestination(spawnpoints[i]);
				c.addOrder(back);
				local despawn = this.new("scripts/ai/world/orders/despawn_order");
				c.addOrder(despawn);
			} else {
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local target = best_settlement;
				local move = this.new("scripts/ai/world/orders/move_order");
				move.setDestination(target.getTile());
				c.addOrder(move);
				local conquer = this.new("scripts/ai/world/orders/conquer_order");
				conquer.setTime(60.0);
				conquer.setTargetTile(target.getTile());
				c.addOrder(conquer);
				local despawn = this.new("scripts/ai/world/orders/despawn_order");
				c.addOrder(despawn);
			}
		}

		origin.setLastSpawnTimeToNow();
		return true;
	}
});
